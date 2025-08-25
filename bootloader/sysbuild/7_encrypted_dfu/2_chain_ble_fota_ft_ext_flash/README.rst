Sample with MCUBoot, BLE FOTA, KMU, custom private key, external flash for 54l15 and encrypted DFU of application
###################

Overview
********

This is a simple example that demonstrates how building a sample using sysbuild can automatically include MCUboot as the bootloader companion component, NSIB as the first stage bootloader and use BLE as the transport for a FOTA update. The images are signed with a custom private key and public key is stored in the KMU.

Requirement
********
This sample requires you to modify loader.c per the git diff.

This sample:
* This sample uses static parititioning. 
* In generall follow the docs at https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/index.html.

In addition the sample also follows:
* This sample has added BLE FOTA support by following https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-5-fota-over-bluetooth-low-energy/ and https://github.com/nrfconnect/sdk-zephyr/tree/v3.7.99-ncs2/samples/subsys/mgmt/mcumgr/smp_svr 
* This sample follows the steps from the academy pages for nRF54L15, both w.r.t FOTA and w.r.t adding an external flash as well as https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/fota_update.html 
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

For flexibility with app size we also place the mcuboot secondary application slot on the external
flash after setting it up as shown in https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-3-dfu-with-external-flash/
``SB_CONFIG_PM_EXTERNAL_FLASH_MCUBOOT_SECONDARY=y`` & ``SB_CONFIG_PM_OVERRIDE_EXTERNAL_DRIVER_CHECK=y``-

We want to use the Key Management Unit on the device to manage our keys. To do so enable ``SB_CONFIG_MCUBOOT_SIGNATURE_USING_KMU=y``per the mentioned docs and 
``SB_CONFIG_BOOT_SIGNATURE_TYPE_ED25519=y`` & ``SB_CONFIG_BOOT_SIGNATURE_KEY_FILE`` is to specify the key type and which private key to use for MCUboot, and

``SB_CONFIG_BOOT_ENCRYPTION=y`` & ``SB_CONFIG_BOOT_ENCRYPTION_KEY_FILE="\${APP_DIR}/keys/x255519_enc_priv.pem"`` is to specify that we want to generate an encrypted dfu bin, 
with the specified key per the encrypted DFU docs for 54l15.

``SB_CONFIG_BOOT_ENCRYPTION=y`` & ``SB_CONFIG_BOOT_ENCRYPTION_KEY_FILE="\${APP_DIR}/keys/x255519_enc_priv.pem"`` is to specify that we want to generate an encrypted dfu bin, 
with the specified key per the encrypted DFU docs for 54l15.

Steps 
**************************
Key generation, building and testing

1. Follow the steps at https://docs.nordicsemi.com/bundle/ncs-latest/page/mcuboot/imgtool.html to generate a key. In this demo we will use ed25519 to generate a key with 'imgtool keygen -k my_ed25519_priv_key.pem -t ed25519'. Have this key ready for later.
2. Build the firmware for nrf54l15dk/nrf54l15/cpuapp
3. nrfutil erase --all 
3. Provision the KMU with the derived public key for MCUboot with https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/app_dev/device_guides/nrf54l/kmu_provision.html#provisioning_keys_to_the_board.

``west ncs-provision upload -k keys/ed25519_priv_key.pem --keyname UROT_PUBKEY -s nrf54l15`` and ``west ncs-provision upload -k keys/ed25519_priv_key.pem --keyname BL_PUBKEY -s nrf54l15`` for NSIB

4. Flash the firmware and see that it's running
5. Build once more with the same key with modifications. Update the versioning and change a print statement.
6. Perform an update of the app by uploading build/<your_app>/zephyr/zephyr.signed.encrypted.bin with by following the steps in https://academy.nordicsemi.com/courses/nrf-connect-sdk-intermediate/lessons/lesson-9-bootloaders-and-dfu-fota/topic/exercise-5-fota-over-bluetooth-low-energy/ 

