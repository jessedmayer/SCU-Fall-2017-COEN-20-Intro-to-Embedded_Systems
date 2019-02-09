        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2
one:    .float      1.0
zero:   .float      0.0

//float FloatPoly(float x, float a[], int32_t n) ;
        .global     FloatPoly
FloatPoly:
        VMOV        S1,S0           //S1=x
        VLDR        S0,zero         //S0=poly
        VLDR        S3,one          //S3=x^0

next:   CBZ         R1,done
        VLDMIA      R0!,{s2}
        VMLA.F32    S0,S2,S3
        VMUL.F32    S3,S3,S1        //S3=x^++
        SUB         R1,R1,1
        B           next

done:   BX          LR





//Q16 FixedPoly(Q16 x, Q16 a[], int32_t n) ;
        .global     FixedPoly
FixedPoly:
        PUSH        {R4,R5,R6,LR}

        LDR         R6,=1

next2:  CBZ         R2,done2
        LDR         R12,[R1],4

        SMULL       R4,R5,R6,R12
        LSR         R4,R4,16        //Extract middle 32 bits
        ORR         R4,R4,R5,LSL16

        AND         R6,R6,R6,ASR31
        SUB         R3,R3,R6
        AND         R12,R12,R12,ASR31
        SUB         R3,R3,R12

        MUL         R6,R6,R0        //R6=R6*x
        ADD         R3,R3,R4        //R3=poly+poly[i]*x

        SUB         R2,R2,1         //R2=n--
        B           next2


done2:  MOV         R0,R3
        POP         {R4,R5,R6,PC}
