/*******************************************************************
 * Module name: main
 * Purpose: 	Contains the main function of the program
 *******************************************************************/

//********************* INCLUDES *********************//
#include <unistd.h>

#include "platform.h"
#include "uart.h"
#include "bram.h"
#include "gpio.h"

#include "xuartps.h"
#include "xbram.h"
#include "xgpio.h"

//********************* DEFINES **********************//
#define IMAGE_WIDTH		320
#define IMAGE_HEIGHT	240

#define IMAGE_PIXELS	IMAGE_WIDTH*IMAGE_HEIGHT
#define IMAGE_BYTES		2*IMAGE_PIXELS

#define BRAM(A)			((volatile uint32_t*)(BRAM_0.Config.MemBaseAddress))[A]

//************ GLOBAL OBJECT DECLARATIONS ************//
// Handlers
XUartPs UART_PS_0;
XBram	BRAM_0;
XGpio	GPIO_0;

//*************** FUNCTION DEFINITIONS ***************//

int main()
{
	init_hw(&UART_PS_0, &BRAM_0, &GPIO_0);	// Initialize

	// Buffers and counters
	uint32_t buffer_32 = 0;
	uint8_t buffer_count = 0;

	uint8_t buffer_8 = 0;
	uint32_t rx_count = 0;

	uint32_t addr_count = 0;

	// Start
	while(1)
	{
		// Store image received over UART
		while (rx_count < IMAGE_BYTES)
		{
			// Receive data
			buffer_8 = uart_receive(&UART_PS_0);
			rx_count++;

			// Store in buffer
			buffer_32 = (buffer_32 << 8) | buffer_8;
			buffer_count++;

			// Store accumulated 32-bit buffer in BRAM
			if (buffer_count >= 4)
			{
				BRAM(addr_count) = buffer_32;
				addr_count++;

				buffer_8 = 0x00;
				buffer_count = 0;
			}
		}

		// Print all data
		for (uint32_t idx=0; idx<addr_count; idx++)
		{
			uart_transmit(BRAM(idx), &UART_PS_0);
			for(uint32_t i=0; i<100000; i++);
		}

		// Start image compression
		gpio_set(&GPIO_0);
		for (uint8_t i=0; i<200; i++);	// Wait
		gpio_clear(&GPIO_0);

		// Reset
		buffer_8 = 0;
		rx_count = 0;
		buffer_32 = 0;
		buffer_count = 0;
		addr_count = 0;
	}

	return 0;
}
