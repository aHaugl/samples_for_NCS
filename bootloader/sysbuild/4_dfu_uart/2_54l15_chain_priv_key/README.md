Sample with MCUBoot, NSIB, KMU and custom private key. Uses UART for DFU transport
###################

Overview
********

This is a simple example that demonstrates how building a sample using sysbuild can automatically include MCUboot as the bootloader companion component, NSIB as the first stage bootloader and use BLE as the transport for a FOTA update. The images are signed with a custom private key and public key is stored in the KMU.

> [!WARNING]
> THE KEYS IN THIS REPOSITORY MUST NOT BE USED FOR ANY PRODUCTION AND ARE ONLY PRESENT AS AN ILLUSTRATION. ANY USE OF THE KEYS PRESENT ARE AT YOUR OWN RISK. ALWAYS GENERATE YOUR OWN PRIVATE KEYS AND KEEP THEM SAFE, KEEP THEM SECRET!

Requirement
********
This sample is only tested for nrf54l15dk/nrf54l15/cpuapp. 

To run with nrf54l15dk/nrf54l15/cpuapp/ns:
* Cherry-pick https://github.com/nrfconnect/sdk-nrf/pull/25708 to NCS 3.2.0-preview 3 
* Add the following to  nrf/subsys/bootloader/KConfig:
'''
config SB_MONOTONIC_COUNTER_IS_ENABLED
    bool "Secure boot monotonic counter is enabled"
    default n
    help
      Sample text: Internal flag used by sysbuild to indicate that the secure boot
      monotonic counter is enabled.
      Normally this is set automatically by sysbuild; do not change
      it manually unless you know what you are doing.

config SB_MONOTONIC_COUNTER_ROLLBACK_PROTECTION
    bool "Secure boot monotonic counter rollback protection"
    default n
    help
      Sample text: Enables rollback protection using the secure boot monotonic counter.
      This is controlled by sysbuild; normally you do not need to change
      it manually.
'''
This sample:
* This sample uses static parititioning. 
* In generall follow the docs at https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/index.html.

In addition the sample also follows:
* This sample follows the steps from the academy pages for nRF54L15
* This sample follows the steps from KMU provisioning https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/kmu_provision.html4. https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/dfu_config.html 

The first prints are from b0, the second prints starting with  ``Booting Zephyr OS build`` is printed by MCUboot itself and the following lines are printed by the ``with_mcuboot`` sample.
This sample also prints its flash location.

Sysbuild specific settings
**************************

This sample automatically includes MCUboot as bootloader when built using
sysbuild.

This is achieved with a sysbuild specific Kconfig configuration,
:file:`sysbuild.conf`.

The ``SB_CONFIG_BOOTLOADER_MCUBOOT=y`` setting in the sysbuild Kconfig file
enables the bootloader when building with sysbuild.

The ``SB_CONFIG_SECURE_BOOT_APPCORE=y`` enables the first stage immutable bootloader

If you want external flash, see the samples in the bootloader repo with SPI configuration for the nRF54L15

We want to use the Key Management Unit on the device to manage our keys. To do so enable ``SB_CONFIG_MCUBOOT_SIGNATURE_USING_KMU=y``per the mentioned docs and 
``SB_CONFIG_BOOT_SIGNATURE_TYPE_ED25519=y`` & ``SB_CONFIG_BOOT_SIGNATURE_KEY_FILE`` is to specify the key type and which private key to use for MCUboot, and

Steps 
**************************
Key generation, building and testing

1. Follow the steps at https://docs.nordicsemi.com/bundle/ncs-latest/page/mcuboot/imgtool.html to generate a key. In this demo we will use ed25519 to generate a key with 'imgtool keygen -k my_ed25519_priv_key.pem -t ed25519'. Have this key ready for later.
2. Build the firmware for nrf54l15dk/nrf54l15/cpuapp or /cpuapp/ns if you've cherrypicked the fix mentioned above
3. nrfutil device erase && nrfutil device recover && nrfutil device flash
4. west ncs-provision upload -k keys/nsib_ed25519_priv_a.pem --keyname BL_PUBKEY -s nrf54l15 && west ncs-provision upload -k keys/mcuboot_ed25519_priv_a.pem --keyname UROT_PUBKEY -s nrf54l15

where``west ncs-provision upload -k keys/mcuboot_ed25519_priv_a.pem --keyname UROT_PUBKEY -s nrf54l15`` is for MCUBoot and ``west ncs-provision upload -k keys/nsib_ed25519_priv_a.pem --keyname BL_PUBKEY -s nrf54l15`` for NSIB

5. West flash --skip-rebuild
6. Build once more with the same key with modifications. Update the versioning and change a print statement.
6. Perform an update over UART per instructions in https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-1-dfu-over-uart/ 

