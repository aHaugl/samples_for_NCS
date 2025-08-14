/*
 * Copyright (c) 2016 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>

/* Step 5.4 - Include header for usb */
#include <zephyr/usb/usb_device.h>

#include <zephyr/kernel.h>
#include <stdio.h>
#include <stdlib.h>

#include <zephyr/net/wifi.h>
#include <zephyr/net/wifi_mgmt.h>
#include <zephyr/net/net_mgmt.h>
#include <net/wifi_mgmt_ext.h>

#define SLEEP_TIME_MS   1000

/* The devicetree node identifier for the "led0" alias. */
#define LED0_NODE DT_ALIAS(led0)

#define WIFI_MGMT_EVENTS (NET_EVENT_WIFI_CONNECT_RESULT |		\
				NET_EVENT_WIFI_DISCONNECT_RESULT)

static struct net_mgmt_event_callback wifi_mgmt_cb;

static bool connected;
static K_SEM_DEFINE(run_wifi, 0, 1);

static const struct gpio_dt_spec led = GPIO_DT_SPEC_GET(LED0_NODE, gpios);

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


int main(void)
{
	int ret;

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

	ret = usb_enable(NULL);
	if (ret) {
	return 0;
	}
	if (!device_is_ready(led.port)) {
		return 0;
	}

	ret = gpio_pin_configure_dt(&led, GPIO_OUTPUT_ACTIVE);
	if (ret < 0) {
		return 0;
	}

	while (1) {
		ret = gpio_pin_toggle_dt(&led);
		if (ret < 0) {
			return 0;
		}
		k_msleep(SLEEP_TIME_MS);
	}
	return 1;
}
