/*
 * Copyright (c) 2020 Peter Bigot Consulting, LLC
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/flash.h>
#include <jesd216.h>
#include <stdio.h>
#include <inttypes.h>
#include <string.h>

#include "bluetooth_smp.h"

int main(void)
{
	printf("Hello World! %s\n", CONFIG_BOARD);
	printf("Sample for BLE DFU feat SPI and external flash!\n");
	start_smp_bluetooth();
	printk("This is version 2.\n");
	

	return 0;
}
