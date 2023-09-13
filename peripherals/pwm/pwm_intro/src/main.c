/* Step 2.1 - Include the relevant headers*/
#include <zephyr.h>
#include <sys/printk.h>
#include <device.h>
#include <drivers/pwm.h>

/* Step 1.2 - Include logging and define log module */

#include <logging/log.h>
LOG_MODULE_REGISTER(main, CONFIG_LOG_DEFAULT_LEVEL);

/* Step 2.2 - define pwm_led0 using the pwm_dt_spec struct */
static const struct pwm_dt_spec pwm_led0 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led0));

/* STEP 3.3 - Define the desired pwm period and pulse */
#define PWM_PERIOD_NS 20000000 
#define PWM_PULSE_NS 1500000

/* Step 3 - Create an initializing function to verify that the device is enabled*/ 
int pwm_init(void){
        int err = 0;
        LOG_INF("Initializing Motor Control");

        /* Step 3.1 - Check if the device is ready */
        if (!device_is_ready(pwm_led0.dev)) {
        LOG_ERR("Error: PWM device %s is not ready",
                pwm_led0.dev->name);
        return -EBUSY;
        }

        /* Step 3.2 - Set period and pulse in nanoseconds and check for error*/
        err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, PWM_PULSE_NS);
        if (err){
                LOG_ERR("pwm_set_dt() in pwm_init() returned %d", err);
        }
}

int main(void)
{
        LOG_INF("Starting PWM basic sample \n");
        /* Step 3.3 - Call the initialization function */
        pwm_init();

        return 0;       
}
