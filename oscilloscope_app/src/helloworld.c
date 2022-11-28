/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "int.h"
#include "osci.h"
#include "uart.h"
#include "xil_printf.h"


#define RAM_SIZE 255


void process(u8 header1, u8 header2);

int main() {
    init_platform();

    // Print some string over the UART
    xil_printf("\r\noscilloscope\r\n");

    // Initialize the interrupts
    INT_init();
    OSCI_Init();
    UART_Init();

    INT_enable();

    while (1) {
    	// wait for header
    	u8 header1 = UART_Read();
    	u8 header2 = UART_Read();

    	process(header1, header2);
    }

    cleanup_platform();
    return 0;
}

void process(u8 header1, u8 header2) {
	// For PC software
	if ((header1 & 0x80) != 0) {
		return;
	}

	u8 tag = header1 & 0x0F;

	if (tag == 0b001) { // START
		// start Osci
		OSCI_StartAcquire();

		// wait for data
		while (OSCI_DataReady() == 0);

		static u8 buffer[RAM_SIZE];
		OSCI_ReadData(buffer, RAM_SIZE);

		// send header
		UART_Write(0b10000010); // ToPC and Acquiere
		UART_Write(RAM_SIZE);   // length
		for (int i = 0; i < RAM_SIZE; i++) {
			UART_Write(buffer[i]);
		}
	}
	else if (tag == 0b1000) { // TriggerEdge
		// TODO
	}
}