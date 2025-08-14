/*
 * Copyright (c) 2016 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/linker/linker-defs.h>
#include <zephyr/drivers/gpio.h>


#define SLEEP_TIME_MS   1000

#define LED0_NODE DT_ALIAS(led0)

static const struct gpio_dt_spec led = GPIO_DT_SPEC_GET(LED0_NODE, gpios);

int main(void)
{
	printk("Address of sample %p\n", (void *)__rom_region_start);
	printk("Hello sysbuild with mcuboot! %s\n", CONFIG_BOARD);

	int ret;

	if (!device_is_ready(led.port)) {
		return -1;
	}

	ret = gpio_pin_configure_dt(&led, GPIO_OUTPUT_ACTIVE);
	if (ret < 0) {
		return -1;
	}

	while (1) {
		ret = gpio_pin_toggle_dt(&led);
		if (ret < 0) {
			return -1;
		}
		k_msleep(SLEEP_TIME_MS);
	}
}
