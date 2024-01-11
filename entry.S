/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Thomas Vogt
 * Sven Reis
 **/

.section .vectors, "ax"
.align 2
.globl __Vectors
.globl __Vectors_End
.globl __Vectors_Size

__Vectors:
.long __StackTop         /*     Top of Stack */
.long Reset_Handler      /*     Reset Handler */
.long NMI_Handler        /* -14 NMI Handler */
.long HardFault_Handler  /* -13 Hard Fault Handler */
.long MemManage_Handler  /* -12 MPU Fault Handler */
.long BusFault_Handler   /* -11 Bus Fault Handler */
.long UsageFault_Handler /* -10 Usage Fault Handler */
.long 0                  /*     Reserved */
.long 0                  /*     Reserved */
.long 0                  /*     Reserved */
.long 0                  /*     Reserved */
.long SVC_Handler        /*  -5 SVC Handler */
.long DebugMon_Handler   /*  -4 Debug Monitor Handler */
.long 0                  /*     Reserved */
.long PendSV_Handler     /*  -2 PendSV Handler */
.long SysTick_Handler    /*  -1 SysTick Handler */

/* Interrupts */
.long Interrupt0_Handler /*   0 Interrupt 0 */
.long Interrupt1_Handler /*   1 Interrupt 1 */
.long Interrupt2_Handler /*   2 Interrupt 2 */
.long Interrupt3_Handler /*   3 Interrupt 3 */
.long Interrupt4_Handler /*   4 Interrupt 4 */
.long Interrupt5_Handler /*   5 Interrupt 5 */
.long Interrupt6_Handler /*   6 Interrupt 6 */
.long Interrupt7_Handler /*   7 Interrupt 7 */
.long Interrupt8_Handler /*   8 Interrupt 8 */
.long Interrupt9_Handler /*   9 Interrupt 9 */

.space   (214 * 4)                          /* Interrupts 10 .. 224 are left out */
__Vectors_End:
.equ     __Vectors_Size, __Vectors_End - __Vectors
.size    __Vectors, . - __Vectors
.section .text
.align 2

.global Reset_Handler
.type Reset_Handler, %function
.extern (SystemInit)

Reset_Handler:
  b SystemInit

endless_loop:
  NOP
  b endless_loop

/* The default macro is not used for HardFault_Handler
 * because this results in a poor debug illusion.
 */
.type    HardFault_Handler, %function
.weak    HardFault_Handler
/* .fnstart */
HardFault_Handler:
    b        .
/* .fnend */
.size    HardFault_Handler, . - HardFault_Handler


.type    Default_Handler, %function
.weak    Default_Handler
/* .fnstart */
Default_Handler:
    b        .
/* .fnend */
.size    Default_Handler, . - Default_Handler

/* Macro to define default exception/interrupt handlers.
 * Default handler are weak symbols with an endless loop.
 * They can be overwritten by real handlers.
 */
.macro   Set_Default_Handler  Handler_Name
.weak    \Handler_Name
.set     \Handler_Name, Default_Handler
.endm


/* Default exception/interrupt handler */
Set_Default_Handler  NMI_Handler
Set_Default_Handler  MemManage_Handler
Set_Default_Handler  BusFault_Handler
Set_Default_Handler  UsageFault_Handler
Set_Default_Handler  SVC_Handler
Set_Default_Handler  DebugMon_Handler
Set_Default_Handler  PendSV_Handler
Set_Default_Handler  SysTick_Handler

Set_Default_Handler  Interrupt0_Handler
Set_Default_Handler  Interrupt1_Handler
Set_Default_Handler  Interrupt2_Handler
Set_Default_Handler  Interrupt3_Handler
Set_Default_Handler  Interrupt4_Handler
Set_Default_Handler  Interrupt5_Handler
Set_Default_Handler  Interrupt6_Handler
Set_Default_Handler  Interrupt7_Handler
Set_Default_Handler  Interrupt8_Handler
Set_Default_Handler  Interrupt9_Handler

.end
