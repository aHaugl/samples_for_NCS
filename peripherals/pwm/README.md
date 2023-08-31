# Pulse Width Modulation
There are a multitude of youtube videos and other documentation that explains this to a more detailed level than this if you wish to learn more. This theory written here is mainly for my own learning experience.



# Goal
We want to output a PWM signal, and the duty cycle of the PWM signal is our control signal. In our
case we want the duty cycle to be between 1 and 2 ms and a PWM period of 20ms.

In basic_LED_only the PWM signal will control the brightness, in basic_motor_control the PWM signal will control the motor position/angle.

For basic_motor_control, we will separate out most of the PWM configuration and handling in a separate file, and implement simple functions to call from main.c. Other than this, the samples are identical in setup

# Useful links in Nordic Semiconductors documentation

# Using the driver

# Adding the peripheral to the devicetree

# Other resources
* For how servo motors work: https://www.jameco.com/Jameco/workshop/Howitworks/how-servo-motors-work.html 

