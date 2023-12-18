.. _hello_world:

Serial recovery + NSIB
###########

Overview
********

A simple sample that can be used with any :ref:`supported board <boards>` as a foundation for an application with serial recovery support and NSIB

Building and Running
********************

This application can be built and executed on QEMU as follows:

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :host-os: unix
   :board: qemu_x86
   :goals: run
   :compact:

To build for another board, change "qemu_x86" above to that board's name.


**Requirements:

* nRF Connect SDK v2.5.0
* nRF52840DK

The application features

* Serial recovery over UART
* NSIB & updatable bootloader
* A static_pm.yml where mcuboot primary and secondary has been defined with different non-equal sizes. The sizes has been chosen arbitrarily w.r.t ratios, and is only meant as a sample to showcase that this works with different sized partitions. You can customize them as you see fit given that you do it according to the static partitioning documentation.

What you can do with this app

* Enter serial recovery mode to directly upload the new application firmware to mcuboot primary application slot and overwrite the existing firmware. 
    * This means that you can modify the pm_static.yml to create an primary application slot that uses almost all of the available internal flash as long as there still is a secondary mcuboot partition that can fit the new Mcuboot update image for s0/s1
* Update the bootloader by uploading the new firmware image to the smaller mcuboot secondary partition, confirm and reset

You can update the bootloader, the application or both in any order you need as long as the pm_static.yml has not been changed in between the revisions you're going to update.

If you wish to make modifications instead of using the prebuilt firmware in build_v1 and build_v2 do the following:

1. Build and flash the project
2. Increment the firmware version in child_image/mcuboot.conf
3. Make changes to the application if your new firmware needs application changes
4. And/or make change to $NRF_CONNECT_SDK/bootloader/mcuboot/boot/zephyr/main.c, for instance add a log
5. Build, do not flash
6. Follow the steps below to perform the updates

**Below I will give you the steps to recreate this using the prebuilt firmware.

Updating the application:

I've predefined my conn as acm0 following the steps in docs.zephyrproject.org/.../mcumgr.html

1. Erase everything using
    a. nrfjprog -e
2. Flash the firmware through cmd from the project folder
    a. west flash -d build_v1 --skip-rebuild --recover
3. Connect to a serial terminal and observe that you boot from slot 0 and that the print output is what you've added to your application
4. Disconnect from the serial terminal
5. Hold DK BTN 1 and press the reset button to enter serial recovery mode
6. Observe that LED1 is lighting
7. In cmd list your images so you see what's present before the upload
    a. mcumgr -c acm0 image list
8. Upload the new firmware
    a. mcumgr -c acm0 image upload build_v2/zephyr/app_update.bin -e -n0
9. List once more and observe that the new image is in image=0 slot =0 with flags "active confirmed", i.e it has overwritten the previous firmware which in my case ends with ...a55722 and instead uses _v2 which ends with ...a6238  
    a. mcumgr -c acm0 image list
10. Connect to a serial terminal
11. Reset the board
    a. nrfjprog --reset
12. Observe that the DK boots with the "updated version" print




**Updating the bootloader

If you're starting here, then you need to do the first step of adding the conn to acm0. The output here are after I've updated the application in the previous steps

1. Disconnect from the serial output
2. Check the images
    a. mcumgr -c acm0 image list
3. Upload the new bootloader image from build_v2. Since we're in _v1 are using s0 for our bootloader, we need to upload the s1-image.
    a. mcumgr -c acm0 image upload build_v2/zephyr/signed_by_mcuboot_and_b0_s1_image_update.bin -e -n2
4. List the images. Observe that the new bootloader image is in the slot corresponding to mcuboot_secondary application
    a. mcumgr -c acm0 image list
5. Confirm the new bootloader and observe that the bin in image 0 slot 1 is now flagged "pending permanent" and is ready for update
    a. mcumgr -c acm0 image confirm 
6. Connect to a serial terminal
7. Restart the device and wait a while until the update has gone through
    a. nrfjprog --reset
8. Reset the device once more and observe that it now boots from s1 

