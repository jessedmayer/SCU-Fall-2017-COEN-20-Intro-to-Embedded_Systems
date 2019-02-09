        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2


// void UseLDRB(void *dst, void *src);
        .global     UseLDRB
UseLDRB:
        .rept       512         //repeats block of code before .endr 512 times
        LDRB        R2,[R1],1
        STRB        R2,[R0],1
        .endr
        BX          LR

// void UseLDRH(void *dst, void *src)
        .global     UseLDRH
UseLDRH:
        .rept       256
        LDRH        R2,[R1],2     //R2<--R1+2
        STRH        R2,[R0],2
        .endr
        BX          LR


// void UseLDR(void *dst, void *src)
        .global     UseLDR
UseLDR:
        .rept       128
        LDR         R2,[R1],4       //R2<---R1+4
        STR         R2,[R0],4
        .endr
        BX          LR


// void UseLDRD(void *dst, void *src)
        .global     UseLDRD
UseLDRD:
        .rept       64
        LDRD        R2,[R1],8       //R2<----R1+4
        STRD        R2,[R0],8
        .endr
        BX          LR


// void UseLDMIA(void *dst, void *src)
        .global     UseLDMIA
UseLDMIA:
        PUSH        {R4-R11}
        .rept       11
        LDMIA       R0!,{R2-R12}
        STMIA       R1!,{R2-R12}
        .endr
        LDMIA       R0,{R2-R8}      //copies remaining 28 bytes
        STMIA       R1,{R2-R8}
        POP         {R4-R11}
        BX          LR

        .end

