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
void gpio_init(XGpio* bitstream_gpio_handle, XGpio* control_gpio_handle)
{
	// GPIO for reading bitstream data
	XGpio_Initialize(bitstream_gpio_handle, XPAR_BITSTREAM_GPIO_DEVICE_ID);
	XGpio_SetDataDirection(bitstream_gpio_handle, 1, 0xFFFFFFFF);	// All inputs
	XGpio_SetDataDirection(bitstream_gpio_handle, 2, 0xFFFFFFFF);

	// GPIO for control
	XGpio_Initialize(control_gpio_handle, XPAR_CONTROL_GPIO_DEVICE_ID);
	XGpio_SetDataDirection(control_gpio_handle, 1, 0x0000000F);	// Flag inputs
	XGpio_SetDataDirection(control_gpio_handle, 2, 0x00000000);	// Control outputs

}
