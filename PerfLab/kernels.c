/********************************************************
 * Kernels to be optimized for the CS:APP Performance Lab
 ********************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "defs.h"
#include <string.h>
#define PGSIZE 4096
static int min(int a, int b) { return (a < b ? a : b); }
static int max(int a, int b) { return (a > b ? a : b); }
/* 
 * Please fill in the following team struct 
 */
team_t team = {
    "lmy",              /* Team name */

    "Harry Q. Bovik",     /* First member full name */
    "bovik@nowhere.edu",  /* First member email address */

    "lmy",                   /* Second member full name (leave blank if none) */
    "18300240005@fudan.edu.cn"                    /* Second member email addr (leave blank if none) */
};

/***************
 * ROTATE KERNEL
 ***************/

/******************************************************
 * Your different versions of the rotate kernel go here
 ******************************************************/

/* 
 * naive_rotate - The naive baseline version of rotate 
 */
char naive_rotate_descr[] = "naive_rotate: Naive baseline implementation";
void naive_rotate(int dim, pixel *src, pixel *dst) 
{
    int i, j;

    for (i = 0; i < dim; i++)
	for (j = 0; j < dim; j++)
	    dst[RIDX(dim-1-j, i, dim)] = src[RIDX(i, j, dim)];
}

/* 
 * rotate - Your current working version of rotate
 * IMPORTANT: This is the version you will be graded on
 */

char rotate_descr[] = "rotate2: Using 2 pointer";

void rotate(int dim, pixel *src, pixel *dst){
    #define move(dst,src) \
            *dst=*src; \
            src+=dim; \
            dst+=1;  
    #define update1(dst,src) \
            src++;  \
            src -= (dim<<5);    \
            dst-=32+dim;   
    #define update2(dst,src) \
            dst+=dst_base+dim; \
            dst+=32; \
            src += 31*dim;
    int i, j;
    int dst_base = (dim-1)*dim;
    dst += dst_base;
    for (i = 0; i < dim; i+=32){ 
            for (j = 0; j < dim; j++){ 
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);

                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);

                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);

                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src);
                move(dst,src); 

                update1(dst,src);
            }
            update2(dst,src);
        }
}

/*********************************************************************
 * register_rotate_functions - Register all of your different versions
 *     of the rotate kernel with the driver by calling the
 *     add_rotate_function() for each test function. When you run the
 *     driver program, it will test and report the performance of each
 *     registered test function.  
 *********************************************************************/

void register_rotate_functions() 
{
    add_rotate_function(&naive_rotate, naive_rotate_descr);   
    add_rotate_function(&rotate,rotate_descr);
    //add_rotate_function(&rotate_v7,rotate_v7_descr);
    /* ... Register additional test functions here */
}


/***************
 * SMOOTH KERNEL
 **************/

/***************************************************************
 * Various typedefs and helper functions for the smooth function
 * You may modify these any way you like.
 **************************************************************/

/* A struct used to compute averaged pixel value */
typedef struct {
    int red;
    int green;
    int blue;
    int num;
} pixel_sum;

/*
 * initialize_pixel_sum - Initializes all fields of sum to 0 
 */
static void initialize_pixel_sum(pixel_sum *sum) 
{
    sum->red = sum->green = sum->blue = 0;
    sum->num = 0;
    return;
}

/* 
 * accumulate_sum - Accumulates field values of p in corresponding 
 * fields of sum 
 */
static void accumulate_sum(pixel_sum *sum, pixel p) 
{
    sum->red += (int) p.red;
    sum->green += (int) p.green;
    sum->blue += (int) p.blue;
    sum->num++;
    return;
}

/* 
 * assign_sum_to_pixel - Computes averaged pixel value in current_pixel 
 */
static void assign_sum_to_pixel(pixel *current_pixel, pixel_sum sum) 
{
    current_pixel->red = (unsigned short) (sum.red/sum.num);
    current_pixel->green = (unsigned short) (sum.green/sum.num);
    current_pixel->blue = (unsigned short) (sum.blue/sum.num);
    return;
}

/* 
 * avg - Returns averaged pixel value at (i,j) 
 */
