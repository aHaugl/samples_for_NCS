/*
 * Copyright (c) 2012-2014 Wind River Systems, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */



/* Step 2.1 Include the pwm header */
#include <zephyr/drivers/pwm.h>


#include <zephyr/kernel.h>

/* Step 1.3 add the logging module */
#include <zephyr/logging/log.h>
#define LOG_MODULE_NAME main
LOG_MODULE_REGISTER(LOG_MODULE_NAME);




int main(void)
{
	printk("Hello World! %s\n", CONFIG_BOARD);
	return 0;
}
