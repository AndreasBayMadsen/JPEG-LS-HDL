/*******************************************************************
 * Module name: main
 * Purpose: 	Contains the main function of the program
 *******************************************************************/

//********************* INCLUDES *********************//
#include <unistd.h>

#include "platform.h"
#include "uart.h"

#include "xuartps.h"
#include "xgpio.h"

//********************* DEFINES **********************//


//************ GLOBAL OBJECT DECLARATIONS ************//
// Handlers
XUartPs UART_PS_0;
XGpio	BITSTREAM_GPIO;
XGpio	CONTROL_GPIO;

//*************** FUNCTION DEFINITIONS ***************//

int main()
{
	// VARIABLE DECLARTIONS
	// Flag variables
	uint8_t start = 0;

	uint8_t flags = 0;
	uint8_t read_allowed = 1;
	uint8_t new_data_ready = 0;
	uint8_t end_of_data = 0;

	uint8_t read_allowed_old = 1;

	// Data variables
	uint32_t bit_data_high = 0;
	uint32_t bit_data_low = 0;

	// INITIALIZATION
	init_hw(&UART_PS_0, &BITSTREAM_GPIO, &CONTROL_GPIO);

	// ACTUAL PROGRAM
	while (1)
	{
		start = uart_receive(&UART_PS_0);	// Wait to receive start signal

		// Get camera frame
		XGpio_DiscreteWrite(&CONTROL_GPIO, 2, (1<<CAM_CONNECT));
		do
		{
			read_allowed_old = read_allowed;
			flags = XGpio_DiscreteRead(&CONTROL_GPIO, 1);
			read_allowed = flags & (1<<FLAG_READ_ALLOWED);
		} while (!(read_allowed && !read_allowed_old));
		XGpio_DiscreteWrite(&CONTROL_GPIO, 2, 0);

		// Send bitstream back
		do
		{
			// Request new 64 bit word
			XGpio_DiscreteWrite(&CONTROL_GPIO, 2, 0x02);	// Request data and stop clearing 'new_data_ready'
			do	// Wait for 'new_data_ready'
			{
				flags = XGpio_DiscreteRead(&CONTROL_GPIO, 1);
				new_data_ready = flags & (1<<FLAG_NEW_DATA_READY);
			} while (!new_data_ready);
			XGpio_DiscreteWrite(&CONTROL_GPIO, 2, 0x04);	// Stop data request and clear 'new_data_ready'

			// Read data
			bit_data_high = XGpio_DiscreteRead(&BITSTREAM_GPIO, 2);	// MSB
			bit_data_low = XGpio_DiscreteRead(&BITSTREAM_GPIO, 1);	// LSB

			// Transmit data
			uart_transmit(bit_data_high, &UART_PS_0);
			uart_transmit(bit_data_low, &UART_PS_0);

			// Check for 'end_of_data'
			end_of_data		= flags & (1<<FLAG_END_OF_DATA);
			if (end_of_data)
			{
				break;
			}

		} while (1);

		// Reset
		start = 0;

		flags = 0;
		read_allowed = 1;
		new_data_ready = 0;
		end_of_data = 0;

		read_allowed_old = 1;

		bit_data_high = 0;
		bit_data_low = 0;
	}

	return 0;
}
