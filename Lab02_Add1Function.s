        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     Ten32
Ten32:
        BX          LR

        .global     Ten64
Ten64:
        LDR         R1,=0     //promotes from 32 to 64 bits
        BX          LR

        .global     Incr
Incr:
        ADD         R0,R0,1     //Adds 1 to R0
        BX          LR

        .global     Nested1
Nested1:
        PUSH        {LR}
        BL          rand        //calls function rand
        ADD         R0,R0,1     //adds 1 to the result of rand in R0
        POP         {PC}

        .global     Nested2
Nested2:
        PUSH        {R4,LR}     //Preserves R4
        BL          rand        //calss function rand
        MOV         R4,R0       //Stores R0 in R4
        BL          rand        //calls function rand
        ADD         R0,R0,R4    //Adds R4 to the new value of R0
        POP         {R4,PC}     //Restores R4

        .global     PrintTwo
PrintTwo:
        PUSH        {R4,R5,LR}  //Preserves R4,R5
        MOV         R4,R0       //Stores R0 in R4
        MOV         R5,R1       //Stores R1 in R5
        ADD         R5,R5,1     //Adds 1 to R5
        BL          printf      //calls function printf
        MOV         R0,R4       //Stores R4 in R0
        MOV         R1,R5       //Stores R5 in R1
        BL          printf      //calls function printf
        POP         {R4,R5,PC}  //Restores R4,R5

        .end

