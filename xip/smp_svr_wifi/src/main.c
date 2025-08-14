/*
 * Copyright (c) 2012-2014 Wind River Systems, Inc.
 * Copyright (c) 2020 Prevas A/S
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/stats/stats.h>
#include <zephyr/usb/usb_device.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef CONFIG_MCUMGR_GRP_FS
#include <zephyr/device.h>
#include <zephyr/fs/fs.h>
#include <zephyr/fs/littlefs.h>
#endif
#ifdef CONFIG_MCUMGR_GRP_STAT
#include <zephyr/mgmt/mcumgr/grp/stat_mgmt/stat_mgmt.h>
#endif

#define LOG_LEVEL LOG_LEVEL_DBG
#include <zephyr/logging/log.h>
LOG_MODULE_REGISTER(smp_sample);

#include "common.h"

#ifdef CONFIG_WIFI
#include <zephyr/net/wifi.h>
#include <zephyr/net/wifi_mgmt.h>
#include <zephyr/net/net_mgmt.h>
#include <net/wifi_mgmt_ext.h>


#define WIFI_MGMT_EVENTS (NET_EVENT_WIFI_CONNECT_RESULT |		\
				NET_EVENT_WIFI_DISCONNECT_RESULT)

static struct net_mgmt_event_callback wifi_mgmt_cb;

static bool connected;
static K_SEM_DEFINE(run_wifi, 0, 1);

static void wifi_mgmt_event_handler(struct net_mgmt_event_callback *cb,
			  uint32_t mgmt_event, struct net_if *iface)
{
	switch (mgmt_event) {
	case NET_EVENT_WIFI_CONNECT_RESULT:
		LOG_INF("Network connected");
		connected = true;
		k_sem_give(&run_wifi);
		break;
	case NET_EVENT_WIFI_DISCONNECT_RESULT:
		if (connected == false) {
			LOG_INF("Waiting for network to be connected");
		} else {
			LOG_INF("Network disconnected");
			connected = false;
		}
		k_sem_reset(&run_wifi);
		break;
	default:
		break;
	}
}

static int wifi_args_to_params(struct wifi_connect_req_params *params)
{
	params->ssid = CONFIG_WIFI_CREDENTIALS_STATIC_SSID;
	params->ssid_length = strlen(params->ssid);

	params->psk = CONFIG_WIFI_CREDENTIALS_STATIC_PASSWORD;
	params->psk_length = strlen(params->psk);

	params->channel = WIFI_CHANNEL_ANY;
	params->security = WIFI_SECURITY_TYPE_PSK;
	params->mfp = WIFI_MFP_OPTIONAL;
	params->timeout = SYS_FOREVER_MS;
	params->band = WIFI_FREQ_BAND_UNKNOWN;
	memset(params->bssid, 0, sizeof(params->bssid));
	return 0;
}
#endif

#define STORAGE_PARTITION_LABEL	storage_partition
#define STORAGE_PARTITION_ID	FIXED_PARTITION_ID(STORAGE_PARTITION_LABEL)

/* Define an example stats group; approximates seconds since boot. */
STATS_SECT_START(smp_svr_stats)
STATS_SECT_ENTRY(ticks)
STATS_SECT_END;

/* Assign a name to the `ticks` stat. */
STATS_NAME_START(smp_svr_stats)
STATS_NAME(smp_svr_stats, ticks)
STATS_NAME_END(smp_svr_stats);

/* Define an instance of the stats group. */
STATS_SECT_DECL(smp_svr_stats) smp_svr_stats;

#ifdef CONFIG_MCUMGR_GRP_FS
FS_LITTLEFS_DECLARE_DEFAULT_CONFIG(cstorage);
static struct fs_mount_t littlefs_mnt = {
	.type = FS_LITTLEFS,
	.fs_data = &cstorage,
	.storage_dev = (void *)STORAGE_PARTITION_ID,
	.mnt_point = "/lfs1"
};
#endif

int main(void)
{
#ifdef CONFIG_WIFI
	struct wifi_connect_req_params cnx_params;

	struct net_if *iface = net_if_get_first_wifi();
	if (iface == NULL) {
		LOG_ERR("Returned network interface is NULL");
		return -1;
	}

	/* Sleep to allow initialization of Wi-Fi driver */
	k_sleep(K_SECONDS(1));

	net_mgmt_init_event_callback(&wifi_mgmt_cb, wifi_mgmt_event_handler, WIFI_MGMT_EVENTS);
	net_mgmt_add_event_callback(&wifi_mgmt_cb);

	wifi_args_to_params(&cnx_params);

	LOG_INF("Connecting to Wi-Fi");
	int err = net_mgmt(NET_REQUEST_WIFI_CONNECT, iface, &cnx_params, sizeof(struct wifi_connect_req_params));
	if (err) {
		LOG_ERR("Connecting to Wi-Fi failed, err: %d", err);
		return ENOEXEC;
	}

	k_sem_take(&run_wifi, K_FOREVER);
#endif
	int rc = STATS_INIT_AND_REG(smp_svr_stats, STATS_SIZE_32,
				    "smp_svr_stats");

	if (rc < 0) {
		LOG_ERR("Error initializing stats system [%d]", rc);
	}

	/* Register the built-in mcumgr command handlers. */
#ifdef CONFIG_MCUMGR_GRP_FS
	rc = fs_mount(&littlefs_mnt);
	if (rc < 0) {
		LOG_ERR("Error mounting littlefs [%d]", rc);
	}
#endif

#ifdef CONFIG_MCUMGR_TRANSPORT_BT
	start_smp_bluetooth_adverts();
#endif

	if (IS_ENABLED(CONFIG_USB_DEVICE_STACK)) {
		rc = usb_enable(NULL);

		/* Ignore EALREADY error as USB CDC is likely already initialised */
		if (rc != 0 && rc != -EALREADY) {
			LOG_ERR("Failed to enable USB");
			return 0;
		}
	}
	/* using __TIME__ ensure that a new binary will be built on every
	 * compile which is convenient when testing firmware upgrade.
	 */
	LOG_INF("build time: " __DATE__ " " __TIME__);

	/* The system work queue handles all incoming mcumgr requests.  Let the
	 * main thread idle while the mcumgr server runs.
	 */
	while (1) {
		k_sleep(K_MSEC(1000));
		STATS_INC(smp_svr_stats, ticks);
	}
	return 0;
}
