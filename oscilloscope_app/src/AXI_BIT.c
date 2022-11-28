/**
 ******************************************************************************
 * AXI_BIT.c
 * Lukas Leuenberger
 * V1.0.0
 * 24-July-2018
 * This file contains some functions to manipulate AXI registers
 ******************************************************************************
 **/

/**
 ******************************************************************************
 * Include Files
 ******************************************************************************
 **/
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <Xparameters.h>
#include <Xil_types.h>
#include <Xil_io.h>

/**
 ******************************************************************************
 * Axi Set function
 ******************************************************************************
 **/
void AXI_setBitPattern(u32 baseAddress,
                       u8 bitPattern)
{
  // indicate which byte of the 32 bit word
  // is edited
  u8 ByteSelect = baseAddress & 0x00000003;
  u32 tmp32;
  tmp32 = Xil_In32(baseAddress & 0xFFFFFFFC); // address aligned
  tmp32 |= (0x00000000 | bitPattern << (8 * ByteSelect));
  Xil_Out32(baseAddress & 0xFFFFFFFC, tmp32);
}

/**
 ******************************************************************************
 * Axi Clear function
 ******************************************************************************
 **/
void AXI_clearBitPattern(u32 baseAddress,
                         u8 bitPattern)
{
  // indicate which byte of the 32 bit word
  // is edited
  u8 ByteSelect = baseAddress & 0x00000003;
  u32 tmp32;
  tmp32 = ~((0x00000000 | bitPattern) << (8 * ByteSelect));
  tmp32 &= Xil_In32(baseAddress & 0xFFFFFFFC); // address aligned
  Xil_Out32(baseAddress & 0xFFFFFFFC, tmp32);
}

/**
 ******************************************************************************
 * Axi Read function
 ******************************************************************************
 **/
u8 AXI_readBitPattern(u32 baseAddress,
                      u8 bitPattern)
{
  // indicate which byte of the 32 bit word
  // is edited
  u8 ByteSelect = baseAddress & 0x00000003;
  u32 tmp32;
  tmp32 = ((0x00000000 | bitPattern) << (8 * ByteSelect));
  tmp32 = tmp32 & Xil_In32(baseAddress & 0xFFFFFFFC); // address aligned
  return tmp32 >> (8 * ByteSelect);
}
