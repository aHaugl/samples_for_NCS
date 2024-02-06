In this exercise we will expand on the previous exercise by [].

For this exercise we will use the ower Pro Micro Servo SG90 servo motor, but you can also follow along without any additional hardware by using the LED’s to simulate a motor similar to what we did in exercise 1. 

The first thing we will do is use the pwm_led instance we used in the first exercise and create a custom variation of this that we will use for our PWM signal that will drive another GPIO other than LED 1. If you don’t have a motor available, follow along with the steps in this exercise, but don’t change the GPIO that this PWM instance will drive.

The data sheet for the servo motor we will use can be found here http://www.ee.ic.ac.uk/pcheung/teaching/DE1_EE/stores/sg90_datasheet.pdf

The datasheet shows that the PWM period is 20ms (50Hz), and the duty cycle is between 1ms and 2ms. Recall that these are the same values we used in the previous exercise when we tested the PWM peripheral for controlling LED1, and we observed that these values only resulted in a dimly lit LED. For the specific motor used in this exercise the values must be within the parameters to ensure that the motor only moves within the range it is physically able to move within. 

The servo can rotate approximately 90 degrees in each direction. 1ms pulse corresponds to -90 degrees, 1.5ms corresponds to 0 degrees and 2ms corresponds to 90 degrees rotation.

In Exercise 1we used LED1 as our PWM LED, which is connected to P0.13 for the nRF52840DK. We need to use one of the available GPIOs for our motor. To do this, we need to make some modifications to the device tree.

In addition it is useful to know where to find the predefined devicetree files for the supported boards. We will be using these frequently to investigate how devices and compatibles are defined and we will use these definitions in our overlay to create our own custom variants of these devices. All supported boards can be found in <NCS installation folder>\<NCS version>\zephyr\boards\arm, or at https://github.com/nrfconnect/sdk-zephyr/tree/main/boards/arm. The exception is nRF7002DK, which can be found in <NCS installation folder>\<NCS version>\sdk-nrf\boards\arm.

The exercise will be written for the nRF52840DK but with the resources supplied you should be able to modify the steps to any of the supported boards

Link to the respective .dts files for the boards can be found in the table below.

Board

Devicetree files

nRF52 DK

https://github.com/nrfconnect/sdk-zephyr/blob/main/boards/arm/nrf52dk_nrf52832/nrf52dk_nrf52832.dts 

nRF52833 DK

https://github.com/nrfconnect/sdk-zephyr/blob/main/boards/arm/nrf52833dk_nrf52833/nrf52833dk_nrf52833.dts 

nRF52840 DK

 

nRF5340 DK

 

nRF7002 DK

 

nRF9160 DK

 

nRF9161 DK

https://github.com/nrfconnect/sdk-zephyr/tree/main/boards/arm/nrf9161dk_nrf9161

Exercise steps 

In the GitHub repository for this course, open the base code for this exercise, found in lesson6/ncs-inter_less6_exer2.

1. Create an overlay file and modify it.

A useful resource when learning about devicetree is to inspect a boards devicetree to learn what nodes/devices  are predefined on a board. For this exercise we will focus on the devicetree for the nRF52840DK, nRF52840dk_nrf52840.dts. If you’re using the VS Code extension directly, you may find the .dts file under “Input files” in the extension, or in the relative path <NCS installation folder>\<SDK version>\zephyr\boards\arm.

When opening the .dts in the extension you can see compatibles such as the predefined LEDS and buttons:



nRF52840DK default devicetree



As mentioned the .dts contains the default definitions of what the DKs nodes/compatibles/devices should do and to what GPIOs they are connected to. Every project in this version of the SDK that uses one of these boards will use this exact .dts file, so we we will not make our modifications here. Instead, we will make the modifications in a overlay file that is specific to this project. 

1.1 Create the overlay file for your board

In the base directory for this exercise, go to the boards directory and rename the .overlay file found there to the build target of whichever board you are using with this exercise, for example nrf52840dk_nrf52840.overlay. 

In the image above, you can see that the overlay file we have created will place itself in the devicetree folder located under the Config files item in the extension. 

1.2 Create your own custom compatible device in the overlay file.

We want to create a custom device that should drive a GPIO with a PWM signal. From the nrf52840dk_nrf52840.dts, L:48-53 we know that we have a predefined pwm_led instance which we can modify to fit our need.

