/******************************************************************************/
/**
 ******************************************************************************
 * int.h
 * Lukas Leuenberger
 * V1.0.0
 * 04-June-2018
 * This file contains the interrupt functions
 ******************************************************************************
 **/

#ifndef _INT_H
#define _INT_H

/**
 ******************************************************************************
 * Include Files
 ******************************************************************************
 **/
#include "xparameters.h"
#include "xscugic.h"

/**
 ******************************************************************************
 * Global definitions
 ******************************************************************************
 **/
#define INT_DEVICE_ID XPAR_PS7_SCUGIC_0_DEVICE_ID
#define INTC_INTERRUPT_ID_0 61 // IRQ_F2P[0:0]

/**
 ******************************************************************************
 * Initalizes the UART
 ******************************************************************************
 **/
int INT_init();

/**
 ******************************************************************************
 * Enables all interrupts
 ******************************************************************************
 **/
void INT_enable();

/**
 ******************************************************************************
 * Disables all interrupts
 ******************************************************************************
 **/
void INT_disable();

/**
 ******************************************************************************
 * Enables an interrupt
 ******************************************************************************
 **/
void INT_enableInterrupt(u8 Id);

/**
 ******************************************************************************
 * Disables an interrupt
 ******************************************************************************
 **/
void INT_disableInterrupt(u8 Id);

/**
 ******************************************************************************
 * Makes the connection between the Id of the interrupt source and the
 * associated handler that is to run when the interrupt is recognized. The
 * argument provided in this call as the Callbackref is used as the argument
 * for the handler when it is called. In Cascade mode, connects handler to
 * Slave controller handler table depending on the interrupt Id.
 *
 * WARNING: The handler provided as an argument will overwrite any handler
 * that was previously connected.
 ******************************************************************************
 **/
int INT_connect(u8 Id, Xil_InterruptHandler Handler, void *CallBackRef);

/**
 ******************************************************************************
 * Changes the priority
 ******************************************************************************
 **/
void INT_setPriorityTriggerType (u32 Int_Id, u8 Priority, u8 Trigger);

#endif // _INT_H
