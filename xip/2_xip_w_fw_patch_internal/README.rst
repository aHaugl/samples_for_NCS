.. _smp_svr_ext_xip:

nRF5340: SMP Server with external XIP and wifi fw patch relocation
#####################################

.. contents::
   :local:
   :depth: 2

This sample demonstrates how to split an application that partially resides on internal flash and Quad Serial Peripheral Interface (QSPI) flash by using Execute in place (XIP) and the Simple Management Protocol (SMP) server. 

This sample adds basic wifi features from the wifi shell sample.

This sample adds support for wifi firmware patch on external flash through https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/device_guides/nrf70/fw_patches_ext_flash.html 

Requirements
************

The sample supports the following development kits:   

nRF5340dk with a nrf7002 shield.

The sample requires a connection to a computer with :file:`mcumgr` command-line tool's or a compatible MCUmgr client tool.

Overview
********
The general sample description can be seen in ../1_extxip_smp_svr, which is again a fork of https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/samples/nrf5340/extxip_smp_svr/README.html 

The modifications to the extip_smp_svr for external flash storage of 

1. Enable SB_CONFIG_WIFI_PATCHES_EXT_FLASH_STORE and set CONFIG_NRF_WIFI_FW_FLASH_CHUNK_SIZE 
2. Add 

```
&flash0 {
    partitions {
        compatible = "fixed-partitions";
        #address-cells = <1>;
        #size-cells = <1>;
        nrf70_fw_partition: partition@0 {
            label = "nrf70_fw_partition";
            reg = <0x00000000 DT_SIZE_K(128)>;
        };
    };
};
```
3. Create a partition in pm_static that does not collide with xip region or any other defined regions

```
EMPTY_2:
  address: 0x1a0000
  device: MX25R64
  end_address: 0x1ac000
  region: external_flash
  size: 0xc000
nrf70_wifi_fw:
  address: 0x1ac000
  size: 0x20000
  device: MX25R64
  region: external_flash  
```

Building and running
********************

.. |sample path| replace:: :file:`samples/nrf5340/extxip_smp_svr`
.. include:: /includes/build_and_run.txt

.. parsed-literal::
   :class: highlight

   west build -b nrf5340dk/nrf5340/cpuapp -- -DSHIELD=nrf7002ek

To upload MCUboot and a bundle of images to the nRF5340 SoC, use the ``west flash`` command.

Testing
=======

The ``smp_svr`` app is now ready to run.
Reset your board and test the app with the :file:`mcumgr` command-line tool's ``echo`` functionality.
This will send a string to the remote target device and have it echo it back:

      .. code-block:: console

         mcumgr --conntype serial --connstring "/dev/ttyACM2,baud=115200" echo hello
         hello

.. note::
   The :file:`mcumgr` command-line tool requires a connection string in order to identify the remote target device.

   In the following sections, ``<connection string>`` is used to represent the ``--conntype <type>`` and ``--connstring=<string>`` :file:`mcumgr` parameters.

Upload and map image to MCUboot slot
------------------------------------

For this sample configuration, MCUmgr supports the uploading of three target images, which allows you to update all parts of the firmware.

The MCUmgr ``image upload`` command has the optional ``-e -n <image>`` parameter, which lets you select the target image for upload.
When this parameter is not provided, ``0`` is assumed (interpreted as the default behavior), and MCUmgr uploads to ``image-1`` (MCUboot's secondary slot).

See the Partition manager (PM) label for slot-to-``<image>`` translation:

    +-------------------------+--------+-------------+---------------------------+
    | PM label                | Slot   | -n <image>  |       Firmware part       |
    +=========================+========+=============+===========================+
    | ``mcuboot_secondary``   | slot-1 |     0       | Internal application part |
    +-------------------------+--------+-------------+---------------------------+
    | ``mcuboot_secondary_1`` | slot-3 |     1       | Networking                |
    +-------------------------+--------+-------------+---------------------------+
    | ``mcuboot_secondary_2`` | slot-5 |     2       | QSPI application part     |
    +-------------------------+--------+-------------+---------------------------+

.. note::

   The ``-e`` option means "no erase", and is provided to the MCUmgr to prevent it from sending the erase command to the target before updating the image.
   This option is always needed when ``-n`` is used for image selection, as the erase command is hardcoded to erase slot-1 (``image-1``), regardless of which slot is uploaded at the time.

Upload the signed image
-----------------------

To upload the signed image, run the following command:

.. code-block:: console

   sudo mcumgr <connection string> image upload build/zephyr/<signed_upload.bin> -e -n <image>

Adjust the command depending on the case:

* Use the :file:`internal_flash_update.bin` file and ``<image> = 0`` to update the internal application image.
* Use the :file:`net_core_app_update.bin` file and ``<image> = 1`` to update the networking core image.
* Use the :file:`qspi_flash_update.bin` file and ``<image> = 2`` to update the QSPI application image.

.. note::

   The ``<image>`` values correspond to the internally (``0``) and externally (``2``) linked parts of the application.
   These two images are linked and must always be uploaded together.

Test the image
^^^^^^^^^^^^^^

To initiate the image swap with MCUboot, first you must test the image by obtaining its SHA with the following command:

.. code-block:: console

   imgtool verify build/zephyr/<signed_upload.bin>

Ensure it boots using the image digest fetched by running the following command:

.. code-block:: console

   sudo mcumgr <connection string> image test <hash of image>

The selected mode in this test case must be applied to all images that constitute the complete application.
Once applied, MCUboot will swap these images during the next reset.

.. note::

   The sample supports the MCUboot overwrite-only mode.
   This means that regardless of how the image is marked for the update (either as ``test`` or ``confirm``), the process is not affected.
   The old image is still overwritten by the content of the incoming image during the firmware update process.

Reset remotely
--------------

To check how MCUboot has upgraded the images, you can reset the device remotely by running the following command:

.. code-block:: console

   sudo mcumgr <connection string> reset

Dependencies
************

The sample uses the following Zephyr library:

* :ref:`zephyr:mcu_mgr`

It also uses the following |NCS| library:

* :ref:`partition_manager`
