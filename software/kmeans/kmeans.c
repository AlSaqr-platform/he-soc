#include <stdio.h>
#include <stdlib.h>
#include "encoding.h"
#include "utils.h"

#include "config.h"
#include "data_def.h"
#include "out_ref.h"
 
#ifdef VECTOR_MODE
typedef FLOAT    VDTYPE    __attribute__ ((vector_size (4)));
#endif


//double __extendohfdf2(float16alt value)
//{
//  float result;
//  __asm__ __volatile__ ("fcvt.s.ah %0, %1": "=f"(result): "f"(value) :);
//  return (double) result;
//}
//
//double __extendhfdf2(float16 value)
//{
//  float result;
//  __asm__ __volatile__ ("fcvt.s.h %0, %1": "=f"(result): "f"(value) :);
//  return (double) result;
//}

void check_result(FLOAT *x, int r){
    //i_cl_team_barrier();
    
    float diff = 0.0f;
    int err = 0;

    for(int i = 0; i < r; i++){  
            diff = fabs(x[i] - check[i]);
            
                if(diff>THR){
                    err++;
                    #ifdef VERBOSE
                    printf("Error at index %d:\t expected %f\t real %f\t error %f\n", i, check[i], x[i], diff);
                    #endif
                }
        }

    if(err != 0)
        printf("TEST FAILED with %d errors!!\n", err);
    else
        printf("TEST PASSED!!\n");
    
    //return;
    }
 

FLOAT newClusters[N_CLUSTERS][N_COORDS];
int   newClusterSize[N_CLUSTERS];
FLOAT  clustersData[N_CLUSTERS*N_COORDS];
int membership[N_OBJECTS];
FLOAT    delta;          /* % of objects change their clusters */
int loop;
#if NUM_CORES > 1
FLOAT local_newClusters[NUM_CORES][N_CLUSTERS][N_COORDS];
int   local_newClusterSize[NUM_CORES][N_CLUSTERS];
FLOAT local_delta[NUM_CORES];
#endif

//typedef float16    v2f16    __attribute__ ((vector_size (4)));
//typedef FLOAT    v2f16    __attribute__ ((vector_size (4)));

/* square of Euclid distance between two multi-dimensional points            */
static __attribute__ ((always_inline))
FLOAT euclid_dist_2(int    numdims,  /* no. dimensions */
                    FLOAT *coord1,   /* [numdims] */
                    FLOAT *coord2)   /* [numdims] */
{
    int i;
    FLOAT ans = 0.0f;

#ifdef VECTOR_MODE
    VDTYPE temp = (VDTYPE) {0,0};
    VDTYPE temp2 = (VDTYPE) {0,0};
    VDTYPE *a =  (VDTYPE *)coord1;
    VDTYPE *b =  (VDTYPE *)coord2;
    i=0;
    //for (i=0; i<N_COORDS/2; i++)
    do
    {
      temp2 = (a[i] - b[i]);
      temp += temp2 * temp2;
      //temp  += (a[i] - b[i]) * (a[i] - b[i]);
      i++;
    
    }
    while(i<N_COORDS/2);
    
    ans = temp[0] + temp[1];

#else
    //for (i=0; i<N_COORDS; i++)
 
    i=0;
    do
    {
       
        FLOAT a = coord1[i];
        FLOAT b = coord2[i]; 
        ans += (a-b)*(a-b); 
        i++;

    }while(i<N_COORDS);

#endif

    return(ans);
}



static __attribute__ ((always_inline))
int find_nearest_cluster(int     numClusters, /* no. clusters */
                         int     numCoords,   /* no. coordinates */
                         FLOAT  *object,      /* [N_COORDS] */
                         FLOAT **clusters)    /* [N_CLUSTERS][N_COORDS] */
{
    int   index, i;
    FLOAT dist, min_dist;

    /* find the cluster id that has min distance to object */
    index    = 0;
    min_dist = euclid_dist_2(N_COORDS, object, clusters[0]);

    //for (i=1; i<N_CLUSTERS; i++) {
      
    i=1;
    do{ 
        
        dist = euclid_dist_2(N_COORDS, object, clusters[i]);
        /* no need square root */
        if (dist < min_dist) { /* find the min and its array index */
            min_dist = dist;
            index    = i;
        }
        i++;
    }while(i<N_CLUSTERS);
    return(index);
}
 
#pragma GCC pop_options
 

#define MAX_ITERATIONS  500
#define THRESHOLD       0.0010f

