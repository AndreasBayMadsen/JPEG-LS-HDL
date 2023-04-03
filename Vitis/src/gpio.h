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
void gpio_init(XGpio* handle);

/*****************************************
 * Function name: 	gpio_set()
 * Description: 	Sets a GPIO high
 *****************************************/
void gpio_set(XGpio* handle);

/*****************************************
 * Function name: 	gpio_clear()
 * Description: 	Clears a GPIO
 *****************************************/
void gpio_clear(XGpio* handle);

#endif
