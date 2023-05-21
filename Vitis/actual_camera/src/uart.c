/*******************************************************************
 * Module name: uart
 * Purpose: 	Contains functions for controlling the UART
 *******************************************************************/

//********************* INCLUDES *********************//
#include <unistd.h>

#include "uart.h"

#include "xuartps.h"
#include "xparameters.h"

//*************** FUNCTION DEFINITIONS ***************//

/*****************************************
 * Function name: 	uart_init()
 * Description: 	Initializes the UART
 *****************************************/
void uart_init(XUartPs* handle)
{
	XUartPs_Config* uart_config;

	// Load UART configuration
	uart_config = XUartPs_LookupConfig(XPAR_XUARTPS_0_DEVICE_ID);

	XUartPs_CfgInitialize(handle, uart_config, uart_config->BaseAddress);
}

/*****************************************
 * Function name: 	uart_receive()
 * Description: 	Blocks until data is received and
 * 						then returns the data
 *****************************************/
uint8_t uart_receive(XUartPs* handle)
{
	return XUartPs_RecvByte(handle->Config.BaseAddress);
}

/*****************************************
 * Function name: 	uart_transmit()
 * Description: 	Transmits data
 *****************************************/
void uart_transmit(uint32_t data, XUartPs* handle)
{
	XUartPs_SendByte(handle->Config.BaseAddress, (uint8_t)(data>>24));
	XUartPs_SendByte(handle->Config.BaseAddress, (uint8_t)(data>>16));
	XUartPs_SendByte(handle->Config.BaseAddress, (uint8_t)(data>>8));
	XUartPs_SendByte(handle->Config.BaseAddress, (uint8_t)(data>>0));
}