We will copy the pwmled instance from the .dts and paste it into your project's overlay file under step 1.2. Regardless of which board you’re using you can copy this step as long as it has a PWM peripheral. For instance for the 52 series you can verify if your board has one by investigating https://infocenter.nordicsemi.com/topic/struct_nrf52/struct/nrf52.html, and similarly you can do the same by investigating the product specification for any of the other avaialble DKs https://infocenter.nordicsemi.com/index.jsp 

In addition to adding this node, we want to change the polarity to normal. This means that the PWM signal will have a high output for the duty cycle instead of low.

This is how it should look under step 1.2 in your overlay file

/{
    pwmleds {
        compatible = "pwm-leds";
        pwm_led0: pwm_led_0 {
            pwms = <&pwm0 0 PWM_MSEC(20) PWM_POLARITY_NORMAL>;
        };
    };
};


This snippet means that we now have a node in our overlay that will overwrite what is defined in the .dts file. This node is a pwmleds node that uses channel 0 on the pwm0 peripheral of the board, and has an alias named “pwm_led0”. For now this is not any different from what is already defined in the .dts file other than that the polarity has been changed, but we will further modify this node in the next two steps.

We will use the alias pwm_led0 to showcase that this alias is simply just a name and that the properties easily can be modified to drive other devices on another GPIO. Later in step 3 I will show you another way to define a device that will use the PWM peripheral to drive the GPIO we use for our motor and repurpose the custom node we create in step 1 to use the PWM1 instance instead of the PWM0 instance. 

1.3 Add your own custom pwm0 instance.

In your overlay file, right-click on “&pwm0” in the instance of pwm_leds in and click "go to definition" in the device tree. This will take you to the definition in the devicetree file we had a look at earlier, and you will see something like this:



Image 2: &pwm0 pin control

&pwm0 {
	status = "okay";
	pinctrl-0 = <&pwm0_default>;
	pinctrl-1 = <&pwm0_sleep>;
	pinctrl-names = "default", "sleep";
};

The pwm0 instance has two “conditions”, default and sleep. This is what is sent out on the GPIO connected to this pin control instance.

Now copy the &pwm0 instance into your overlay file. 

We want to create our own custom instance of this, so we need to change the names. You can choose other names, but this is what I’ve chosen.

&pwm0 {
    status = "okay";
    pinctrl-0 = <&pwm0_custom>;
    pinctrl-1 = <&pwm0_csleep>;
    pinctrl-names = "default", "sleep";
};

1.4 Configure which pins your custom pwm0 instance should use

Inspect “pwm0_default” and “pwm0_sleep” in the initial devicetree file by right_clicking and click “go to definition”. It should look like this by default:



Image 3: pwm0 pin select

&pinctrl {
	pwm0_default: pwm0_default {
		group1 {
			psels = <NRF_PSEL(PWM_OUT0, 0, 13)>;
			nordic,invert;
		};
	};
    
	pwm0_sleep: pwm0_sleep {
		group1 {
			psels = <NRF_PSEL(PWM_OUT0, 0, 13)>;
			low-power-enable;
		};
	};
};

Copy this into your overlay file and change “pwm0_default” and “pwm0_sleep” to your chosen custom names. 

It should look like this:

&pinctrl {
    pwm0_custom: pwm0_custom {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 13)>;
            nordic,invert;
        };
    };

    pwm0_csleep: pwm0_csleep {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 13)>;
            low-power-enable;
        };
    };
};

Let’s look at how NRF_PSEL works by inspecting its definition. Currently, pwm0 is set to use P0.13 (port 0, pin 13) for its output.

Since pin 13 is used by LED 1, we need to change the output pin if we want to control anything other than the motor. In case you don’t have a motor available, you can try to set this to any of the other GPIOs that control the LEDS to see this change. For instance, set <NRF_PSEL(PWM_OUT0, 0, 14)>; to have the PWM output go to GPIO 14, i.e LED 2 instead of GPIO 13, i.e LED 1.

If you’re using a motor, we instead want to use a free available GPIO on the DK. This means that if you wish to use anything other than what we’ve described here, you need to consult with the product specification of the device you’re using and check if that GPIO is available for use. A good starting point is to to inspect product specification for you development kit to find a GPIO that is not used for anything else. For instance in the PS for the nRF52840 DK, in section “8.6  Connector interface”, you can see that the GPIOs in P6 and P24 is already in use for the items mentioned in the illustration.

Board

Available GPIOs

nRF52 DK

P0.02 - P0.04, P0.26 - P0.31

nRF52833 DK

