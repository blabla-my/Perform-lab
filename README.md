# Perform Lab

### rotate

优化思路：

* 将 dst 矩阵划分为若干个 32*32 子矩阵，并且从最左列子矩阵开始，按列完成一个子矩阵中所有元素的赋值。例如下图的128\*128 dst 矩阵，按顺序完成子矩阵1、2、3...16的赋值。

    子矩阵内部的赋值顺序是行优先，即按照从左到右，从上到下的顺序赋值。

    理由：在native_rotate中，dst是列优先，src是行优先。由于dst需要写内存，缓存不命中的开销比读取src时缓存不命中的开销大。当dim较大时，dst矩阵的一行就可能会占据超过一个缓存页面的空间，因此列优先的方式会导致大量的缓存不命中。于是考虑 dst 的行优先，分块成32\*32的子矩阵并且按子矩阵列顺序完成子矩阵是为了兼顾降低src读取数据时的缓存不命中次数（若按照子矩阵行顺序完成子矩阵，和单纯的dst行优先没有区别）。

* 循环展开

    上述的顺序的循环表示如下:

    ```c
    for(j=0;j<dim;j+=32){
        for(i=0;i<dim;i++){
            for(k=0;k<32;k++){
                dst[RIDX(i,j+k,dim)] = src[RIDX(dim-j-k-1,i,dim)];
            }
        }
    }
    ```

    将 k 所在循环完全展开，并且尽可能不使用RIDX进行地址计算，得到最终的优化代码 (见`kernels.c : line 56`)



### smooth

优化思路：

* 算法改进：

    一个九宫格的像素值相加，可以先按行求和，再将三行各自求和的值相加，如下图，假设各行的和是sum1, sum2, sum3，则smooth_value = (sum1+sum2+sum3)/9。这里对于同样包含第1行与第三行的其它九宫格而言，若是能保存并复用sum1和sum3的值，就能减少加法的运算次数，达到优化的效果。

    于是可以先计算一个辅助数组 tmp，tmp[RIDX(i,j,dim)]暂存 src 中(i , j)与其在行方向上相邻的两个元素的值，即形如下图第1行的和sum1。在计算dst[RIDX(i,j,dim)]时，有：

    > dst[RIDX(i,j,dim)] = (tmp[RIDX(i-1,j,dim)] + tmp[RIDX(i,j,dim)] + tmp[RIDX(i+1,j,dim)]) / 9
    >
    > // 此为针对九宫格的情况

* 边界处理

    如下图所示，仅有中央区域的元素在进行smooth时，smooth的范围是以其为中心的3\*3九宫格。其它情况下，四个角为2\*2，边上为2\*3。native_smooth中对边界和中央区域统一处理，这样会调用大量额外的 `min max` 操作，以及需要进行额外的加法运算来确定smooth处理的元素个数。

    改进方法：将边界与中央区域分开处理。特殊处理第 0 行与 dim-1 行；在处理每一行时，特殊处理第 0 列与第 dim-1 列

* 减少过程调用

    native_smooth调用了其它辅助用的函数如 `assign_sum_to_pixel` 等，会带来过程调用导致的开销；并且辅助函数中也没有直接修改对应的元素，而是引入了一些中间变量进行计算，会导致开销增大

    改进方法：不进行过程调用，直接修改相应的元素

* 循环展开：采用2*1循环展开

      

最终版本见 `kernel.c : line 237`，以下是对几个辅助宏定义的说明：

```c
// 将两个像素的各个颜色分量相加，存在dest_sum中
//type(dest_sum)=pixel_sum
add_two_pixel(dest_sum,p1,p2)
    
// 将三个像素的各个颜色分量相加，存在dest_sum中
add_three_pixel(dest_sum,p1,p2,p3)
    
// 对一个包含2行(2*2 or 2*3)的smooth范围进行smooth
// num是smooth范围中像素的数量(4 or 6)
smooth_two_rows(dest,r1,r2,num)
    
// 对一个包含3行(3*2 or 3*3)的smooth范围进行smooth
// num是smooth范围中像素的数量(6 or 9)
smooth_three_rows(dest,r1,r2,r3,num)
```



