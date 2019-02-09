        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

//int32_t Discriminant(int32_t a, int32_t b, int32_t c);
        .global     Discriminant
Discriminant:
        LDR         R3,=4
        MUL         R1,R1,R1    //R1<--(b*b)
        MUL         R2,R0,R2    //R2<--(a*c)
        MUL         R2,R2,R3    //R2<--(4*a*c)
        SUB         R0,R1,R2    //R0<--(b*b-4*a*c)
        BX          LR

//int32_t Root1(int32_t a, int32_t b, int32_t sqrt_d);
        .global     Root1
Root1:  RSB         R1,R1,0     //R1<--(-b)
        ADD         R1,R1,R2    //R1<--(-b+sqrt_d)
        LDR         R3,=2
        MUL         R0,R0,R3    //R0<--(2*a)
        SDIV        R0,R1,R0    //R0<--(-b+sqrt_d)/(2*a)
        BX          LR

//int32_t Root2(int32_t a, int32_t b, int32_t sqrt_d);
        .global     Root2
Root2:  RSB         R1,R1,0
        SUB         R1,R1,R2    //R1<--(-b-sqrt_d)
        LDR         R3,=2
        MUL         R0,R0,R3
        SDIV        R0,R1,R0
        BX          LR

        .end

