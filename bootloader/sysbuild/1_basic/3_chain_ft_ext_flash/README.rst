Sample with MCUboot and NSIB featuring external flash for secondary mcuboot partition
###################

Overview
********
This is a simple example that demonstrates how building a sample using sysbuild can
automatically include MCUboot as the bootloader companion image as well as adding b0 for an uppdatable bootloader.
This sample is modified from <bootloader_chain> within this git repository.

The sample has followed the steps under https://docs.nordicsemi.com/bundle/ncs-2.8.0/page/nrf/app_dev/bootloaders_dfu/mcuboot_nsib/bootloader_adding_sysbuild.html
for adding a bootloader chain using sysbuild.

This sample:
* Uses the default signing key, so if you intend to use this for your own purpose please go through steps to add your own custom key. 
* This sample uses dynamical parititioning. Expected partitioning can be found in 'generated_partitions.txt'
* This sample does showcase how to add any transport for DFU, meaning you can use this as a foundation for the transport you wish to use.

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using
sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

The ``SB_CONFIG_SECURE_BOOT_APPCORE=y`` setting in the sysbuild Kconfig file
enables the secure bootloader when building with sysbuild. Described https://docs.nordicsemi.com/bundle/ncs-2.8.0/page/nrf/app_dev/config_and_build/sysbuild/sysbuild_images.html


The ``SB_CONFIG_PM_EXTERNAL_FLASH_MCUBOOT_SECONDARY=y`` setting in the sysbuild Kconfig file
enables the secondary applicaiton partition to be located on external flash building with sysbuild. 
Described https://docs.nordicsemi.com/bundle/ncs-2.8.0/page/nrf/app_dev/config_and_build/sysbuild/sysbuild_forced_options.html 

The :file:`sysbuild/mcuboot.conf` file will be used as an extra fragment that
is merged together with the default configuration files used by MCUboot.

:file:`sysbuild/mcuboot.conf` adjusts the log level in MCUboot, as well as
configures MCUboot to prevent downgrades and operate in upgrade-only mode.

The first ``Booting Zephyr OS build`` is printed by MCUboot itself and the
following lines are printed by the ``with_mcuboot`` sample.
This sample also prints its flash location.
