/*******************************************************************
 * Module name: gpio
 * Purpose: 	Contains functions for configuring GPIO
 *******************************************************************/
#ifndef __GPIO_H_
#define __GPIO_H_

//********************* INCLUDES *********************//
#include "xgpio.h"

//************** FUNCTION DECLARATIONS ***************//

/*****************************************
 * Function name: 	gpio_init()
 * Description: 	Initializes the GPIO
 *****************************************/
void gpio_init(XGpio* bitstream_gpio_handle, XGpio* control_gpio_handle);

#endif
