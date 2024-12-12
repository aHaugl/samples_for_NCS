.. _with_mcuboot:

Sample with MCUboot and NSIB
###################

Overview
********
Disclaimer: This sample is an unofficial sample and has not been tested per standars for a 
sample within the nRF Connect SDK. It is as all other samples in this repository "use on own risk"
and modify it as per your requirements.

This is a simple example that demonstrates how building a sample using sysbuild can
automatically include MCUboot as the bootloader companion image as well as adding b0 for an uppdatable bootloader.
This sample is modified from <ncs v2.8.0>/zephyr/samples/sysbuild/with_mcuboot.

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

The :file:`sysbuild/mcuboot.conf` file will be used as an extra fragment that
is merged together with the default configuration files used by MCUboot.

:file:`sysbuild/mcuboot.conf` adjusts the log level in MCUboot, as well as
configures MCUboot to prevent downgrades and operate in upgrade-only mode.

The first ``Booting Zephyr OS build`` is printed by MCUboot itself and the
following lines are printed by the ``with_mcuboot`` sample.
This sample also prints its flash location.