FLOAT* clusters[N_CLUSTERS];
/* return an array of cluster centers of size [N_CLUSTERS][N_COORDS]       */
int main(int argc, char const *argv[]) {
    //volatile FLOAT* clusters[N_CLUSTERS];
    int i, j, k, index;
    int baud_rate = 115200;
    int test_freq = 50000000;
    uart_set_cfg(0,(test_freq/baud_rate)>>4);

#if NUM_CORES > 1
    int core_id = pi_core_id();

    if(core_id == 0) {
#endif

    loop = 0;

    // allocate a 2D space for returning variable clusters[] (coordinates
    //   of cluster centers)  
    clusters[0] = &clustersData[0];
    for (i=1; i<N_CLUSTERS; i++)
        clusters[i] = clusters[i-1] + N_COORDS;

    // pick first N_CLUSTERS elements of objects[] as initial cluster centers 
    for (i=0; i<N_CLUSTERS; i++)
        for (j=0; j<N_COORDS; j++)
            clusters[i][j] = objects[i][j];

    // initialize membership[]  
    for (i=0; i<N_OBJECTS; i++) membership[i] = -1;

    // need to initialize newClusterSize and newClusters[0] to all 0  
    for (i=0; i<N_CLUSTERS; i++) {
      newClusterSize[i] = 0;
      for (j=0; j<N_COORDS; j++)
        newClusters[i][j] = 0.0f;
    }

#if NUM_CORES > 1
    }

    const int blockSize = (N_OBJECTS+NUM_CORES-1) / NUM_CORES;
    const int start = core_id*blockSize;
    int end = start+blockSize;//(start+blockSize > N_OBJECTS? N_OBJECTS: start+blockSize);
    if(end > N_OBJECTS) end = N_OBJECTS;

    const int blockSize2 = (N_CLUSTERS+NUM_CORES-1) / NUM_CORES;
    const int start2 = core_id*blockSize2;
    int end2 = start2+blockSize2;
    if (end2 > N_CLUSTERS) end2 = N_CLUSTERS;

    for (j=0; j<N_CLUSTERS; j++) {
      local_newClusterSize[core_id][j] = 0;
      for (k=0; k<N_COORDS; k++)
        local_newClusters[core_id][j][k] = 0.0f;
    }

#endif

    START_STATS(1);

    do {
#if NUM_CORES == 1
        delta = 0.0f;

        for (i=0; i<N_OBJECTS; i++) {
#else
        local_delta[core_id] = 0;

        for (i=start; i<end; i++) {
#endif
            // find the array index of nestest cluster center 
            index = find_nearest_cluster(N_CLUSTERS, N_COORDS, objects[i], clusters);
            //printf("Index = %d\n", index);

            // if membership changes, increase delta by 1 
#if NUM_CORES == 1
            if (membership[i] != index) delta += 1.0f;
#else
            if (membership[i] != index) local_delta[core_id] += 1.0f;
#endif
            // assign the membership to object i 
            membership[i] = index;

#if NUM_CORES == 1
            // update new cluster centers : sum of objects located within 
            newClusterSize[index]++;
            for (j=0; j<N_COORDS; j++) {
                newClusters[index][j] += objects[i][j];
                // unsigned int reg;
                // __asm__ __volatile__ ("frcsr %0" : "=r" (reg): : );
                // printf("reg = %x\n", reg);
                // __asm__ __volatile__ ("fscsr x0" : : : );
                //printf("### %d %d %x\n", (int)(newClusters[index][j]*1000), (int)(objects[i][j]*1000.0f), *((int*)&objects[i][j]));
              }
#else
            // update new cluster centers : sum of all objects located
            //   within (average will be performed later) 
            local_newClusterSize[core_id][index]++;
            for (j=0; j<N_COORDS; j++)
                local_newClusters[core_id][index][j] += objects[i][j];
#endif
        }

#if NUM_CORES > 1

        pi_cl_team_barrier();
        if(core_id == 0) {
            delta = local_delta[0];
            for (j=1; j<NUM_CORES; j++) delta += local_delta[j];
        }

        // let the main thread perform the array reduction 
        for (i=start2; i<end2; i++) {
            for (j=0; j<NUM_CORES; j++) {
                newClusterSize[i] += local_newClusterSize[j][i];
                asm volatile("": : :"memory");
                local_newClusterSize[j][i] = 0.0f;
                for (k=0; k<N_COORDS; k++) {
                    newClusters[i][k] += local_newClusters[j][i][k];
                    asm volatile("": : :"memory");
                    local_newClusters[j][i][k] = 0.0f;
                }
            }
        }
        pi_cl_team_barrier();
        if(core_id == 0) {
#endif

            // average the sum and replace old cluster centers with newClusters 
            for (i=0; i<N_CLUSTERS; i++) {
                for (j=0; j<N_COORDS; j++) {
                    if (newClusterSize[i] > 0) {
                        clusters[i][j] = newClusters[i][j] / newClusterSize[i];
                     }
                    newClusters[i][j] = 0.0f;   // set back to 0 
                }
                newClusterSize[i] = 0;   // set back to 0 
            }

            delta /= N_OBJECTS;
            loop++;

#if NUM_CORES > 1
        }
        pi_cl_team_barrier();
#endif
    } while (delta > (FLOAT)THRESHOLD && loop < MAX_ITERATIONS);

    
        STOP_STATS();
pi_cl_team_barrier();
#ifdef CHECK
    FLOAT check_vect[N_CLUSTERS*N_COORDS];
    int c = 0;
    if(pi_core_id() == 0)
    {    
        for (i=0; i<N_CLUSTERS; i++) {
            for (j=0; j<N_COORDS; j++) {
              check_vect[c] = clusters[i][j];
              c++;
            }
            
        }
        check_result(check_vect, N_CLUSTERS*N_COORDS);
    } 
#endif

    return;
 
}
