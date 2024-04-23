e.. zephyr:code-sample:: settings
   :name: Settings API
   :relevant-api: settings settings_rt settings_name_proc

   Load and save configuration values using the settings API.

Overview
********
This is a modification of the Zephyr settings sample that showcases how to set up so that the settings_partition is located at the end of 
the flash area and including a custom NVS partition in between MCUboot and the application slots.


.. code-block:: console
      flash_primary (0x100000 - 1024kB):
    +-------------------------------------------------+
    | 0x0: mcuboot (0xc000 - 48kB)                    |
    | 0xc000: custom_data_storage (0x1000 - 4kB)      |
    +---0xd000: mcuboot_primary (0x78000 - 480kB)-----+
    | 0xd000: mcuboot_pad (0x200 - 512B)              |
    +---0xd200: mcuboot_primary_app (0x77e00 - 479kB)-+
    | 0xd200: app (0x77e00 - 479kB)                   |
    +-------------------------------------------------+
    | 0x85000: mcuboot_secondary (0x78000 - 480kB)    |
    | 0xfd000: EMPTY_0 (0x1000 - 4kB)                 |
    | 0xfe000: settings_storage (0x2000 - 8kB)        |
    +-------------------------------------------------+

      sram_primary (0x40000 - 256kB):
    +--------------------------------------------+
    | 0x20000000: sram_primary (0x40000 - 256kB) |
    +--------------------------------------------+


Relevant documentation used are https://developer.nordicsemi.com/nRF_Connect_SDK/doc/2.5.99-dev1/nrf/scripts/partition_manager/partition_manager.html with emphasis
on https://developer.nordicsemi.com/nRF_Connect_SDK/doc/2.5.99-dev1/nrf/scripts/partition_manager/partition_manager.html#external-flash-memory-partitions

From the Zephyr settings sample: 
This is a simple application demonstrating use of the settings runtime
configuration module. In this application some configuration values are loaded
from persistent storage and exported to persistent storage using different
settings method. The example shows how to implement module handlers, how to
register them.

Requirements
************

* A board with settings support, for instance: nrf52840dk_nrf52840

Building and Running
********************
After running the image to the board the output on the console shows the
settings manipulation messages.

Sample Output
=============

.. code-block:: console

   ***** Booting Zephyr OS build v2.1.0-rc1-123-g41091eb1d5e0 *****

   *** Settings usage example ***

   settings subsys initialization: OK.
   subtree <alpha> handler registered: OK
   subtree <alpha/beta> has static handler

   ##############
   # iteration 0
   ##############

   =================================================
   basic load and save using registered handlers

   load all key-value pairs using registered handlers
   loading all settings under <beta> handler is done
   loading all settings under <alpha> handler is done

   save <alpha/beta/voltage> key directly: OK.

   load <alpha/beta> key-value pairs using registered handlers
   <alpha/beta/voltage> = -3025
   loading all settings under <beta> handler is done

   save all key-value pairs using registered handlers
   export keys under <beta> handler
   export keys under <alpha> handler

   load all key-value pairs using registered handlers
   export keys under <beta> handler
   export keys under <alpha> handler

   =================================================
   loading subtree to destination provided by the caller

   direct load: <alpha/length/2>
   direct load: <alpha/length/1>
   direct load: <alpha/length>
     direct.length = 100
     direct.length_1 = 41
     direct.length_2 = 59

   =================================================
   Delete a key-value pair

   immediate load: OK.
     <alpha/length> value exist in the storage
   delete <alpha/length>: OK.
     Can't to load the <alpha/length> value as expected

   =================================================
   Service a key-value pair without dedicated handlers

   <gamma> = 0 (default)
   save <gamma> key directly: OK.
   ...
