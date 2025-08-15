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
    set(CMAKE_INSTALL_CONFIG_NAME "")
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
  set(CMAKE_OBJDUMP "C:/ncs/toolchains/0b393f9e1b/opt/zephyr-sdk/arm-zephyr-eabi/bin/arm-zephyr-eabi-objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/arch/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/lib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/soc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/boards/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/subsys/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/drivers/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/nrf/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/hostap/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/mcuboot/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/mbedtls/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/trusted-firmware-m/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/cjson/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/azure-sdk-for-c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/cirrus-logic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/openthread/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/suit-processor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/memfault-firmware-sdk/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/canopennode/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/chre/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/lz4/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/nanopb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/zscilib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/cmsis/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/cmsis-dsp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/cmsis-nn/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/fatfs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/hal_nordic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/hal_st/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/hal_tdk/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/hal_wurthelektronik/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/liblc3/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/libmetal/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/littlefs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/loramac-node/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/lvgl/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/mipi-sys-t/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/nrf_wifi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/open-amp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/percepio/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/picolibc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/segger/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/tinycrypt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/uoscore-uedhoc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/zcbor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/nrfxlib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/nrf_hw_models/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/modules/connectedhomeip/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/kernel/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/cmake/flash/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/cmake/usage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/ncs/my_projects/samples_for_NCS/bootloader/sysbuild/1_basic/2_chain/build52840/2_chain/zephyr/cmake/reports/cmake_install.cmake")
endif()

