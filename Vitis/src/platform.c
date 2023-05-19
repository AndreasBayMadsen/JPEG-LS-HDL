/*******************************************************************
 * Module name: platform
 * Purpose: 	Contains functions for configuring the system
 *******************************************************************/
#ifndef __PLATFORM_H_
#define __PLATFORM_H_

//********************* INCLUDES *********************//
#include "platform.h"
#include "uart.h"
#include "bram.h"
#include "gpio.h"

#include "xuartps.h"
#include "xbram.h"
#include "xgpio.h"

#include "xil_printf.h"

//*************** FUNCTION DEFINITIONS ***************//

/*****************************************
 * Function name: init_hw()
 * Description: Initializes the hardware
 *****************************************/
void init_hw(XUartPs* uart_handle, XBram* bram_handle, XGpio* gpio_handle, XGpio* flag_gpio_handle, XGpio* bit_gpio_handle)
{
	xil_printf("Initializing the system");

	uart_init(uart_handle);		// UART
	bram_init(bram_handle);		// BRAM
	gpio_init(gpio_handle,		// GPIO
			  flag_gpio_handle,
			  bit_gpio_handle);

	xil_printf("Finished initialization");
}

#endif
