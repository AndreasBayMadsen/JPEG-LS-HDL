/*******************************************************************
 * Module name: platform
 * Purpose: 	Contains functions for configuring the system
 *******************************************************************/
#ifndef __PLATFORM_H_
#define __PLATFORM_H_

//********************* INCLUDES *********************//
#include "xuartps.h"
#include "xgpio.h"

//********************* DEFINES **********************//
#define CAM_CONFIG				0
#define REQUEST_NEXT			1
#define	CLEAR_NEW_DATA_READY	2
#define CAM_CONNECT				3

#define FLAG_READ_ALLOWED		0
#define	FLAG_NEW_DATA_READY		1
#define FLAG_END_OF_DATA		2
#define	FLAG_CAM_CONFIG_DONE	3

//************** FUNCTION DECLARATIONS ***************//

/*****************************************
 * Function name:	init_hw()
 * Description: 	Initializes the hardware
 * Arguments:
 *****************************************/
void init_hw(XUartPs* uart_handle, XGpio* bitstream_gpio_handle, XGpio* control_gpio_handle);

#endif
