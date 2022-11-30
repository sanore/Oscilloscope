#include "osci.h"
#include "int.h"
#include "AXI_BIT.h"

static int s_dataReady = 0;

/**
 ******************************************************************************
 * This is the interrupt handler routine for the OSCI .
 ******************************************************************************
 **/
void OSCI_Handler(void *CallbackRef) {
	INT_disable();

	s_dataReady += 1;

	INT_enable();
}

void OSCI_ReadData(u8 buffer[], u8 length) {
	for (int i = 0; i < length; i++) {
		buffer[i] = i;
		// TODO read ram
	}
}

void OSCI_StartAcquire() {
	OSCI_Clear();

	AXI_setBitPattern(ADD_CH1_EN, BIT_CH1_EN);

	// TODO remove test
	s_dataReady += 1;
}

int OSCI_Init() {
	int status;

	status = INT_connect(OSCI_INTERRUPT_ID, (XInterruptHandler) OSCI_Handler, 0);
	if (status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int OSCI_DataReady() {
	return s_dataReady;
}

void OSCI_Clear() {
	s_dataReady = 0;
}