P0.02 - P0.04, P0.17, P0.19-P0.23, P0.26-P0.31

nRF52840 DK

P0.02 -0.04, P0.26 -P0.31, P1.01 - P1.15

nRF5340 DK

P0.05 - P0.07, P0.25 - P0.27, P1.00 - P1.15

nRF7002 DK

P0.05 - P0.07, P0.25 - P0.27, P1.00  - P1.05, P1.10 - P1.15

nRF9160 & nRF9161 DK

P0.10

The solution in this exercise will use P0.03,  so this is what the code under step 1.4 in nrf52840dk_nrf52840.overlay should look like. 

&pinctrl {
    pwm0_custom: pwm0_custom {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            nordic,invert;
        };
    };

    pwm0_csleep: pwm0_csleep {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            low-power-enable;
        };
    };
};

If P0.03 is not available on your board you can use any of the other free GPIOs instead 

This is what the overlay should look like at this point in time

/* Step 1.4 - Define pwm0_custom and pwm0_sleep */
&pinctrl {
    pwm0_custom: pwm0_custom {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            nordic,invert;
        };
    };

    pwm0_csleep: pwm0_csleep {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            low-power-enable;
        };
    };
};
/* Step 1.3 - Add the pwm0 instance */
&pwm0 {
    status = "okay";
    pinctrl-0 = <&pwm0_custom>;
    pinctrl-1 = <&pwm0_csleep>;
    pinctrl-names = "default", "sleep";
};

/{
/* Step 1.2 -  Add a pwm_led instance and change the polarity */
    pwmleds {
        compatible = "pwm-leds";
        pwm_led0: pwm_led_0 {
            pwms = <&pwm0 0 PWM_MSEC(20) PWM_POLARITY_NORMAL>;
        };
    };
};



2. Control the motor angle of the servo.

We have now set up our device to have a PWM output on pin 3, but we still need to decide how to set the pin. Let’s create the function set_motor_angle() that sets the motor angle based on the input parameter duty_cycle_ns.

This input parameter will be decided based on the motor's datasheet. For the SG90 servo motor, you can see that here: http://www.ee.ic.ac.uk/pcheung/teaching/DE1_EE/stores/sg90_datasheet.pdf 



From the datasheet we can see that the Duty Cycle ranges from 1-2 ms while the PWM period is 20ms (50Hz).

2.1 Define the function set_motor_angle() to set the motor angle.

Define a function to set the motor angle. This function should take in the PWN duty cycle or an angle between 0 and 180 degrees as the input parameter and use pwm_set_dt to set it accordingly. 

Add the following code snippet to the main.c file

int set_motor_angle(uint32_t duty_cycle_ns)
{
    int err;
    err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, duty_cycle_ns);
    if (err) {
        LOG_ERR("pwm_set_dt_returned %d", err);
    }
 
    return err;
}

2.2 Define a maximum and minimum duty cycle

Inspect the datasheet of the motor and define the macros PWM_MIN_DUTY_CYCLE and PWM_MAX_DUTY_CYCLE based on this. 

Note that you may need to do some experimentation as what corresponds to the minimum and maximum angle may vary from motor to motor due to wear and tear. 

We will set the following as our parameters:

#define PWM_MIN_DUTY_CYCLE 1000000
#define PWM_MAX_DUTY_CYCLE 2000000

2.3 Check if the device is ready and set it to an initial value:

Under Step 2.3 add the following

    if (!pwm_is_ready_dt(&pwm_led0)) {
        LOG_ERR("Error: PWM device %s is not ready", pwm_led0.dev->name);
        return 0;
	}
    err = pwm_set_dt(&pwm_led0, PWM_PERIOD, PWM_MIN_DUTY_CYCLE);
    if (err) {
        LOG_ERR("pwm_set_dt returned %d", err);
        return 0;
    }

2.4 Call set_motor_angle() with different duty cycles. 

Inside the loop in main(), Call set_motor_angle() with the minimum and maximum duty cycle and a small sleep in between.

Add the following code snippet in main(). This snippet is just to test that everything is working and we will replace it with button control in a later step.

LOG_INF("Setting motor angle to %d",PWM_MIN_DUTY_CYCLE);
set_motor_angle(PWM_MIN_DUTY_CYCLE);
k_sleep(K_SECONDS(5));

LOG_INF("Setting motor angle to %d",PWM_MAX_DUTY_CYCLE);
et_motor_angle(PWM_MAX_DUTY_CYCLE);
k_sleep(K_SECONDS(5));



