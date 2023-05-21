/*******************************************************************
 * Module name: platform
 * Purpose: 	Contains functions for configuring the system
 *******************************************************************/
#ifndef __PLATFORM_H_
#define __PLATFORM_H_

//********************* INCLUDES *********************//
#include "platform.h"
#include "uart.h"
#include "gpio.h"

#include "xuartps.h"
#include "xgpio.h"

#include "xil_printf.h"

//********************* DEFINES **********************//
#define CAM_CONFIG				0
#define REQUEST_NEXT			1
#define	CLEAR_NEW_DATA_READY	2
#define CAM_CONNECT				3

#define FLAG_READ_ALLOWED		0
#define	FLAG_NEW_DATA_READY		1
#define FLAG_END_OF_DATA		2
#define	FLAG_CAM_CONFIG_DONE	3

//*************** FUNCTION DEFINITIONS ***************//

/*****************************************
 * Function name: init_hw()
 * Description: Initializes the hardware
 *****************************************/
void init_hw(XUartPs* uart_handle, XGpio* bitstream_gpio_handle, XGpio* control_gpio_handle)
{
	uint8_t flags		= 0;
	uint8_t done		= 1;
	uint8_t done_old 	= 1;

	xil_printf("Initializing PL");

	uart_init(uart_handle);				// UART
	gpio_init(bitstream_gpio_handle,	// GPIO
			control_gpio_handle);

	xil_printf("Configuring camera");

	XGpio_DiscreteWrite(control_gpio_handle, 2, (1<<CAM_CONFIG));
	do
	{
		done_old = done;
		flags 	= XGpio_DiscreteRead(control_gpio_handle, 1);
		done	= flags & (1<<FLAG_CAM_CONFIG_DONE);
	} while (!(done && !done_old));
	XGpio_DiscreteWrite(control_gpio_handle, 2, 0);

	xil_printf("Finished initialization");
}

#endif
