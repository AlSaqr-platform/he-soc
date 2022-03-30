// See LICENSE for license details.

//**************************************************************************
// Dhrystone bencmark
//--------------------------------------------------------------------------
//
// This is the classic Dhrystone synthetic integer benchmark.
//

#pragma GCC optimize ("no-inline")

#include "dhrystone.h"
#include "dhrystone.c"

#include "utils.h"
#include "encoding.h"

#include <alloca.h>

/* Global Variables: */

Rec_Pointer     Ptr_Glob,
                Next_Ptr_Glob;
int             Int_Glob;
Boolean         Bool_Glob;
char            Ch_1_Glob,
                Ch_2_Glob;
int             Arr_1_Glob [50];
int             Arr_2_Glob [50] [50];

Enumeration     Func_1 ();
  /* forward declaration necessary since Enumeration may not simply be int */

#ifndef REG
        Boolean Reg = false;
#define REG
        /* REG becomes defined as empty */
        /* i.e. no register variables   */
#else
        Boolean Reg = true;
#undef REG
#define REG register
#endif

Boolean		Done;

long            Begin_Time,
                End_Time,
                User_Time;
long            Microseconds,
                Dhrystones_Per_Second;

/* end of variables for time measurement */


int main (int argc, char** argv)
/*****/
  /* main program, corresponds to procedures        */
  /* Main and Proc_0 in the Ada version             */
{
        One_Fifty       Int_1_Loc;
  REG   One_Fifty       Int_2_Loc;
        One_Fifty       Int_3_Loc;
  REG   char            Ch_Index;
        Enumeration     Enum_Loc;
        Str_30          Str_1_Loc;
        Str_30          Str_2_Loc;
  REG   int             Run_Index;
  REG   int             Number_Of_Runs;

  /* Arguments */
  Number_Of_Runs = NUMBER_OF_RUNS;

  /* Initializations */

  Next_Ptr_Glob = (Rec_Pointer) alloca (sizeof (Rec_Type));
  Ptr_Glob = (Rec_Pointer) alloca (sizeof (Rec_Type));

  Ptr_Glob->Ptr_Comp                    = Next_Ptr_Glob;
  Ptr_Glob->Discr                       = Ident_1;
  Ptr_Glob->variant.var_1.Enum_Comp     = Ident_3;
  Ptr_Glob->variant.var_1.Int_Comp      = 40;
  strcpy (Ptr_Glob->variant.var_1.Str_Comp, 
          "DHRYSTONE PROGRAM, SOME STRING");
  strcpy (Str_1_Loc, "DHRYSTONE PROGRAM, 1'ST STRING");

  Arr_2_Glob [8][7] = 10;
        /* Was missing in published program. Without this statement,    */
        /* Arr_2_Glob [8][7] would have an undefined value.             */
        /* Warning: With 16-Bit processors and Number_Of_Runs > 32000,  */
        /* overflow may occur for this array element.                   */

  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("\r\n");
  uart_wait_tx_done();
  printf("Dhrystone Benchmark, Version %s\r\n", Version);
  uart_wait_tx_done();
  if (Reg)
  {
    printf("Program compiled with 'register' attribute\r\n");
  uart_wait_tx_done();
  }
  else
  {
    printf("Program compiled without 'register' attribute\r\n");
  uart_wait_tx_done();
  }
  printf("Using %s, HZ=%d\r\n", CLOCK_TYPE, HZ);
  uart_wait_tx_done();
  printf("\r\n");
  uart_wait_tx_done();

  Done = false;
  while (!Done) {
    printf("Trying %d runs through Dhrystone:\r\n", Number_Of_Runs);
  uart_wait_tx_done();

    /***************/
    /* Start timer */
    /***************/

    Begin_Time = read_csr(mcycle);

    for (Run_Index = 1; Run_Index <= Number_Of_Runs; ++Run_Index)
    {

      Proc_5();
      Proc_4();
	/* Ch_1_Glob == 'A', Ch_2_Glob == 'B', Bool_Glob == true */
      Int_1_Loc = 2;
      Int_2_Loc = 3;
      strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 2'ND STRING");
      Enum_Loc = Ident_2;
      Bool_Glob = ! Func_2 (Str_1_Loc, Str_2_Loc);
	/* Bool_Glob == 1 */
      while (Int_1_Loc < Int_2_Loc)  /* loop body executed once */
      {
	Int_3_Loc = 5 * Int_1_Loc - Int_2_Loc;
	  /* Int_3_Loc == 7 */
	Proc_7 (Int_1_Loc, Int_2_Loc, &Int_3_Loc);
	  /* Int_3_Loc == 7 */
	Int_1_Loc += 1;
      } /* while */
	/* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
      Proc_8 (Arr_1_Glob, Arr_2_Glob, Int_1_Loc, Int_3_Loc);
	/* Int_Glob == 5 */
      Proc_1 (Ptr_Glob);
      for (Ch_Index = 'A'; Ch_Index <= Ch_2_Glob; ++Ch_Index)
			       /* loop body executed twice */
      {
	if (Enum_Loc == Func_1 (Ch_Index, 'C'))
	    /* then, not executed */
	  {
	  Proc_6 (Ident_1, &Enum_Loc);
	  strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 3'RD STRING");
	  Int_2_Loc = Run_Index;
	  Int_Glob = Run_Index;
	  }
      }
	/* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
      Int_2_Loc = Int_2_Loc * Int_1_Loc;
      Int_1_Loc = Int_2_Loc / Int_3_Loc;
      Int_2_Loc = 7 * (Int_2_Loc - Int_3_Loc) - Int_1_Loc;
	/* Int_1_Loc == 1, Int_2_Loc == 13, Int_3_Loc == 7 */
      Proc_2 (&Int_1_Loc);
	/* Int_1_Loc == 5 */

    } /* loop "for Run_Index" */

    /**************/
    /* Stop timer */
    /**************/

    End_Time = read_csr(mcycle);

    User_Time = End_Time - Begin_Time;

    if (User_Time < Too_Small_Time)
    {
      printf("Measured time too small to obtain meaningful results\r\n");
  uart_wait_tx_done();
      Number_Of_Runs = Number_Of_Runs * 10;
      printf("\r\n");
  uart_wait_tx_done();
    } else Done = true;
  }

  printf("Final values of the variables used in the benchmark:\r\n");
  uart_wait_tx_done();
  printf("\r\n");
  uart_wait_tx_done();
  printf("Int_Glob:            %d\r\n", Int_Glob);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 5);
  uart_wait_tx_done();
  printf("Bool_Glob:           %d\r\n", Bool_Glob);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 1);
  uart_wait_tx_done();
  printf("Ch_1_Glob:           %c\r\n", Ch_1_Glob);
  uart_wait_tx_done();
  printf("        should be:   %c\r\n", 'A');
  uart_wait_tx_done();
  printf("Ch_2_Glob:           %c\r\n", Ch_2_Glob);
  uart_wait_tx_done();
  printf("        should be:   %c\r\n", 'B');
  uart_wait_tx_done();
  printf("Arr_1_Glob[8]:       %d\r\n", Arr_1_Glob[8]);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 7);
  uart_wait_tx_done();
  printf("Arr_2_Glob[8][7]:    %d\r\n", Arr_2_Glob[8][7]);
  uart_wait_tx_done();
  printf("        should be:   Number_Of_Runs + 10\r\n");
  uart_wait_tx_done();
  printf("Ptr_Glob->\r\n");
  uart_wait_tx_done();
  printf("  Ptr_Comp:          %d\r\n", (long) Ptr_Glob->Ptr_Comp);
  uart_wait_tx_done();
  printf("        should be:   (implementation-dependent)\r\n");
  uart_wait_tx_done();
  printf("  Discr:             %d\r\n", Ptr_Glob->Discr);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 0);
  uart_wait_tx_done();
  printf("  Enum_Comp:         %d\r\n", Ptr_Glob->variant.var_1.Enum_Comp);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 2);
  uart_wait_tx_done();
  printf("  Int_Comp:          %d\r\n", Ptr_Glob->variant.var_1.Int_Comp);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 17);
  uart_wait_tx_done();
  printf("  Str_Comp:          %s\r\n", Ptr_Glob->variant.var_1.Str_Comp);
  uart_wait_tx_done();
  printf("        should be:   DHRYSTONE PROGRAM, SOME STRING\r\n");
  uart_wait_tx_done();
  printf("Next_Ptr_Glob->\r\n");
  uart_wait_tx_done();
  printf("  Ptr_Comp:          %d\r\n", (long) Next_Ptr_Glob->Ptr_Comp);
  uart_wait_tx_done();
  printf("        should be:   (implementation-dependent), same as above\r\n");
  uart_wait_tx_done();
  printf("  Discr:             %d\r\n", Next_Ptr_Glob->Discr);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 0);
  uart_wait_tx_done();
  printf("  Enum_Comp:         %d\r\n", Next_Ptr_Glob->variant.var_1.Enum_Comp);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 1);
  uart_wait_tx_done();
  printf("  Int_Comp:          %d\r\n", Next_Ptr_Glob->variant.var_1.Int_Comp);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 18);
  uart_wait_tx_done();
  printf("  Str_Comp:          %s\r\n", Next_Ptr_Glob->variant.var_1.Str_Comp);
  uart_wait_tx_done();
  printf("        should be:   DHRYSTONE PROGRAM, SOME STRING\r\n");
  uart_wait_tx_done();
  printf("Int_1_Loc:           %d\r\n", Int_1_Loc);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 5);
  uart_wait_tx_done();
  printf("Int_2_Loc:           %d\r\n", Int_2_Loc);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 13);
  uart_wait_tx_done();
  printf("Int_3_Loc:           %d\r\n", Int_3_Loc);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 7);
  uart_wait_tx_done();
  printf("Enum_Loc:            %d\r\n", Enum_Loc);
  uart_wait_tx_done();
  printf("        should be:   %d\r\n", 1);
  uart_wait_tx_done();
  printf("Str_1_Loc:           %s\r\n", Str_1_Loc);
  uart_wait_tx_done();
  printf("        should be:   DHRYSTONE PROGRAM, 1'ST STRING\r\n");
  uart_wait_tx_done();
  printf("Str_2_Loc:           %s\r\n", Str_2_Loc);
  uart_wait_tx_done();
  printf("        should be:   DHRYSTONE PROGRAM, 2'ND STRING\r\n");
  uart_wait_tx_done();
  printf("\r\n");
  uart_wait_tx_done();


  printf("Cycles for one run through Dhrystone: %d\r\n", User_Time/Number_Of_Runs);
  uart_wait_tx_done();

  return 0;
}