This is not the greatest way to set the motor angle as this will just continue to change the angle at an interval set in the sleep. Do also note that you may have to tweak the duty cycles based on your motor's parameters, and in case you’ve done this exercise only using the LED you might also need to do some tweaking.

3. Testing the code.

3.1 Connect the wiring on the motor

Connect the motors ground to ground, the VCC to a voltage source on the DK, and the PWM wire to the GPIO pin you set in step 1.4.

Servo

DK

Brown

Ground

Ground

Red

VCC

Voltage source

Yellow

PWM

GPIO pin

This is how the wiring looks if you’ve used the GPIO on port 0, pin 3



Image 4: Setup



Instead of simply changing the angle in a loop, we want to use the DKs buttons to set which motor angle that has been used.

3.2 Build and flash the application to your board.

Build your application with the overlay you have created for your board. To add the overlay press “Add overlay”.





What you now should observe is that the servo motor changes position from the minimum angle it can be positioned to, to the maximum angle. […]

4. Add button control to your servo motor application.

For this next part of the application we want to implement a simple button handler that we will use to set the  servo motor angle, and later to also set the duty cycle of the second PWM instance we will add.

4.1 Enable the DK Buttons and LEDs library. 

Enable the DK Buttons and LEDS library in nRF Connect SDK, which we will use to interface with the buttons and LEDs on the development kits.

4.1.1 Enable the DK Buttons and LEDs Kconfig.

Enable the library through the Kconfig CONFIG_DK_LIBRARY.

Add the following line to the prj.conf file

CONFIG_DK_LIBRARY=y

4.1.2 Include the header file for the DK Buttons and LEDs library.

#include <dk_buttons_and_leds.h>

4.2 Initialize the buttons library

Before we can use the buttons we need to initialize this. After investigating https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/libraries/others/dk_buttons_and_leds.html  we can see that there exists an API for this, namely dk_buttons_init(). Use this call to initialize the library to read the button state with the button_handler() function.

if (dk_buttons_init(button_handler)) {
  LOG_ERR("Couldn't init buttons (err %d)", err);
}

4.3 Button handler callback function 

We will use some items from dk_buttons_and_leds.h in our callback function. The first item is to use the button masks, i.e DK_BTN1_MSK and DK_BTN2_MSK for our cases. We will also use the masks button_state and has_changed to get the state of the button pressed and to know if said button has been pressed i.e has changed.

The callback function we will create to handle button presses should check for error codes and switch between different cases based on what button on the DK has been pressed. Use button 1 and button 2 to set the motor angle by using the minimum and maximum duty cycle you’ve defined.



Add the following skeleton to Step 4.3 Button handler

void button_handler(uint32_t button_state, uint32_t has_changed)
{
    int err = 0;
	if (has_changed & button_state)
	{
		switch (has_changed)
		{
            /* STEP 4.3.1 - Change motor angle when a button is pressed */

            /* STEP 5.x - Create button masks for controlling PWM LED*/

			default:
				break;
		}
        if (err) {
            LOG_ERR("Error: couldn't set duty cycle, err %d", err);
        }
	}
}

Step 4.3.1 - Add functionality to set the servo motor angle to minimum and maximum

Add the following code snippet in button_handler() under /* Step 4.3.1

case DK_BTN1_MSK:
  LOG_INF("Button 1 pressed");
  err = set_motor_angle(PWM_MIN_DUTY_CYCLE);
  break;
case DK_BTN2_MSK:
  LOG_INF("Button 2 pressed");
  err = set_motor_angle(PWM_MAX_DUTY_CYCLE);
  break;

This is what your function should like at this point in time:

/* Step 4 - Button handler */
void button_handler(uint32_t button_state, uint32_t has_changed)
{
    int err = 0;
	if (has_changed & button_state)
	{
		switch (has_changed)
		{
            /* STEP 4.3 - Change motor angle when a button is pressed */
            case DK_BTN1_MSK:
                LOG_INF("Button 1 pressed");
                err = set_motor_angle(PWM_SERVO_MIN_DUTY_CYCLE);
                break;
            case DK_BTN2_MSK:
                LOG_INF("Button 2 pressed");
                err = set_motor_angle(PWM_SERVO_MAX_DUTY_CYCLE);
                break;
             /* STEP 5.3 - Create button masks for controlling PWM LED*/
           
			default:
				break;
		}
        if (err) {
            LOG_ERR("Error: couldn't set duty cycle, err %d", err);
        }
	}
}

