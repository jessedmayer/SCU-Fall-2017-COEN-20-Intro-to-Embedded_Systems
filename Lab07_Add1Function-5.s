        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2



        .global     CallReturnOverhead
CallReturnOverhead:
        BX          LR

        .global     SDIVby13
SDIVby13:
        MOV         R1,13
        SDIV        R0,R0,R1
        BX          LR

        .global     UDIVby13
UDIVby13:
        MOV         R1,13
        UDIV        R0,R0,R1
        BX          LR

//int32_t MySDIVby13(int32_t dividend) ;
        .global     MySDIVby13
MySDIVby13://generated code
        LDR         R1,=0x4EC4EC4F
        SMMUL       R1,R1,R0
        ASR         R1,R1,2             //Divides R1 by 4
        ADD         R0,R1,R0,LSR 31     //Adds the sign of R0 to R1 and stores in R0
        BX          LR

//uint32_t MyUDIVby13(uint32_t dividend) ;
        .global     MyUDIVby13
MyUDIVby13://generated code
        LDR         R1,=0x4EC4EC4F
        UMULL       R2,R1,R1,R0
        LSR         R0,R1,2             //Divides R1 by 4 and stores in R0
        BX          LR
