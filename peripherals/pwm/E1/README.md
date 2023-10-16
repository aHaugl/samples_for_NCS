#Exercise 1 - Introduction to adding the pwm device

## Step 1
### Step 1.1 - Enable logging
Add the required configurations to prj.conf

### Step 1.2 - Add log support
 Add the log module header to main.c and register the log module

## Step 2
### Step 2.1 - Include the relevant headers and configurations for pwm
 (device.h and drivers/pwm.h) and include the PWM configuration. You may also add CONFIG_PWM_LOG_LEVEL_DBG=y
 for additional logging.
 

### Step 2.2 - Define pwm_led0
Once a Zephyr driver is enabled by the configuration in our prj.conf file, it will automatically be enabled and ready for use. All we need to do is to specify what instance we want to use. 

Investigate the pwm_dt_spec struct at https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/zephyr/hardware/peripherals/pwm.html#c.pwm_dt_spec and see how you can use this to get pwm_led0, i.e LED 1 as our pwm device. 

This line will find our pwm_leds instance and use LED1 as the default PWM pin. 

On a nRF52840DK LED1 is P0.13 so toggling the LED will also toggle that GPIO on the GPIO header on the board.

## Step 3 - Create a pwm_init function
For this basic use case you won't require a pwm initialization function, but in general it might be beneficial for later use if you aim to use PWM as a control signal for a motor. Note how this is done similarly in exercise 2 with the motor 3 as well.

Define the initialization function int pwm_init(void) which currently returns nothing

This function should 
* Step 3.2 Check if the pwm device is ready and return a busy status if it is busy
* Step 3.3 Set the led with the control signal generated from the PWM
   
### Step 3.1 
Before we create the function we need to define the PWM period and pulse. Do this by defining PWM_PERIOD_NS and PWM_PULSE_NS 

We will first select a number that can seem arbitrary, but it is picked from the hardware from excercize 2 regarding pwm motor control. We want to use this signal to see how it translates to a LED. Set the period to 20ms and a duty cycle between 1ms and 2 ms.

At step 3.5 we will set it to something that is easier to observe when testing the PWM peripheral for an LED.

Investigate pwm_set_dt to see how you can set the PWM period and pulse on the device https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/zephyr/hardware/peripherals/pwm.html#c.pwm_set_dt

### Step 3.2 - Check if the device is busy
Investigate device_is_ready to see how you can check if the device is busy https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/zephyr/kernel/drivers/index.html#c.device_is_ready

The PWM is running cyclically in a given period and duty cycle and works as a counter. At the start of the cycle the counter is 0 and the PWM pin starts high. When it reaches a specific value called the PWM duty cycle, the PWM signal will go low. Thus we want to check if the device is busy or not before we set it

INSERT IMAGE OF PWM PERIOD AND PWM DUTY CYCLE, PS THIS ONE IS FROM THE MOTOR SPEC

### Step 3.3 . Set the led with the control signal generated from the PWM
Use pwm_set_dt from step 3.1 to set the LED. Remember to check for error codes.

## Step 3.4 - Test your firmware
Build and flash the firmware. 

If you've used the pulse and period values we suggested in step 3.1 you should now observe that LED 1 on the 52840DK is glowing slightly. 

Try changing the pulse and/or period and observe the changes. If the value is set too high or too low, it may be out of range of what your hardware can reach. In step 4/LESSON 2 AN OPTION TO ADD MORE TO THE LESSON OR END IT HERE we will show you how you can calibrate the PWM channel to ensure that the period is within the tolerance of the hardware.

Congratulations, you've now enabled the PWM and used it to control a LED!


# Step 4 - Add period calibration to the application
In the previous steps you've seen how you can define the period and pulse manually. However, if you chose parameters similarly to what I set in the solution, you may have observed that theese parameters are not suited to control a blinking LED that a human easily observe.

Instead we will take a page out of the blinky_pwm sample found in the Zephyr repository in nRF Connect SDK and add some calibration. Doing this will also allow us to easily set a maximum period that can be set for most PWM hardware.
The goal is to set a high value using PWM_SEC, and to decrease the value until it can be set. 

Comment out 

/* STEP 3.1 - Define the desired pwm period and pulse */
#define PWM_PERIOD_NS 20000000 
#define PWM_PULSE_NS 1500000

and 

/* Step 3.3 - Set period and pulse in nanoseconds and check for error*/
err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, PWM_PULSE_NS);
if (err){
        LOG_ERR("pwm_set_dt() in pwm_init() returned %d", err);
}

## Step 4.1.1 
Define a minimum and maximum period using PWM_SEC above pwm_init(). It can be set to (1U)/128U for minimum and (1U) for maximum. We will modify this value in a later step.

## Step 4.1.2
Define max_period in pwm_init()

## Step 4.2
In pwm_init, set max_period = MAX_PERIOD and decrease it as long as pwm_set_dt(&pwm_led0, max_period,max_period/2U)

## Step 4.3
In this optional step you may make sure that the maximum period is at least 4 times higher than MIN_PERIOD to make sure the sample changes frequency at least once

## Step 4.4 
Return max_period from pwm_init()

## Step 4.5 
Declare an unsigned 32bit int "max_period", "period" and unsigned 8 bit int "dir". Set dir to be equal to 0. Set max_period to become the returned value of pwm_init() and set period to be equal to max_period.

We want to use the variable "dir" to indicate which direction 

## Step 4.6
In a while true loop, use pwm_set_dt(&pwm_led0, period, period / 2U) to toggle the light, and change the period in intervals. Make sure that period stays less than max_period and larger than MIN_PERIOD