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
void gpio_init(XGpio* handle, XGpio* flag_gpio_handle, XGpio* bit_gpio_handle)
{
	// GPIO for enabling compression
	XGpio_Initialize(handle, XPAR_ENABLE_GPIO_DEVICE_ID);	// Initialize GPIO
	XGpio_SetDataDirection(handle, 1, 0x00);				// Set as output

	// GPIO for reading output flags of compression and requesting bitstream
	XGpio_Initialize(flag_gpio_handle, XPAR_FLAG_GPIO_DEVICE_ID);
	XGpio_SetDataDirection(flag_gpio_handle, 1, 0x07);		// Set flags as input
	XGpio_SetDataDirection(flag_gpio_handle, 2, 0x00);		// Set request as output

	// GPIO for reading bitstream data
	XGpio_Initialize(bit_gpio_handle, XPAR_BITSTREAM_GPIO_DEVICE_ID);
	XGpio_SetDataDirection(bit_gpio_handle, 1, 0xFFFFFFFF);
	XGpio_SetDataDirection(bit_gpio_handle, 2, 0xFFFFFFFF);

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