Proc_1 (Ptr_Val_Par)
/******************/

REG Rec_Pointer Ptr_Val_Par;
    /* executed once */
{
  REG Rec_Pointer Next_Record = Ptr_Val_Par->Ptr_Comp;  
                                        /* == Ptr_Glob_Next */
  /* Local variable, initialized with Ptr_Val_Par->Ptr_Comp,    */
  /* corresponds to "rename" in Ada, "with" in Pascal           */
  
  structassign (*Ptr_Val_Par->Ptr_Comp, *Ptr_Glob); 
  Ptr_Val_Par->variant.var_1.Int_Comp = 5;
  Next_Record->variant.var_1.Int_Comp 
        = Ptr_Val_Par->variant.var_1.Int_Comp;
  Next_Record->Ptr_Comp = Ptr_Val_Par->Ptr_Comp;
  Proc_3 (&Next_Record->Ptr_Comp);
    /* Ptr_Val_Par->Ptr_Comp->Ptr_Comp 
                        == Ptr_Glob->Ptr_Comp */
  if (Next_Record->Discr == Ident_1)
    /* then, executed */
  {
    Next_Record->variant.var_1.Int_Comp = 6;
    Proc_6 (Ptr_Val_Par->variant.var_1.Enum_Comp, 
           &Next_Record->variant.var_1.Enum_Comp);
    Next_Record->Ptr_Comp = Ptr_Glob->Ptr_Comp;
    Proc_7 (Next_Record->variant.var_1.Int_Comp, 10, 
           &Next_Record->variant.var_1.Int_Comp);
  }
  else /* not executed */
    structassign (*Ptr_Val_Par, *Ptr_Val_Par->Ptr_Comp);
} /* Proc_1 */


