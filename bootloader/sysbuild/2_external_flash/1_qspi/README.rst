Sample with MCUboot featuring external flash over QSPI for secondary mcuboot partition
###################

Overview
********
This is a simple example that demonstrates how building a sample using sysbuild can automatically include MCUboot as the bootloader companion image.

Requirements: A nRF DK that supports QSPI and has an onboard external flash. 

This sample:
* Uses the default signing key, so if you intend to use this for your own purpose please go through steps to add your own custom key. 
* Uses dynamical parititioning. Expected partitioning can be found in 'generated_partitions.txt'

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using
sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

The ``SB_CONFIG_PM_EXTERNAL_FLASH_MCUBOOT_SECONDARY=y`` setting in the sysbuild Kconfig file
enables the secondary applicaiton partition to be located on external flash building with sysbuild. 
Described https://docs.nordicsemi.com/bundle/ncs-2.8.0/page/nrf/app_dev/config_and_build/sysbuild/sysbuild_forced_options.html 