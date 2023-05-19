/*******************************************************************
 * Module name: platform
 * Purpose: 	Contains functions for configuring the system
 *******************************************************************/
#ifndef __PLATFORM_H_
#define __PLATFORM_H_

//********************* INCLUDES *********************//
#include "xuartps.h"
#include "xbram.h"
#include "xgpio.h"

//************** FUNCTION DECLARATIONS ***************//

/*****************************************
 * Function name:	init_hw()
 * Description: 	Initializes the hardware
 * Arguments:
 *****************************************/
void init_hw(XUartPs* uart_handle, XBram* bram_handle, XGpio* gpio_handle, XGpio* flag_gpio_handle, XGpio* bit_gpio_handle);

#endif
