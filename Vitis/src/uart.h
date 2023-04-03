/*******************************************************************
 * Module name: uart
 * Purpose: 	Contains functions for controlling the UART
 *******************************************************************/
#ifndef __UART_H_
#define __UART_H_

//********************* INCLUDES *********************//
#include <unistd.h>

#include "xuartps.h"

//************** FUNCTION DECLARATIONS ***************//

/*****************************************
 * Function name: 	uart_init()
 * Description: 	Initializes the UART
 *****************************************/
void uart_init(XUartPs* handle);

/*****************************************
 * Function name: 	uart_receive()
 * Description: 	Blocks until data is received and
 * 						then returns the data
 *****************************************/
uint8_t uart_receive(XUartPs* handle);

/*****************************************
 * Function name: 	uart_transmit()
 * Description: 	Transmits data
 *****************************************/
void uart_transmit(uint32_t data, XUartPs* handle);

#endif
