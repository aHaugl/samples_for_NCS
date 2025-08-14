Sysbuild bootloader and DFU samples
###################

Overview
********
This repository contains unofficial minimal samples for how to configure DFU for the version of nRF Connect SDK matching the tag you're browsing.

All samples are unofficial and "use as is on your own risk and modify as you need". 

The samples will not be maintained and updated regularly. 

For official bootloader samples and guides, please visit https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/ 

Tested versions of nRF Connect SDK for this tag:
NCS v2.9.0

Boards:
All samples work for the nrf52840dk. In cases where there exists overlays or other board files within the sample repositories, then the sample should also
work for those boards.

For samples using external flash: Please consult the datasheets to verify if you can use the QSPI variants or if you need to do 

Any other board is considered unsupported and adding support for them has to be done at your own leisure.


Useful documentation:
********
1. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/bootloaders_dfu/mcuboot_nsib/bootloader_adding_sysbuild.html
2. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/bootloaders_dfu/sysbuild_image_ids.html
3. https://docs.nordicsemi.com/bundle/ncs-2.9.0/page/nrf/app_dev/config_and_build/sysbuild/sysbuild_forced_options.html