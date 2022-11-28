/**
 ******************************************************************************
 * osci.h
 * Sandro Pedrett
 ******************************************************************************
 **/

#ifndef _OSCI_H
#define _OSCI_H

#include "xparameters.h"
#include "xil_types.h"


#define OSCI_DEVICE_ID XPAR_OSCITOCPU_0_DEVICE_ID
#define OSCI_INTERRUPT_ID XPAR_FABRIC_OSCI_0_CH1_IRQ_INTR


enum {
	REG_CH1_Ctrl       = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x00,
	REG_CH1_Trigger    = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x04,
	REG_CH1_Mode_Edge  = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x08,
	REG_CH1_Ram_Data   = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x0C,
	REG_CH1_Ram_Adr    = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x14,
	_res1              = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x18,
	_res2              = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x1C,
	_res3              = XPAR_OSCITOCPU_0_S00_AXI_BASEADDR + 0x20,
};

enum {
	BIT_CH1_EN = 0x01,
	BIT_CH1_RST = 0x02,
	BIT_CH1_TRIGGER_MODE = 0x04,
	BIT_CH1_TRIGGER_SEL = 0x04,
	BIT_CH1_TRIGGER_THRESHOLD = 0xFFFF0000,
	BIT_CH1_DATA = 0x0000FFFF,
	BIT_CH1_ADR = 0x00000FFF,
};

enum {
	ADD_TRIGGER_EN = REG_CH1_Ctrl,
	ADD_TRIGGER_EN = REG_CH1_Ctrl + 0x01,
	// TODO
};

/**
 * IRQ handler
 */
void OSCI_Handler(void *CallbackRef);

/**
 * Initialize osci
 */
int OSCI_Init();

/**
 * Indicates if data are ready
 */
int OSCI_DataReady();

/**
 * Read ram from fpga
 */
void OSCI_ReadData(u8 buffer[], u8 length);

/**
 * start osci
 */
void OSCI_StartAcquire();

/**
 * Clears inernal flags
 */
void OSCI_Clear();

#endif // _OSCI_H