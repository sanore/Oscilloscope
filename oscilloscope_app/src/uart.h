/**
 ******************************************************************************
 * osci.h
 * Sandro Pedrett
 ******************************************************************************
 **/

#ifndef _UART_H
#define _UART_H

#include "xparameters.h"
#include "xil_types.h"

/**
 * Read blocking a single byte
 */
u8 UART_Read();

/**
 * Write blocking a single byte
 */
void UART_Write(u8 buffer[], u32 length);
void UART_WriteByte(u8 buffer);

/**
 * Initialize osci
 */
int UART_Init();

#endif // _UART_H
