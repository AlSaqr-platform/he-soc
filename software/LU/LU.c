//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "encoding.h"
#include "utils.h"
#include "data.h"

unsigned int get_core_num() { return 1; }
unsigned int rt_core_id() { return 0; }
unsigned int synch_barrier() { barrier(); }

#define F 10000

#define MIN(a, b) (((a)<(b))? (a): (b))
#define ABS(a)    (((a)>=0)? (a): (-(a)))

int lu_in[N*N];
int lu_out[N*N];
int *G[N];
int pivots[N];
volatile int error_status;

static inline int factor(int *A[], int m, int n, int pivot[])
{
  int i, j, k, ii;
  int minMN = MIN(m,n);
  int num_cores = get_core_num();
  int id = rt_core_id();

  for (j=0; j<minMN; ++j)
  {

    // find pivot in column j and  test for singularity.
    int jp=j;

    int t = ABS(A[j][j]);

    if(id == 0)  // core 0
      {

        for (i=j+1; i<m; ++i)
          {
            int ab = ABS(A[i][j]);
            if (ab > t)
              {
                jp = i;
                t = ab;
              }
          }

        pivot[j] = jp;

        // jp now has the index of maximum element 
        // of column j, below the diagonal

        if (A[jp][j] == 0 )
          {
            printf("ERROR DETECTED = %d\n", id);
            error_status = 1;       // factorization failed because of zero pivot
          }

        if (jp != j)
          {
            // swap rows j and jp
            int *tA = A[j];
            A[j] = A[jp];
            A[jp] = tA;
          }
      }

    synch_barrier();

    if(error_status == 1) return 1;

    //#pragma omp parallel
    {
      if (j<m-1)                // compute elements j+1:M of jth column
        {
          // note A(j,j), was A(jp,p) previously which was
          // guarranteed not to be zero (Label #1)

          int recp = (F * F) / A[j][j];

          //#pragma omp for
          for (k=j+1; k<m; ++k)
            {
              if( (k%num_cores) != id) continue;
              A[k][j] *= recp;
              A[k][j] /= F;
            }
        }

      if (j < minMN-1)
        {
          // rank-1 update to trailing submatrix:   E = E - x*y;
          //
          // E is the region A(j+1:M, j+1:N)
          // x is the column vector A(j+1:M,j)
          // y is row vector A(j,j+1:N)

          //#pragma omp for
          for (ii=j+1; ii<m; ++ii)
            {
              if( (ii%num_cores) != id) continue;
              int jj;
              int *Aii = A[ii];
              int *Aj  = A[j];
              int AiiJ = Aii[j];
              for (jj=j+1; jj<n; ++jj)
                {
                  Aii[jj] -= (AiiJ * Aj[jj])/F;
                }
            }
        }
    }  // parallel

    synch_barrier();

  }

  return 0;
}


int main(int argc, char const *argv[]) {

  int baud_rate = 115200;
  int test_freq = 50000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("Hello!\r\n");
  int i, j;
  int num_cores = get_core_num();
  int id,hc;
  int time = 0;
  int error = 0;

  id = rt_core_id();

  if (id == 0)
    printf("Starting LU application... \r\n");

  for (i=0; i<N*N; ++i)
    lu_in[i] = lu[i];

  for(i=0; i<N; ++i)
    G[i] = lu_in + N*i;

  synch_barrier();


  stats(factor(G, N, N, pivots),10)


  if (id == 0)
    printf("...LU application complete!  Errors: %d\r\n",error);


  return 0;
}
 


