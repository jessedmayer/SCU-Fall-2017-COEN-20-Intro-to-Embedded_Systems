        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2



        .global     CallReturnOverhead
CallReturnOverhead:
        BX          LR

//uint32_t ReverseBits(uint32_t word);
        .global     ReverseBits
ReverseBits:
        LDR         R1,=0
        .rept       32
        LSLS        R0,R0,1         //Shifts one bit to the left and carries that value
        RRX         R1,R1           //Shifts to the right with the carried value
        .endr
        MOV         R0,R1
        BX          LR

//uint32_t ReverseBytes(uint32_t word);
        .global     ReverseBytes
ReverseBytes:
        UBFX        R1,R0,24,8      //Takes bits 24-31 of R0 and puts it in R1
        BFI         R2,R1,0,8       //Puts R1 into bits 0-7 of R2
        UBFX        R1,R0,16,8
        BFI         R2,R1,8,8
        UBFX        R1,R0,8,8
        BFI         R2,R1,16,8
        UBFX        R1,R0,0,8
        BFI         R2,R1,24,8
        MOV         R0,R2           //Moves the revered value of R0 into R0
        BX          LR

