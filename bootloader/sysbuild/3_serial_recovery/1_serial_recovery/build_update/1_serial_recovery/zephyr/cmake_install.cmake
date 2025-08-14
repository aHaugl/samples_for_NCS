# Install script for directory: C:/ncs/sdk/zephyr

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/Zephyr-Kernel")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "MinSizeRel")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/ncs/toolchains/b620d30767/opt/zephyr-sdk/arm-zephyr-eabi/bin/arm-zephyr-eabi-objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/arch/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/lib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/soc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/boards/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/subsys/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/drivers/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/nrf/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/mcuboot/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/mbedtls/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/trusted-firmware-m/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/cjson/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/azure-sdk-for-c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/cirrus-logic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/openthread/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/suit-processor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/memfault-firmware-sdk/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/canopennode/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/chre/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/lz4/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/nanopb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/zscilib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/cmsis/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/cmsis-dsp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/cmsis-nn/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/fatfs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/hal_nordic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/hal_st/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/hal_wurthelektronik/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/hostap/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/libmetal/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/liblc3/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/littlefs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/loramac-node/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/lvgl/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/mipi-sys-t/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/nrf_wifi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/open-amp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/picolibc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/segger/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/tinycrypt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/uoscore-uedhoc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/zcbor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/nrfxlib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/nrf_hw_models/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/modules/connectedhomeip/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/kernel/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/cmake/flash/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/cmake/usage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/2_serial_recovery/1_serial_recovery/build_update/1_serial_recovery/zephyr/cmake/reports/cmake_install.cmake")
endif()

