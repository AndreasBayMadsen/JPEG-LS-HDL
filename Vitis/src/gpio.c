/*******************************************************************
 * Module name: gpio
 * Purpose: 	Contains functions for configuring GPIO
 *******************************************************************/

//********************* INCLUDES *********************//
#include "gpio.h"

#include "xgpio.h"
#include "xparameters.h"

//*************** FUNCTION DEFINITIONS ***************//

/*****************************************
 * Function name: 	gpio_init()
 * Description: 	Initializes the GPIO
 *****************************************/
void gpio_init(XGpio* handle)
{
	XGpio_Initialize(handle, XPAR_GPIO_0_DEVICE_ID);	// Initialize GPIO
	XGpio_SetDataDirection(handle, 1, 0x00);			// Set as output
}

/*****************************************
 * Function name: 	gpio_set()
 * Description: 	Sets a GPIO high
 *****************************************/
void gpio_set(XGpio* handle)
{
	XGpio_DiscreteWrite(handle, 1, 0x01);
}

/*****************************************
 * Function name: 	gpio_clear()
 * Description: 	Clears a GPIO
 *****************************************/
void gpio_clear(XGpio* handle)
{
	XGpio_DiscreteWrite(handle, 1, 0x00);
}
