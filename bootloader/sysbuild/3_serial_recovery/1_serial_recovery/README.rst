Sample with MCUboot and serial recovery DFU
###################

Overview
********
This is a simple sample showcasing how to set up single bank serial recovery DFU using sysbuild and using sysbuild to automatically include MCUboot as the
bootloader companion image.

The sample has followed the steps under https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/bootloaders_dfu/mcuboot_nsib/bootloader_adding_sysbuild.html
for adding a 

This sample:
* Uses the default signing key, so if you intend to use this for your own purpose please go through steps to add your own custom key. 
* This sample uses dynamical parititioning. Expected partitioning can be found in 'generated_partitions.txt'
* This sample does showcase how to add any transport for DFU, meaning you can use this as a foundation for the transport you wish to use.

Expected output from RTT terminal:
Booting nRF Connect SDK v2.9.0-7787b2649840 ***
*** Using Zephyr OS v3.7.99-1f8f3dc29142 ***
build time: Jan 28 2025 12:12:15
Single bank serial recovery with sysbuild for build target nrf52840dk

Expected output from step 7: List the current images with 'mcumgr -c testDK image list'
Images:
 image=0 slot=0
    version: 0.0.0
    bootable: false
    flags: 
    hash: 59947af60569a6512f303d69047cc875efd662c5834a4990f640b96e9923ef0e
Split status: N/A (0)

Expected output from step 8: Navigate to your project folder in the same cmd and upload the new image with 'mcumgr -c acm0 image upload build_update/1_serial_recovery/zephyr/zephyr.signed.bin'
6.93 KiB / 42.01 KiB [====================>-------------------------------------------------------------------------------------------------------]  16.50% 3.14 KiB/s 00m11s


Steps to perform DFU:
********
1. Follow the exercise prerequisites from https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-8-bootloaders-and-dfu-fota/topic/exercise-1-dfu-over-uart/ to set up mcumgr-cli
2. Build the firmware and flash it on your DK/supported board. Verify that the expected output from terminal is displayed.
3. Build a new version of the firmware without flashing. Make sure it has a change from the initial build. printk("build time: " __DATE__ " " __TIME__ "\n"); makes sure this happens.
4. Check which COM port you're using either through VS Code extension for nRF Connect SDK, nRF Connect Serial Terminal, or through 'nrfjprog --com'
5. Add the device with 'mcumgr conn add acm0 type="serial" connstring="<your com port>,baud=115200,mtu=512", where you replace <your com port> with for instance COM36.
6. Make sure you're device is not occupied by any serial terminal and enter serial recovery mode by holding button 2 and press RESET simultaneously
7. List the current images with 'mcumgr -c testDK image list'

Do either:
8. Navigate to your project folder in the same cmd and upload the new image with 'mcumgr -c acm0 image upload build_update/1_serial_recovery/zephyr/zephyr.signed.bin'
9. Unzip build_update/dfu_application.zip and upload the signed bin that you extracted with the same command as step 8, but replace the file name.
10. Reset the DK and connect to a serial terminal. Observe the new image running. Expected result, similar to step 2 with new build time stamp.

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

The ``SB_CONFIG_MCUBOOT_MODE_SINGLE_APP=y`` setting in the sysbuild Kconfig file
enables the secure bootloader when building with sysbuild. Replaces the Kconfig "CONFIG_SINGLE_APPLICATION_SLOT".

The :file:`sysbuild/mcuboot.conf` file will be used as an extra fragment that
is merged together with the default configuration files used by MCUboot.

:file:`sysbuild/mcuboot.conf` adjusts the log level in MCUboot, as well as
configures MCUboot to prevent downgrades and operate in upgrade-only mode.

