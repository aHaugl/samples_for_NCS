Sample with USB UART DFU with flash optimized MCUboot 
###################

Overview
********
This is a simple sample showcasing how to set up single bank serial recovery DFU using sysbuild and using sysbuild to automatically include MCUboot as the
bootloader companion image. It uses USB as the transport and the MCUboot image is flash optimized by disabling non-necessary features as well ase uses LTO.

The sample is based on the solution of lesson 9, exercise 4 of the nrf-connect-sdk-intermediate https://github.com/NordicDeveloperAcademycd /ncs-inter/tree/main/v2.9.0-v2.7.0/l9/l9_e4_sol 

This sample:
* Uses the default signing key, so if you intend to use this for your own purpose please go through steps to add your own custom key. 
* This sample uses dynamical parititioning. 

Steps to perform DFU:
********
1. Follow the steps at https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-4-dfu-over-usb/ 

