# Pulse Width Modulation
There are a multitude of youtube videos and other documentation that explains this to a more detailed level than this if you wish to learn more. This theory written here is mainly for my own learning experience.

# Goal
We want to output a PWM signal, and the duty cycle of the PWM signal is our control signal. In our
case we want the duty cycle to be between 1 and 2 ms and a PWM period of 20ms.

In pwm_basic you will see how to control the pwm-led and set it to have a certain brightness. In pwm_blinky we will see how we can configure the LED to blink in a pattern controlled by the PWM signal. In pwm_motor, which requires additional hardware, we will see how we can use the PWM signal to control the position/angle of a motor

# Links to documentations used in this repo
* https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/zephyr/build/dts/api/api.html#pwm
* https://www.electronicoscaldas.com/datasheet/MG90S_Tower-Pro.pdf

# Other resources
* For how servo motors work: https://www.jameco.com/Jameco/workshop/Howitworks/how-servo-motors-work.html 

