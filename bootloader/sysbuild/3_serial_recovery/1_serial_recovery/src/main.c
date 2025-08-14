/*
 * Copyright (c) 2022 Nordic Semiconductor
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
	int ret;

	
	if (!device_is_ready(led.port)) {
		return 0;
	}
	ret = gpio_pin_configure_dt(&led, GPIO_OUTPUT_ACTIVE);
	if (ret < 0) {
		return 0;
	}
	printk("build time: " __DATE__ " " __TIME__ "\n");
	printk("Single bank serial recovery with sysbuild for build target %s\n", CONFIG_BOARD);
	while (1) {
		ret = gpio_pin_toggle_dt(&led);
		if (ret < 0) {
			return 0;
		}
		k_msleep(SLEEP_TIME_MS);
	}
	return 1;
}
