/**
 ******************************************************************************
 * AXI_BIT.h
 * Lukas Leuenberger
 * V1.0.0
 * 24-July-2018
 * This file contains some functions to manipulate AXI registers
 ******************************************************************************
 **/

#ifndef _AXI_BIT_H
#define _AXI_BIT_H

/**
 ******************************************************************************
 * Axi Set function
 ******************************************************************************
 **/
void AXI_setBitPattern(u32 baseAddress,
                       u8 bitPattern);

/**
 ******************************************************************************
 * Axi Clear function
 ******************************************************************************
 **/
void AXI_clearBitPattern(u32 baseAddress,
                         u8 bitPattern);

/**
 ******************************************************************************
 * Axi Read function
 ******************************************************************************
 **/
u8 AXI_readBitPattern(u32 baseAddress,
                      u8 bitPattern);

#endif // _AXI_BIT_H