Proc_2 (Int_Par_Ref)
/******************/
    /* executed once */
    /* *Int_Par_Ref == 1, becomes 4 */

One_Fifty   *Int_Par_Ref;
{
  One_Fifty  Int_Loc;  
  Enumeration   Enum_Loc;

  Int_Loc = *Int_Par_Ref + 10;
  do /* executed once */
    if (Ch_1_Glob == 'A')
      /* then, executed */
    {
      Int_Loc -= 1;
      *Int_Par_Ref = Int_Loc - Int_Glob;
      Enum_Loc = Ident_1;
    } /* if */
  while (Enum_Loc != Ident_1); /* true */
} /* Proc_2 */


Proc_3 (Ptr_Ref_Par)
/******************/
    /* executed once */
    /* Ptr_Ref_Par becomes Ptr_Glob */

Rec_Pointer *Ptr_Ref_Par;

{
  if (Ptr_Glob != Null)
    /* then, executed */
    *Ptr_Ref_Par = Ptr_Glob->Ptr_Comp;
  Proc_7 (10, Int_Glob, &Ptr_Glob->variant.var_1.Int_Comp);
} /* Proc_3 */


Proc_4 () /* without parameters */
/*******/
    /* executed once */
{
  Boolean Bool_Loc;

  Bool_Loc = Ch_1_Glob == 'A';
  Bool_Glob = Bool_Loc | Bool_Glob;
  Ch_2_Glob = 'B';
} /* Proc_4 */


Proc_5 () /* without parameters */
/*******/
    /* executed once */
{
  Ch_1_Glob = 'A';
  Bool_Glob = false;
} /* Proc_5 */
