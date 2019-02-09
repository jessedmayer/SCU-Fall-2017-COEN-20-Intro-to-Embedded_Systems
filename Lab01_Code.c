#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "library.h"

void Dec2Bin(float x, int bin[8]){
	//Scale by 2^8
    x=x*256;

    //Initialize non-float value of x
    int num=x;

    //Round up
    if(x-num>=0.5){
        num++;
    }

    //Integer Division
    for(int i=0;i<8;i++){
        bin[i]=num%2;
        num=num/2;
    }
	// To be implemented by student
	// Input Parameter: 0.0 < X < 1.0
	// Output Parameter: bin[0] = Least significant bit
	//                   bin[7] = Most significant bit
	// Return value: None
	}

float Bin2Dec(int bin[8])
	{
    //Initialize Decimal Value to 0.
    float ret=0.0;

    //Convert to integer and scale by 2^8
    for(int i=7;i>=0;i--){
        ret=2*ret+bin[i];
    }

    //Scale back to fraction
    return ret/256;
	// To be implemented by student
	// Input Parameter: bin[0] = Least significant bit
	//                  bin[7] = Most significant bit
	// Return value: 0.0 < float < 1.0
	}

void PrintBinary(int bin[8]) ;

#define ENTRIES(a) (sizeof(a)/sizeof(a[0]))

typedef struct
	{
	float	x ;
	int		rounded ;
	int     truncated ;
	} TESTCASE ;

int Correct(int [8], TESTCASE *) ;

int main(void)
	{
	TESTCASE testcase[] =
		{
		{0.005,	  1,    1},
		{0.010,	  3,    2},
		{0.050,  13,   12},
		{0.100,  26,   25},
		{0.300,  77,   76},
		{0.700, 179,  179},
		{0.900, 230,  230}
		} ;
	int k ;

	InitializeHardware(HEADER, "LAB #1") ;

	for (k= 0; k < ENTRIES(testcase); k++)
		{
		float x1, x2, abserr, percent ;
		int bin[8] ;

		x1 = testcase[k].x ;
		printf("Testcase #%d:  x = %f\n", k + 1, x1) ;

		Dec2Bin(x1, bin) ;
		PrintBinary(bin) ;
		switch (Correct(bin, &testcase[k]))
			{
            case 0: // correct (rounded)
                x2 = Bin2Dec(bin) ;
                printf("Back to Decimal = %f\n", x2) ;
                abserr = fabs(x1 - x2) ;
                percent = 100 * abserr / x1 ;
                printf("Difference = %f (%.2f%c)\n", abserr, percent, '%') ;
                break ;
            case 1: // incorrect (truncated)
                printf("--- ERROR: NOT ROUNDED! ---\n") ;
                break ;
            case 2: // incorrect (wrong)
                printf("--- ERROR: BAD CONVERSION! ---\n") ;
                break ;
			}

		printf("\nPress blue push button to continue\n") ;
		WaitForPushButton() ;
		ClearDisplay() ;
		}

	printf("--- FINISHED ---\n") ;
	while (1) ;
	return 0 ;
	}

void PrintBinary(int bin[8])
	{
	// bin[0] = Least significant bit
	// bin[7] = Most significant bit
	int k ;

	printf("Converted 2 Bin = 0.") ;
	for (k = 7; k >= 0; k--) printf("%d", bin[k]) ;
	printf("\n") ;
	}

int Correct(int bin[8], TESTCASE *t)
	{
	// bin[0] = Least significant bit
	// bin[7] = Most significant bit
	int k, dec ;

    dec = 0 ;
	for (k = 7; k >= 0; k--)
		{
        dec = 2 * dec + bin[k] ;
		}
    if (dec == t->rounded) return 0 ;
    if (dec == t->truncated) return 1 ;
    return 2 ;
	}
