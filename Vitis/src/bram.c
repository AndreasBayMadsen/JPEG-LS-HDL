/*******************************************************************
 * Module name: bram
 * Purpose: 	Contains functions for configuring BRAM
 *******************************************************************/

//********************* INCLUDES *********************//
#include "bram.h"

#include "xbram.h"
#include "xparameters.h"

//*************** FUNCTION DEFINITIONS ***************//

/*****************************************
 * Function name: 	bram_init()
 * Description: 	Initializes the BRAM
 *****************************************/
void bram_init(XBram* handle)
{
	XBram_Config* bram_config;

	// Load BRAM configuration
	bram_config = XBram_LookupConfig(XPAR_BRAM_0_DEVICE_ID);

	XBram_CfgInitialize(handle, bram_config, bram_config->CtrlBaseAddress);
}
