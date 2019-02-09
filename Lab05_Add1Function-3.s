        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2


//Void DeleteItem(int32_t data[],int32_t items,int32_t index);
        .global     DeleteItem
DeleteItem: SUB         R1,R1,1             //Sets R1 to highest possible index #

        f1: CMP         R2,R1               //Compares index with highest possible index #
            BGE         f2
            ADD         R2,R2,1
            LDR         R12,[R0,R2,LSL2]    //R12<--data[R2+1]
            SUB         R2,R2,1
            STR         R12,[R0,R2,LSL2]    //R12--->data[R2]
            ADD         R2,R2,1             //R2++
            B           f1

        f2: BX          LR

//Void InsertItem(int32_t data[],int32_t items,int32_t index,int32_t value);
        .global     InsertItem
InsertItem: PUSH        {R4,LR}
            SUB         R4,R1,2             //Sets R4 to highest index -1

        f3: CMP         R4,R2               //Compares R4 with index
            BLT         f4
            LDR         R12,[R0,R4,LSL2]    //R12<---data[R4]
            ADD         R4,R4,1
            STR         R12,[R0,R4,LSL2]    //R12--->data[R4+1]
            SUB         R4,R4,2             //R12--
            B           f3

        f4: STR         R3,[R0,R2,LSL2]     //R3--->data[R2]
            POP         {R4,PC}


        .end

