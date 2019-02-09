        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// void SIMD_USatAdd(uint8_t bytes[], uint32_t count, uint8_t amount) ;
        .global     SIMD_USatAdd
SIMD_USatAdd:
        PUSH        {R4,R5,R6,R7,R8,R9,R10,R11,LR}
        BFI         R2,R2,8,8
        BFI         R2,R2,16,16

loop:   CMP         R1,40
        BLT         next
        LDMIA       R0,{R3-R12}     //Loads 40 bytes into R3-R12
        UQADD8      R3,R3,R2        //Adds R2 to each byte of R3
        UQADD8      R4,R4,R2
        UQADD8      R5,R5,R2
        UQADD8      R6,R6,R2
        UQADD8      R7,R7,R2
        UQADD8      R8,R8,R2
        UQADD8      R9,R9,R2
        UQADD8      R10,R10,R2
        UQADD8      R11,R11,R2
        UQADD8      R12,R12,R2
        STMIA       R0!,{R3-R12}    //Stores the updated bytes back in R0
        SUB         R1,R1,40        //Decrements amount by 40
        B           loop

next:   CBZ         R1,done
        LDR         R3,[R0]         //Loads 4 bytes of R0 into R3
        UQADD8      R3,R3,R2
        STR         R3,[R0],4
        SUB         R1,R1,4         //Decrements amount by 4
        B           next

done:  POP         {R4,R5,R6,R7,R8,R9,R10,R11,PC}
