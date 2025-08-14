.. zephyr:code-sample:: with_mcuboot
   :name: MCUboot with sysbuild

   Build a Zephyr application + MCUboot using sysbuild.

Overview
********
This sample is a direct copy of the <ncs v2.9.0>/zephyr/samples/sysbuild/with_mcuboot

A simple example that demonstrates how building a sample using sysbuild can
automatically include MCUboot as the bootloader.
It showcases how the sample can adjust the configuration of extra image by
creating a image specific Kconfig fragment.

This is a simple example that demonstrates how building a sample using sysbuild can
automatically include MCUboot as the bootloader companion image as well as adding b0 for an uppdatable bootloader.
This sample is modified from <ncs v2.8.0>/zephyr/samples/sysbuild/with_mcuboot.

The sample has followed the steps under https://docs.nordicsemi.com/bundle/ncs-2.8.0/page/nrf/app_dev/bootloaders_dfu/mcuboot_nsib/bootloader_adding_sysbuild.html
for adding a bootloader chain using sysbuild.

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using
sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

The :file:`sysbuild/mcuboot.conf` file will be used as an extra fragment that
is merged together with the default configuration files used by MCUboot.

:file:`sysbuild/mcuboot.conf` adjusts the log level in MCUboot, as well as
configures MCUboot to prevent downgrades and operate in upgrade-only mode.

To build both the sample and MCUboot with ``west`` for the ``reel_board``, run:

.. zephyr-app-commands::
   :tool: west
   :zephyr-app: samples/sysbuild/with_mcuboot
   :board: reel_board
   :goals: build
   :west-args: --sysbuild
   :compact:

Execution output:

.. code-block:: console

   *** Booting Zephyr OS build v3.2.0-rc3-209-gdcf4201d3573  ***
   *** Booting Zephyr OS build v3.2.0-rc3-209-gdcf4201d3573  ***
   Address of sample 0xc000
   Hello sysbuild with mcuboot! nrf52840dk

The first ``Booting Zephyr OS build`` is printed by MCUboot itself and the
following lines are printed by the ``with_mcuboot`` sample.
This sample also prints its flash location.
