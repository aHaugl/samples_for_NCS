Sample with MCUBoot and BLE FOTA
###################

Overview
********

This is a simple example that demonstrates how building a sample using sysbuild can automatically include MCUboot as the bootloader companion component and 
use BLE as the transport for a FOTA update. The 

This sample:
* Uses the default signing key, so if you intend to use this for your own purpose please go through steps to add your own custom key. 
* This sample uses dynamical parititioning. 
* This sample has added BLE FOTA support by following https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-5-fota-over-bluetooth-low-energy/ and https://github.com/nrfconnect/sdk-zephyr/tree/v3.7.99-ncs2/samples/subsys/mgmt/mcumgr/smp_svr 
* This sample is not configured for multi-core applications. See the 5340 specific sample for this.

The first ``Booting Zephyr OS build`` is printed by MCUboot itself and the
following lines are printed by the ``with_mcuboot`` sample.
This sample also prints its flash location.

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using
sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

