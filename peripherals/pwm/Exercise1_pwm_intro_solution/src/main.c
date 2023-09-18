#include <zephyr.h>
/* Step 2.1 - Include the relevant headers for pwm*/
#include <device.h>
#include <drivers/pwm.h>

/* Step 1.2 - Include logging and define log module */

#include <logging/log.h>
LOG_MODULE_REGISTER(main, CONFIG_LOG_DEFAULT_LEVEL);

/* Step 2.2 - define pwm_led0 using the pwm_dt_spec struct */
static const struct pwm_dt_spec pwm_led0 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led0));

/* STEP 3.1 - Define the desired pwm period and pulse */
// #define PWM_PERIOD_NS 20000000 
// #define PWM_PULSE_NS 1500000

/* STEP 4.1.1 - Define the desired maximum and minimum period using PWM_SEC*/
#define MIN_PERIOD PWM_SEC(1U) / 128U
#define MAX_PERIOD PWM_SEC(1U)


/* Step 3 - Create an initializing function to verify that the device is enabled*/ 
int pwm_init(void){
        int err = 0;

        /* Step 4.1.2 - Define an unsigned 32 bit variable max_period*/
        uint32_t max_period;

        LOG_INF("Initializing pwm");

        /* Step 3.2 - Check if the device is ready */
        if (!device_is_ready(pwm_led0.dev)) {
        LOG_ERR("Error: PWM device %s is not ready",
                pwm_led0.dev->name);
        return -EBUSY;
        }

        // /* Step 3.3 - Set period and pulse in nanoseconds and check for error*/
        // err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, PWM_PULSE_NS);
        // if (err){
        //         LOG_ERR("pwm_set_dt() in pwm_init() returned %d", err);
        // }

        /* STEP 4.2 - Calibration of the pwm led channel
         * In case the default MAX_PERIOD value cannot be set for
	 * some PWM hardware, decrease its value until it can.
	 *
	 * Keep its value at least MIN_PERIOD * 4 to make sure
	 * the sample changes frequency at least once.
         */
        LOG_INF("Calibrating for channel %d...\n", pwm_led0.channel);
	max_period = MAX_PERIOD;
	while (pwm_set_dt(&pwm_led0, max_period, max_period / 2U)) {
		max_period /= 2U;
        
        /* STEP 4.3 -  Optional
        * Keep the maximum period value at least MIN_PERIOD * 4 to make sure
	* the sample changes frequency at least once.*/
        		if (max_period < (4U * MIN_PERIOD)) {
			LOG_ERR("Error: PWM device "
			       "does not support a period at least %lu\n",
			       4U * MIN_PERIOD);
			return;
		}

	}
        printk("Done calibrating; maximum/minimum periods %u/%lu usec\n",
                max_period, MIN_PERIOD);
        
        /* Step 4.4 - return max_period */
        return max_period;
}

int main(void)
{
        int err = 0;
        uint32_t max_period;
        uint32_t period;
	uint8_t dir = 0U;

        LOG_INF("Starting PWM basic sample \n");
        /* Step 3.3 - Call the initialization function */
        pwm_init();
        max_period = pwm_init();
        period = max_period;
        while (1) {
		err = pwm_set_dt(&pwm_led0, period, period / 2U);
		if (err) {
			LOG_ERR("Error %d: failed to set pulse width\n", err);
			return;
		}

		period = dir ? (period * 2U) : (period / 2U);
		if (period > max_period) {
			period = max_period / 2U;
			dir = 0U;
		} else if (period < MIN_PERIOD) {
			period = MIN_PERIOD * 2U;
			dir = 1U;
		}

		k_sleep(K_SECONDS(4U));
	}
}