static pixel avg(int dim, int i, int j, pixel *src) 
{
    int ii, jj;
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    for(ii = max(i-1, 0); ii <= min(i+1, dim-1); ii++) 
	for(jj = max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
	    accumulate_sum(&sum, src[RIDX(ii, jj, dim)]);

    assign_sum_to_pixel(&current_pixel, sum);
    return current_pixel;
}

/******************************************************
 * Your different versions of the smooth kernel go here
 ******************************************************/

/*
 * naive_smooth - The naive baseline version of smooth 
 */
char naive_smooth_descr[] = "naive_smooth: Naive baseline implementation";
void naive_smooth(int dim, pixel *src, pixel *dst) 
{
    int i, j;

    for (i = 0; i < dim; i++)
	for (j = 0; j < dim; j++)
	    dst[RIDX(i, j, dim)] = avg(dim, i, j, src);
}

/*
 * smooth - Your current working version of smooth. 
 * IMPORTANT: This is the version you will be graded on
 */

char smooth_descr[] = "smooth: Current working version";

#define add_two_pixel(dest_sum,p1,p2) \
        (dest_sum).red = (int)(p1).red + (int)(p2).red; \
        (dest_sum).green = (int)(p1).green + (int)(p2).green; \
        (dest_sum).blue = (int)(p1).blue + (int)(p2).blue; 

#define add_three_pixel(dest_sum,p1,p2,p3) \
        (dest_sum).red = (int)(p1).red + (int)(p2).red + (int)(p3).red; \
        (dest_sum).green = (int)(p1).green + (int)(p2).green + (int)(p3).green;    \
        (dest_sum).blue = (int)(p1).blue + (int)(p2).blue + (int)(p3).blue;   

#define smooth_two_rows(dest,r1,r2,num) \
        (dest).red = (unsigned short)( ((r1).red+(r2).red)/(num) ); \
        (dest).green = (unsigned short)( ((r1).green+(r2).green)/(num) ); \
        (dest).blue = (unsigned short)( ((r1).blue+(r2).blue)/(num) );

#define smooth_three_rows(dest,r1,r2,r3,num) \
        (dest).red = (unsigned short)( ((r1).red+(r2).red+(r3).red )/(num) ); \
        (dest).green = (unsigned short)( ((r1).green+(r2).green+(r3).green )/(num) ); \
        (dest).blue = (unsigned short)( ((r1).blue+(r2).blue+(r3).blue )/(num) );

void smooth(int dim, pixel *src, pixel *dst) 
{
    pixel_sum tmp[512*512];
    // generate tmp
    int  i,j,jj;
    for(i=0;i<dim;i++){
        add_two_pixel(tmp[RIDX(i,0,dim)], src[RIDX(i,0,dim)], src[RIDX(i,1,dim)]);
        for(jj=1;jj<dim-1;jj++){
            add_three_pixel(tmp[RIDX(i,jj,dim)], src[RIDX(i,jj-1,dim)],src[RIDX(i,jj,dim)], src[RIDX(i,jj+1,dim)]);
        }
        add_two_pixel(tmp[RIDX(i,dim-1,dim)], src[RIDX(i,dim-2,dim)], src[RIDX(i,dim-1,dim)]);
    }

// i=0
    // j = 0
    smooth_two_rows(dst[RIDX(0,0,dim)],tmp[RIDX(0,0,dim)],tmp[RIDX(1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j++){
        smooth_two_rows(dst[RIDX(0,j,dim)],tmp[RIDX(0,j,dim)],tmp[RIDX(1,j,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(0,dim-1,dim)],tmp[RIDX(0,dim-1,dim)],tmp[RIDX(1,dim-1,dim)],4);
    
// i = dim-1
    // j = 0
    smooth_two_rows(dst[RIDX(dim-1,0,dim)],tmp[RIDX(dim-2,0,dim)],tmp[RIDX(dim-1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j++){
        smooth_two_rows(dst[RIDX(dim-1,j,dim)],tmp[RIDX(dim-2,j,dim)],tmp[RIDX(dim-1,j,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(dim-1,dim-1,dim)],tmp[RIDX(dim-2,dim-1,dim)],tmp[RIDX(dim-1,dim-1,dim)],4);
    
// 1 <= i <= dim-2
    for(i=1;i<dim-1;i++){
        // j = 0
        smooth_three_rows(dst[RIDX(i,0,dim)],tmp[RIDX(i-1,0,dim)],tmp[RIDX(i,0,dim)],tmp[RIDX(i+1,0,dim)],6);
        // 1<j<=dim-2
        for(j=1;j<dim-1;j++){
            smooth_three_rows(dst[RIDX(i,j,dim)],tmp[RIDX(i-1,j,dim)],tmp[RIDX(i,j,dim)],tmp[RIDX(i+1,j,dim)],9);
        }
        // j=dim-1
        smooth_three_rows(dst[RIDX(i,dim-1,dim)],tmp[RIDX(i-1,dim-1,dim)],tmp[RIDX(i,dim-1,dim)],tmp[RIDX(i+1,dim-1,dim)],6);
    }
}
char smooth2_descr[] = "smooth2: Current working version";
void smooth2(int dim, pixel *src, pixel *dst) 
{
    pixel_sum tmp[512*512];
    // generate tmp
    int  i,j,jj;
    for(i=0;i<dim;i++){
        add_two_pixel(tmp[RIDX(i,0,dim)], src[RIDX(i,0,dim)], src[RIDX(i,1,dim)]);
        for(jj=1;jj<dim-1;jj++){
            add_three_pixel(tmp[RIDX(i,jj,dim)], src[RIDX(i,jj-1,dim)],src[RIDX(i,jj,dim)], src[RIDX(i,jj+1,dim)]);
        }
        add_two_pixel(tmp[RIDX(i,dim-1,dim)], src[RIDX(i,dim-2,dim)], src[RIDX(i,dim-1,dim)]);
    }
// i=0
    // j = 0
    smooth_two_rows(dst[RIDX(0,0,dim)],tmp[RIDX(0,0,dim)],tmp[RIDX(1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j+=2){
        smooth_two_rows(dst[RIDX(0,j,dim)],tmp[RIDX(0,j,dim)],tmp[RIDX(1,j,dim)],6);
        smooth_two_rows(dst[RIDX(0,j+1,dim)],tmp[RIDX(0,j+1,dim)],tmp[RIDX(1,j+1,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(0,dim-1,dim)],tmp[RIDX(0,dim-1,dim)],tmp[RIDX(1,dim-1,dim)],4);
    
// i = dim-1
    // j = 0
    smooth_two_rows(dst[RIDX(dim-1,0,dim)],tmp[RIDX(dim-2,0,dim)],tmp[RIDX(dim-1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j+=2){
        smooth_two_rows(dst[RIDX(dim-1,j,dim)],tmp[RIDX(dim-2,j,dim)],tmp[RIDX(dim-1,j,dim)],6);
        smooth_two_rows(dst[RIDX(dim-1,j+1,dim)],tmp[RIDX(dim-2,j+1,dim)],tmp[RIDX(dim-1,j+1,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(dim-1,dim-1,dim)],tmp[RIDX(dim-2,dim-1,dim)],tmp[RIDX(dim-1,dim-1,dim)],4);
    
// 1 <= i <= dim-2
    for(i=1;i<dim-1;i+=2){
        // j = 0
        smooth_three_rows(dst[RIDX(i,0,dim)],tmp[RIDX(i-1,0,dim)],tmp[RIDX(i,0,dim)],tmp[RIDX(i+1,0,dim)],6);
        // 1<j<=dim-2
        for(j=1;j<dim-1;j+=2){
            smooth_three_rows(dst[RIDX(i,j,dim)],tmp[RIDX(i-1,j,dim)],tmp[RIDX(i,j,dim)],tmp[RIDX(i+1,j,dim)],9);
            smooth_three_rows(dst[RIDX(i,j+1,dim)],tmp[RIDX(i-1,j+1,dim)],tmp[RIDX(i,j+1,dim)],tmp[RIDX(i+1,j+1,dim)],9);
        }
        // j=dim-1
        smooth_three_rows(dst[RIDX(i,dim-1,dim)],tmp[RIDX(i-1,dim-1,dim)],tmp[RIDX(i,dim-1,dim)],tmp[RIDX(i+1,dim-1,dim)],6);
        // j = 0
        smooth_three_rows(dst[RIDX(i+1,0,dim)],tmp[RIDX(i,0,dim)],tmp[RIDX(i+1,0,dim)],tmp[RIDX(i+2,0,dim)],6);
        // 1<j<=dim-2
        for(j=1;j<dim-1;j+=2){
            smooth_three_rows(dst[RIDX(i+1,j,dim)],tmp[RIDX(i,j,dim)],tmp[RIDX(i+1,j,dim)],tmp[RIDX(i+2,j,dim)],9);
            smooth_three_rows(dst[RIDX(i+1,j+1,dim)],tmp[RIDX(i,j+1,dim)],tmp[RIDX(i+1,j+1,dim)],tmp[RIDX(i+2,j+1,dim)],9);
        }
        // j=dim-1
        smooth_three_rows(dst[RIDX(i+1,dim-1,dim)],tmp[RIDX(i,dim-1,dim)],tmp[RIDX(i+1,dim-1,dim)],tmp[RIDX(i+2,dim-1,dim)],6);
    }
}

char smooth3_descr[] = "smooth3: Current working version";
void smooth3(int dim, pixel *src, pixel *dst) 
{
    pixel_sum tmp[512*512];
    // generate tmp
    int  i,j,jj;
    int idx,__idx;
    for(i=0;i<dim;i++){
        add_two_pixel(tmp[RIDX(i,0,dim)], src[RIDX(i,0,dim)], src[RIDX(i,1,dim)]);
        for(jj=1;jj<dim-1;jj++){
            add_three_pixel(tmp[RIDX(i,jj,dim)], src[RIDX(i,jj-1,dim)],src[RIDX(i,jj,dim)], src[RIDX(i,jj+1,dim)]);
        }
        add_two_pixel(tmp[RIDX(i,dim-1,dim)], src[RIDX(i,dim-2,dim)], src[RIDX(i,dim-1,dim)]);
    }
// i=0
    // j = 0
    smooth_two_rows(dst[RIDX(0,0,dim)],tmp[RIDX(0,0,dim)],tmp[RIDX(1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j+=2){
        smooth_two_rows(dst[RIDX(0,j,dim)],tmp[RIDX(0,j,dim)],tmp[RIDX(1,j,dim)],6);
        smooth_two_rows(dst[RIDX(0,j+1,dim)],tmp[RIDX(0,j+1,dim)],tmp[RIDX(1,j+1,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(0,dim-1,dim)],tmp[RIDX(0,dim-1,dim)],tmp[RIDX(1,dim-1,dim)],4);
    
// i = dim-1
    // j = 0
    smooth_two_rows(dst[RIDX(dim-1,0,dim)],tmp[RIDX(dim-2,0,dim)],tmp[RIDX(dim-1,0,dim)],4);
    // 1<j<=dim-2
    for(j=1;j<dim-1;j+=2){
        smooth_two_rows(dst[RIDX(dim-1,j,dim)],tmp[RIDX(dim-2,j,dim)],tmp[RIDX(dim-1,j,dim)],6);
        smooth_two_rows(dst[RIDX(dim-1,j+1,dim)],tmp[RIDX(dim-2,j+1,dim)],tmp[RIDX(dim-1,j+1,dim)],6);
    }
    // j=dim-1
    smooth_two_rows(dst[RIDX(dim-1,dim-1,dim)],tmp[RIDX(dim-2,dim-1,dim)],tmp[RIDX(dim-1,dim-1,dim)],4);
    
// 1 <= i <= dim-2
    for(i=1;i<dim-1;i+=2){
        idx = RIDX(i,0,dim);
        // j = 0
        smooth_three_rows(dst[idx],tmp[idx-dim],tmp[idx],tmp[idx+dim],6);
        // 1<j<=dim-2
        __idx = RIDX(i,dim-1,dim);
        for(j=1;j<dim-1;j+=2){
            smooth_three_rows(dst[idx+j],tmp[idx+j-dim],tmp[idx+j],tmp[idx+j+dim],9);
            smooth_three_rows(dst[idx+j+1],tmp[idx+j+1-dim],tmp[idx+j+1],tmp[idx+j+1+dim],9);
        }
        // j=dim-1
        smooth_three_rows(dst[__idx],tmp[__idx-dim],tmp[__idx],tmp[__idx+dim],6);
        
        // j = 0
        smooth_three_rows(dst[idx+dim],tmp[idx],tmp[idx+dim],tmp[idx+dim*2],6);
        // 1<j<=dim-2
        for(j=1;j<dim-1;j+=2){
            smooth_three_rows(dst[idx+j+dim],tmp[idx+j],tmp[idx+j+dim],tmp[idx+j+dim*2],9);
            smooth_three_rows(dst[idx+j+1+dim],tmp[idx+j+1],tmp[idx+j+dim+1],tmp[idx+j+1+dim*2],9);
        }
        // j=dim-1
        smooth_three_rows(dst[__idx+dim],tmp[__idx],tmp[__idx+dim],tmp[__idx+dim*2],6);
    }
}
/********************************************************************* 
 * register_smooth_functions - Register all of your different versions
 *     of the smooth kernel with the driver by calling the
 *     add_smooth_function() for each test function.  When you run the
 *     driver program, it will test and report the performance of each
 *     registered test function.  
 *********************************************************************/

void register_smooth_functions() {
    add_smooth_function(&smooth, smooth_descr);
    add_smooth_function(&smooth2,smooth2_descr);
    add_smooth_function(&smooth3,smooth3_descr);
    add_smooth_function(&naive_smooth, naive_smooth_descr);
    
    /* ... Register additional test functions here */
}

 