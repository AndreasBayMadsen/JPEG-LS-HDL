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
XGpio	FLAG_GPIO;
XGpio	BIT_GPIO;

//*************** FUNCTION DEFINITIONS ***************//

int main()
{
	init_hw(&UART_PS_0, &BRAM_0, &GPIO_0, &FLAG_GPIO, &BIT_GPIO);	// Initialize

	// Buffers and counters
	uint32_t buffer_32 = 0;
	uint8_t buffer_count = 0;

	uint8_t buffer_8 = 0;
	uint32_t rx_count = 0;

	uint32_t addr_count = 0;

	uint32_t bit_data_high = 0;
	uint32_t bit_data_low = 0;

	// Flag variables
	uint8_t flags = 0;
	uint8_t read_allowed = 0;
	uint8_t new_data_ready = 0;
	uint8_t end_of_data = 0;

	uint8_t read_allowed_old = 1;

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

		// Start image compression
		gpio_set(&GPIO_0);

		// Wait for compression to finish
		while (1)
		{
			flags = XGpio_DiscreteRead(&FLAG_GPIO, 1);
			read_allowed	= flags & (1<<0);

			// Detect rising edge on 'read_allowed'
			if (read_allowed && !read_allowed_old)
			{
				break;
			}
			read_allowed_old = read_allowed;
		};
		gpio_clear(&GPIO_0);

		// Send bitstream back
		do
		{
			// Request new 64 bit word
			XGpio_DiscreteWrite(&FLAG_GPIO, 2, 0x01);	// Request data and stop clearing 'new_data_ready'
			do	// Wait for 'new_data_ready'
			{
				flags = XGpio_DiscreteRead(&FLAG_GPIO, 1);
				new_data_ready = flags & (1<<1);
			} while (!new_data_ready);
			XGpio_DiscreteWrite(&FLAG_GPIO, 2, 0x02);	// Stop data request and clear 'new_data_ready'

			// Read data
			bit_data_high = XGpio_DiscreteRead(&BIT_GPIO, 2);	// MSB
			bit_data_low = XGpio_DiscreteRead(&BIT_GPIO, 1);	// LSB

			// Transmit data
			uart_transmit(bit_data_high, &UART_PS_0);
			uart_transmit(bit_data_low, &UART_PS_0);

			// Check for 'end_of_data'
			end_of_data		= flags & (1<<2);
			if (end_of_data)
			{
				break;
			}

		} while (1);

		// Reset
		buffer_8 = 0;
		rx_count = 0;
		buffer_32 = 0;
		buffer_count = 0;
		addr_count = 0;

		bit_data_high = 0;
		bit_data_low = 0;

		flags = 0;
		read_allowed = 0;
		new_data_ready = 0;
		end_of_data = 0;

		read_allowed_old = 1;
	}

	return 0;
}