Remove the loop under step 2.4 in main() 

Your main should now look like 

int main(void)
{

    int err = 0;
    
    /* Step 2.3 - Check if the device is ready and set its initial value */
    if (!pwm_is_ready_dt(&pwm_led0)) {
        LOG_ERR("Error: PWM device %s is not ready", pwm_led0.dev->name);
        return 0;
	}
    err = pwm_set_dt(&pwm_led0, 2*PWM_PERIOD, PWM_MIN_DUTY_CYCLE);
    if (err) {
        LOG_ERR("pwm_set_dt returned %d", err);
        return 0;
    }

    /* Step 5.11 - Check if the motor device is ready */
    LOG_INF("Settin initial motor");
    if (!pwm_is_ready_dt(&pwm_servo)) {
        LOG_ERR("Error: PWM device %s is not ready", pwm_servo.dev->name);
        return 0;
	}

    err = pwm_set_dt(&pwm_servo, PWM_PERIOD, PWM_SERVO_MIN_DUTY_CYCLE);
    if (err) {
        LOG_ERR("pwm_set_dt returned %d", err);
        return 0;
    }

    LOG_INF("Initializing DK Buttons");
    /* Step 4.2  - Initialize the buttons library */
    if (dk_buttons_init(button_handler)) {
        LOG_ERR("Failed to initialize the buttons library");
    }      
    return 0;
}

4.4 Build and flash your application to the device.

Remember to add the overlay to your build configuration.

You should now be able to change the motor's angle by pressing button 1 or button 2. 

If you’ve followed this exercise without the motor and instead configured everything for the PWM LED from exercise 1, you should now be able to make the LED blink with two different frequencies. Note that the parameters chosen for the motor control may not work for an LED, 

5. Enable multiple PWM instances

We now want to expand on this exercise by adding another PWM instance. While doing this we will also show you how to create a custom device that will act as a servo instead of modifying the existing node which is by default enabled to control PWM0.

For this next we will do two things.

The first is to revert the PWM instance we’ve modified from driving GPIO that controls a LED to a general GPIO back to driving a LED.

The second is to add a custom device that is named, and defined to act as a servo motor and is driven by a second PWM instance.

5.1: 

The first is to change our previous overlay to ensure that pwm0 drives one of the LEDS. In section 1.4 of your overlay change the psel to one of the following GPIOs

Board

LED GPIOs

nRF52 DK

[..]

nRF52833 DK

nRF52840 DK

P0.13 - P0.16

nRF5340 DK

nRF7002 DK

nRF9160 & nRF9161 DK



Using LED2 on the nRF52840DK  it should look like this 

/* Step 1.4 - Define pwm0_custom and pwm0_sleep */
&pinctrl {
    pwm0_custom: pwm0_custom {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 14)>;
            nordic,invert;
        };
    };

    pwm0_csleep: pwm0_csleep {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 14)>;
            low-power-enable;
        };
    };
};

5.1.1 - Set duty cycles for the LED 

Here is a suggestion

/* STEP  2.2 - Define minimum and maximum duty cycle */
#define PWM_MIN_DUTY_CYCLE 20000000
#define PWM_MAX_DUTY_CYCLE 50000000

5.2.2 - Create a function to set the duty cycle of the PWM LED

Under step 5.2.2 add the following 

int set_led_blink(uint32_t period, uint32_t duty_cycle_ns){
    int err;
    err = pwm_set_dt(&pwm_led0, period, duty_cycle_ns);
        if (err) {
        LOG_ERR("pwm_set_dt_returned %d", err);
    }
    return err;
}

5.3 - Add the following under Step 5.3 in button handler:

            /* STEP 5.3 - Create button masks for controlling PWM LED*/
            case DK_BTN3_MSK:
                LOG_INF("Button 3 pressed");
                err = set_led_blink(2*PWM_PERIOD, PWM_MIN_DUTY_CYCLE);
                break;
            case DK_BTN4_MSK:
                LOG_INF("Button 4 pressed");
                err = set_led_blink(4*PWM_PERIOD, PWM_MAX_DUTY_CYCLE);
                break;

5.4 Create a <device>.yml file for our custom servo device

In the folder dts/bindings create a new file called pwm-servo.yaml. To this add the following

# Copyright (c) 2022 Nordic Semiconductor ASA
# SPDX-License-Identifier: Apache-2.0

description: PWM-driven servo motor.

compatible: "pwm-servo"

include: base.yaml

