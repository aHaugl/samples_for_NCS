.. _SMP_BLE_DFU_feat_SPI:

SMP BLE DFU feat SPI for nRF52840DK
###########

Overview
********

A simple sample that can be used with the nRF52840DK showcasing how to set SPI as the transport 
between the MCU and the external flash instead of QSPI and to perform DFU over BLE where the secondary
application slot is located on the external flash

Building and Running
********************
Build for the nRF52840DK and flash your board. Make changes to the firmware and upload the app_update.bin 
to somewhere you can access it from with your mobile. 

Open up the nRF Connect application, scan for your device (you can change this in prj.conf) and Connect
Press the "DFU" button and uppload your new firmware. Mark it with verify and not test.

After power cycling you should now observe your new firmware running on the device.


## DFU over Bluetooth Low Energy

Install the [nRF Connect for Mobile app](https://www.nordicsemi.com/Products/Development-tools/nrf-connect-for-mobile) on a mobile phone.

Move build/zephyr/app\_update.bin and build/zephyr/net\_core\_app\_update.bin to your mobile phone.

Use the nRF Connect to connect to the DK:

![App Connect](../../.images/nrf_connect_app_connect.png)

Click the DFU button:

![App DFU](../../.images/nrf_connect_app_dfu.png)

Then select app\_update.bin or net\_core\_app\_update.bin upload it using "Confirm Only".

Lastly, reset the Developement Kit. The selected core will be updated.
```
nrfjprog --reset
```
