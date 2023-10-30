#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/pwm.h>
#include <zephyr/logging/log.h>

#define LOG_MODULE_NAME excersize_3
LOG_MODULE_REGISTER(LOG_MODULE_NAME);

/* Step 2.2 - define pwm_led0 using the pwm_dt_spec struct */
static const struct pwm_dt_spec pwm_led0 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led0));

/* STEP 3.1 - Define the desired pwm period and pulse */
// #define PWM_PERIOD_NS 20000000
// #define PWM_DUTY_CYCLE 1400000

/* Step  3.4 - With different parameters */
#define PWM_PERIOD_NS 10000000
#define PWM_DUTY_CYCLE 1400000
#define PWM_MIN_DUTY_CYCLE 1000000
#define PWM_MAX_DUTY_CYCLE 2000000

/* Step 3 - Create an initializing function to verify that the device is enabled*/ 
int motor_init(void)
{
    int err = 0;
    LOG_INF("Initializing Motor Control");

    if (!device_is_ready(pwm_led0.dev)) {
    LOG_ERR("Error: PWM device %s is not ready",
            pwm_led0.dev->name);
    return -EBUSY;
	}

    err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, PWM_DUTY_CYCLE);
    if (err) {
        LOG_ERR("pwm_set_dt returned %d", err);
    }

    return err;
}

/* Step 2.1 - Create */
int set_motor_angle(uint32_t duty_cycle_ns)
{
    int err;
    err = pwm_set_dt(&pwm_led0, PWM_PERIOD_NS, duty_cycle_ns);
    if (err) {
        LOG_ERR("pwm_set_dt_returned %d", err);
    }
 
    return err;
}

void main(void)
{
        LOG_INF("Starting PWM basic sample \n");
        /* Step 3.3 - Call the initialization function */
        motor_init();

        for (;;){
            LOG_INF("Setting motor angle to %d",PWM_MIN_DUTY_CYCLE);
            set_motor_angle(PWM_MIN_DUTY_CYCLE);
            k_sleep(K_SECONDS(5));
            LOG_INF("Setting motor angle to %d",PWM_MAX_DUTY_CYCLE);
            set_motor_angle(PWM_MAX_DUTY_CYCLE);
            k_sleep(K_SECONDS(5));
        
        }
        
}