properties:
  pwms:
    required: true
    type: phandle-array
    description: PWM specifier driving the servo motor.

  min-pulse:
    required: true
    type: int
    description: Minimum pulse width (nanoseconds).

  max-pulse:
    required: true
    type: inta
    description: Maximum pulse width (nanoseconds).

This .yml is the same used https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/basic/servo_motor  with the addition of the period

We’ve now created a custom device of the compatible “pwm-servo” where we have defined the properties that it uses a pwms compatible, and that the device has a minimum and maximum pulse.

5.5 Define this device in your overlay

We want our servo motor to be driven by a signal generated from a different PWM instance

Under 5.4 add the following

/ {
    servo: servo {
        compatible = "pwm-servo";
        pwms = <&pwm1 0 PWM_MSEC(20) PWM_POLARITY_NORMAL>;
        min-pulse = <PWM_USEC(1000)>;
        max-pulse = <PWM_USEC(2000)>;
        servo_period =<PWM_USEC((2000))>;
    };
};

We’ve now defined our device with the nodelabel “servo”, it’s a compatible of “pwm-servo” which is driven by the pwm1 instance, period of 20ms and a normal polarity. In addition we have defined it to have a minimum and maximum duty cycle of 1ms and 2 ms.

5.6 Change which pin pwm1 drives

Similar to what we did in step 1 of the exercise, we need to use pin control to select what GPIO the PWM should drive.

In your overlay under step 5.4 add the following

/* Step 5.4 Select what GPIO pwm1 should drive */
&pinctrl {
    pwm1_custom_motor: pwm1_custom_motor {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            nordic,invert;
        };
    };

    pwm1_csleep_motor: pwm1_csleep_motor {
        group1 {
            psels = <NRF_PSEL(PWM_OUT0, 0, 3)>;
            low-power-enable;
        };
    };
};

&pwm1 {
    status = "okay";
    pinctrl-0 = <&pwm1_custom_motor>;
    pinctrl-1 = <&pwm1_csleep_motor>;
    pinctrl-names = "default", "sleep";
};

5.7 Define the servo motor device

Under Step 5.7 add the following

#define SERVO_MOTOR    DT_NODELABEL(servo)

5.8 - Initialize and populate struct pwm_dt_spec using PWM_DT_SPEC_GET().

Under Step 5.6 add the following 

static const struct pwm_dt_spec pwm_servo = PWM_DT_SPEC_GET(SERVO_MOTOR);

5.9 - Use DT_PROP() to obtain the minimum and maximum duty cycle from the defined device

#define PWM_SERVO_MIN_DUTY_CYCLE  DT_PROP(SERVO_MOTOR, min_pulse);
#define PWM_SERVO_MAX_DUTY_CYCLE  DT_PROP(SERVO_MOTOR, max_pulse);

5.10 - Update the button handler 

Replace the first two button handles under step 4.2 with the following: 

            /* STEP 4.2 - Change motor angle when a button is pressed */
            case DK_BTN1_MSK:
                LOG_INF("Button 1 pressed");
                err = set_motor_angle(PWM_SERVO_MIN_DUTY_CYCLE);
                break;
            case DK_BTN2_MSK:
                LOG_INF("Button 2 pressed");
                err = set_motor_angle(PWM_SERVO_MAX_DUTY_CYCLE);
                break;

What we’ve done is to change the duty cycle we feed in to be the one defined in the overlay instead of the one we defined in step 2.2. 

5.11 Check if the motor device is ready and initialize it

To Step 5.11 add the following code

    LOG_INF("Settin initial motor");
    if (!pwm_is_ready_dt(&pwm_servo)) {
        LOG_ERR("Error: PWM device %s is not ready", pwm_servo.dev->name);
        return 0;
	}

    err = pwm_set_dt(&pwm_servo, PWM_PERIOD, PWM_SERVO_MIN_DUTY_CYCLE);
    if (err) {
        LOG_ERR("pwm_set_dt returned %d", err);
        return 0;
    }

6 Build and test your code

After programming your device, you should now observe that LED1 starts blinking, and if your motor is not already in the initial position it should move there. When you press the various buttons, you should now observe that the frequency of the LED changes or that the motor changes position depending on which button.

What we’ve now created is a device that has two PWM instances that each drives each own GPIO. If you’ve followed the exercise exactly, then the first one drives LED 2 through P0.14 on the nRF52840DK and the servo motor on. 

We’ve showed different ways of modifying the overlay, to define a device and to use a device defined in the overlay
