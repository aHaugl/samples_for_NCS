Sysbuild bootloader and DFU samples
###################

Overview
********
This repository contains unofficial minimal samples for how to configure DFU, XIP and/or Wifi firmware patch offload for the version of nRF Connect SDK matching the tag you're browsing.

All samples are unofficial and "use as is on your own risk and modify as you need". All samples in this repository is based on nrf/samples/nrf5340/extxip_smp_svr.

The samples will not be maintained and updated regularly. 

For official bootloader samples and guides, please visit https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/ 

Tested versions of nRF Connect SDK for this tag:
NCS v2.9.0

Boards:
The samples within XIP only works for nrf5340dk together with the nrf7002 shield. In cases where there exists overlays or other board files within the sample repositories, then the sample should also
work for those boards. See https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/device_guides/nrf70/fw_patches_ext_flash.html 



Useful documentation:
********
1. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/device_guides/nrf53/qspi_xip_guide_nrf5340.html
2. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/samples/nrf5340/extxip_smp_svr/README.html
3. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/device_guides/nrf70/fw_patches_ext_flash.html 
4. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/bootloaders_dfu/mcuboot_nsib/bootloader_adding_sysbuild.html
5. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/bootloaders_dfu/sysbuild_image_ids.html
6. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/config_and_build/sysbuild/sysbuild_forced_options.html
7. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/test_and_optimize/optimizing/index.html 