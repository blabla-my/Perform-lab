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
char rotate_descr[] = "rotate: Current working version";

#define COPY(d,s) *(d)=*(s)
void rotate(int dim, pixel *src, pixel *dst) 
{
    int i, j, k;
    int dst_base = (dim-1)*dim;
    dst += dst_base;
    for (i = 0; i < dim; i+=32){ 
            for (j = 0; j < dim; j++){ 
                for(k=0;k<31;k++){
                    *dst=*src;
                    src+=dim;
                    dst+=1;
                }
                *dst=*src;
                src++;
                src -= (dim<<5)-dim;
                dst-=31+dim;
            }
        dst+=dst_base+dim;
        dst+=32;
        src += 31*dim;
    }
}

char rotate2_descr[] = "rotate2: Using 2 pointer";

void rotate2(int dim, pixel *src, pixel *dst){
    #define move(dst,src) *dst=*src; \
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


char new_rotate_descr[] = "new_rotate";
void new_rotate(int dim,pixel *src,pixel *dst){
    /*
    for(int i=0;i<dim;i++){
        for(int j=0;j<dim;j++){
            dst[RIDX(i, j, dim)] = src[RIDX(j, dim-1-i, dim)];
        }
    }
    */
   int i,j,k;
   for(j=0;j<dim;j+=32){
       for(i=dim-1;i>=0;i--){
           for(k=0;k<32;k++){
               dst[RIDX(i,j+k,dim)] = src[RIDX(j+k,dim-1-i,dim)];
           }
       }
   }
}
char rotate1_descr[] = "rotate1";
void rotate1(int dim, pixel * src , pixel* dst){
    int i,j,k;
    int rowsize = 32;
    if(dim == 1024) rowsize = 88;
    if(dim == 64) rowsize = 32;
    for(j=0;j < dim- dim % rowsize;j+=rowsize){
        for(i=dim-1;i>=0;i--){
            for(k=0;k<rowsize;k++){
                dst[RIDX(i,j+k,dim)] = src[RIDX(j+k,dim-1-i,dim)];
            }
        }
    }
    for(i=dim-1;i>=0;i--){
        for(;j<dim;j++){
             dst[RIDX(i,j,dim)] = src[RIDX(j,dim-1-i,dim)];
        }
    }
}

char rotate_v7_descr[] = "rotate_v7";
void rotate_v7(int dim, pixel *src, pixel *dst){
    int i, j, s, t, a, b;
    //a, b用于缓存
    s = (dim - 1) * dim;
    t = 0;
    for (j = 0; j < dim; j++){
        a = s;
        b = t;
        for (i = 0; i < dim; i++){
            dst[s] = src[t];
            s++;
            t += dim;
        }
        s = a - dim;
        t = b + 1;
    }     
}

char desc[]="rotate_web";
void rotate_web(int dim, pixel *src, pixel *dst)
{
    int i, j, a, b;
    int sdim = dim - 1;
    for (i = 0; i < dim; i += 8)
    {
        for (j = 0; j < dim; j += 8)
        {
            for (a = i; a < i + 8; a++)
            {
                for (b = j; b < j + 8; b++)
                {
                    dst[RIDX(sdim - b, a, dim)] = src[RIDX(a, b, dim)];
                }
            }
        }
    }
}
char szq_rotate_descr[] = "szq_rotate";
void szq_rotate(int dim, pixel *src, pixel *dst)
{
    int row_size = 32;
    for(int i=0;i < dim;i+=row_size){
        for(int j=0;j<dim;j++){
            for(int k=0;k<row_size;k++){
                dst[RIDX(dim-1-j,i+k,dim)] = src[RIDX(i+k,j,dim)];
            }
        }
        
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
    //add_rotate_function(&rotate, rotate_descr);   
    //add_rotate_function(&rotate_web,desc);
    add_rotate_function(&new_rotate,new_rotate_descr);
    add_rotate_function(&szq_rotate,szq_rotate_descr);
    add_rotate_function(&rotate2,rotate2_descr);
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
    // calculate dst
    // i=0
    smooth_two_rows(dst[RIDX(0,0,dim)],tmp[RIDX(0,0,dim)],tmp[RIDX(1,0,dim)],4);
    for(j=1;j<dim-1;j++){
        smooth_two_rows(dst[RIDX(0,j,dim)],tmp[RIDX(0,j,dim)],tmp[RIDX(1,j,dim)],6);
    }
    smooth_two_rows(dst[RIDX(0,dim-1,dim)],tmp[RIDX(0,dim-1,dim)],tmp[RIDX(1,dim-1,dim)],4);
    // i = dim-1
    smooth_two_rows(dst[RIDX(dim-1,0,dim)],tmp[RIDX(dim-2,0,dim)],tmp[RIDX(dim-1,0,dim)],4);
    for(j=1;j<dim-1;j++){
        smooth_two_rows(dst[RIDX(dim-1,j,dim)],tmp[RIDX(dim-2,j,dim)],tmp[RIDX(dim-1,j,dim)],6);
    }
    smooth_two_rows(dst[RIDX(dim-1,dim-1,dim)],tmp[RIDX(dim-2,dim-1,dim)],tmp[RIDX(dim-1,dim-1,dim)],4);
    // left
    for(i=1;i<dim-1;i++){
        smooth_three_rows(dst[RIDX(i,0,dim)],tmp[RIDX(i-1,0,dim)],tmp[RIDX(i,0,dim)],tmp[RIDX(i+1,0,dim)],6);
        for(j=1;j<dim-1;j++){
            smooth_three_rows(dst[RIDX(i,j,dim)],tmp[RIDX(i-1,j,dim)],tmp[RIDX(i,j,dim)],tmp[RIDX(i+1,j,dim)],9);
        }
        smooth_three_rows(dst[RIDX(i,dim-1,dim)],tmp[RIDX(i-1,dim-1,dim)],tmp[RIDX(i,dim-1,dim)],tmp[RIDX(i+1,dim-1,dim)],6);
    }
}




char szq_smooth_descr[] = "szq_smooth";
void szq_smooth(int dim, pixel *src, pixel *dst){
    pixel_sum temp[512][512];
    for(int i=0;i<dim;i++){
        temp[i][0].red=src[RIDX(i,0,dim)].red+src[RIDX(i,1,dim)].red;
        temp[i][0].green=src[RIDX(i,0,dim)].green+src[RIDX(i,1,dim)].green;
        temp[i][0].blue=src[RIDX(i,0,dim)].blue+src[RIDX(i,1,dim)].blue;
        for(int j=1;j<dim-1;j++){
            temp[i][j].red=src[RIDX(i,j-1,dim)].red+src[RIDX(i,j,dim)].red+src[RIDX(i,j+1,dim)].red;
            temp[i][j].green=src[RIDX(i,j-1,dim)].green+src[RIDX(i,j,dim)].green+src[RIDX(i,j+1,dim)].green;
            temp[i][j].blue=src[RIDX(i,j-1,dim)].blue+src[RIDX(i,j,dim)].blue+src[RIDX(i,j+1,dim)].blue;
        }
        temp[i][dim-1].red=src[RIDX(i,dim-2,dim)].red+src[RIDX(i,dim-1,dim)].red;
        temp[i][dim-1].green=src[RIDX(i,dim-2,dim)].green+src[RIDX(i,dim-1,dim)].green;
        temp[i][dim-1].blue=src[RIDX(i,dim-2,dim)].blue+src[RIDX(i,dim-1,dim)].blue;
    }
    dst[0].red=(temp[0][0].red+temp[1][0].red)/4;
    dst[0].green=(temp[0][0].green+temp[1][0].green)/4;
    dst[0].blue=(temp[0][0].blue+temp[1][0].blue)/4;
    for(int i=1;i<dim-1;i+=2){
        dst[i].red=(temp[0][i].red+temp[1][i].red)/6;
        dst[i].blue=(temp[0][i].blue+temp[1][i].blue)/6;
        dst[i].green=(temp[0][i].green+temp[1][i].green)/6;
        dst[i+1].red=(temp[0][i+1].red+temp[1][i+1].red)/6;
        dst[i+1].blue=(temp[0][i+1].blue+temp[1][i+1].blue)/6;
        dst[i+1].green=(temp[0][i+1].green+temp[1][i+1].green)/6;
    }
    dst[dim-1].red=(temp[0][dim-1].red+temp[1][dim-1].red)/4;
    dst[dim-1].green=(temp[0][dim-1].green+temp[1][dim-1].green)/4;
    dst[dim-1].blue=(temp[0][dim-1].blue+temp[1][dim-1].blue)/4;
    for(int i=1;i<dim-1;i++){
        dst[RIDX(i,0,dim)].red=(temp[i-1][0].red+temp[i][0].red+temp[i+1][0].red)/6;
        dst[RIDX(i,0,dim)].blue=(temp[i-1][0].blue+temp[i][0].blue+temp[i+1][0].blue)/6;
        dst[RIDX(i,0,dim)].green=(temp[i-1][0].green+temp[i][0].green+temp[i+1][0].green)/6;
        for(int j=1;j<dim-1;j+=2){
            dst[RIDX(i,j,dim)].red=(temp[i][j].red+temp[i-1][j].red+temp[i+1][j].red)/9;
            dst[RIDX(i,j,dim)].blue=(temp[i][j].blue+temp[i-1][j].blue+temp[i+1][j].blue)/9;
            dst[RIDX(i,j,dim)].green=(temp[i][j].green+temp[i-1][j].green+temp[i+1][j].green)/9;
            dst[RIDX(i,j+1,dim)].red=(temp[i][j+1].red+temp[i-1][j+1].red+temp[i+1][j+1].red)/9;
            dst[RIDX(i,j+1,dim)].blue=(temp[i][j+1].blue+temp[i-1][j+1].blue+temp[i+1][j+1].blue)/9;
            dst[RIDX(i,j+1,dim)].green=(temp[i][j+1].green+temp[i-1][j+1].green+temp[i+1][j+1].green)/9;
        }
        dst[RIDX(i,dim-1,dim)].red=(temp[i-1][dim-1].red+temp[i][dim-1].red+temp[i+1][dim-1].red)/6;
        dst[RIDX(i,dim-1,dim)].blue=(temp[i-1][dim-1].blue+temp[i][dim-1].blue+temp[i+1][dim-1].blue)/6;
        dst[RIDX(i,dim-1,dim)].green=(temp[i-1][dim-1].green+temp[i][dim-1].green+temp[i+1][dim-1].green)/6;
    }
    dst[RIDX(dim-1,0,dim)].red=(temp[dim-2][0].red+temp[dim-1][0].red)/4;
    dst[RIDX(dim-1,0,dim)].green=(temp[dim-2][0].green+temp[dim-1][0].green)/4;
    dst[RIDX(dim-1,0,dim)].blue=(temp[dim-2][0].blue+temp[dim-1][0].blue)/4;
    for(int i=1;i<dim-1;i+=2){
        dst[RIDX(dim-1,i,dim)].red=(temp[dim-1][i].red+temp[dim-2][i].red)/6;
        dst[RIDX(dim-1,i,dim)].blue=(temp[dim-1][i].blue+temp[dim-2][i].blue)/6;
        dst[RIDX(dim-1,i,dim)].green=(temp[dim-1][i].green+temp[dim-2][i].green)/6;
        dst[RIDX(dim-1,i+1,dim)].red=(temp[dim-1][i+1].red+temp[dim-2][i+1].red)/6;
        dst[RIDX(dim-1,i+1,dim)].blue=(temp[dim-1][i+1].blue+temp[dim-2][i+1].blue)/6;
        dst[RIDX(dim-1,i+1,dim)].green=(temp[dim-1][i+1].green+temp[dim-2][i+1].green)/6;
    }
    dst[RIDX(dim-1,dim-1,dim)].red=(temp[dim-2][dim-1].red+temp[dim-1][dim-1].red)/4;
    dst[RIDX(dim-1,dim-1,dim)].green=(temp[dim-2][dim-1].green+temp[dim-1][dim-1].green)/4;
    dst[RIDX(dim-1,dim-1,dim)].blue=(temp[dim-2][dim-1].blue+temp[dim-1][dim-1].blue)/4;
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
    add_smooth_function(&naive_smooth, naive_smooth_descr);
    add_smooth_function(&szq_smooth,szq_smooth_descr);
    /* ... Register additional test functions here */
}

 