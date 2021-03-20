	.file	"kernels.c"
	.text
	.type	min, @function
min:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	%eax, -8(%rbp)
	cmovle	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	min, .-min
	.type	max, @function
max:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	%eax, -8(%rbp)
	cmovge	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	max, .-max
	.globl	team
	.section	.rodata
.LC0:
	.string	"lmy"
.LC1:
	.string	"Harry Q. Bovik"
.LC2:
	.string	"bovik@nowhere.edu"
.LC3:
	.string	"18300240005@fudan.edu.cn"
	.data
	.align 32
	.type	team, @object
	.size	team, 40
team:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC0
	.quad	.LC3
	.globl	naive_rotate_descr
	.align 32
	.type	naive_rotate_descr, @object
	.size	naive_rotate_descr, 44
naive_rotate_descr:
	.string	"naive_rotate: Naive baseline implementation"
	.text
	.globl	naive_rotate
	.type	naive_rotate, @function
naive_rotate:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L6
.L9:
	movl	$0, -4(%rbp)
	jmp	.L7
.L8:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	subl	-4(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-8(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -4(%rbp)
.L7:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L8
	addl	$1, -8(%rbp)
.L6:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L9
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	naive_rotate, .-naive_rotate
	.globl	rotate_descr
	.data
	.align 32
	.type	rotate_descr, @object
	.size	rotate_descr, 32
rotate_descr:
	.string	"rotate: Current working version"
	.text
	.globl	rotate
	.type	rotate, @function
rotate:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	-20(%rbp), %eax
	subl	$1, %eax
	imull	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -40(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L11
.L16:
	movl	$0, -12(%rbp)
	jmp	.L12
.L15:
	movl	$0, -8(%rbp)
	jmp	.L13
.L14:
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	addl	$1, -8(%rbp)
.L13:
	cmpl	$30, -8(%rbp)
	jle	.L14
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	addq	$6, -32(%rbp)
	movl	-20(%rbp), %eax
	sall	$5, %eax
	subl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	negq	%rax
	addq	%rax, -32(%rbp)
	movl	-20(%rbp), %eax
	addl	$31, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	negq	%rax
	addq	%rax, -40(%rbp)
	addl	$1, -12(%rbp)
.L12:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L15
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -40(%rbp)
	addq	$192, -40(%rbp)
	movl	-20(%rbp), %eax
	cltq
	imulq	$186, %rax, %rax
	addq	%rax, -32(%rbp)
	addl	$32, -16(%rbp)
.L11:
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L16
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	rotate, .-rotate
	.globl	rotate2_descr
	.data
	.align 16
	.type	rotate2_descr, @object
	.size	rotate2_descr, 25
rotate2_descr:
	.string	"rotate2: Using 2 pointer"
	.text
	.globl	rotate2
	.type	rotate2, @function
rotate2:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	-20(%rbp), %eax
	subl	$1, %eax
	imull	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -40(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L18
.L21:
	movl	$0, -8(%rbp)
	jmp	.L19
.L20:
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %ecx
	movl	%ecx, (%rax)
	movzwl	4(%rdx), %edx
	movw	%dx, 4(%rax)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -32(%rbp)
	addq	$6, -40(%rbp)
	addq	$6, -32(%rbp)
	movl	-20(%rbp), %eax
	sall	$5, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	negq	%rax
	addq	%rax, -32(%rbp)
	movl	-20(%rbp), %eax
	addl	$32, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	negq	%rax
	addq	%rax, -40(%rbp)
	addl	$1, -8(%rbp)
.L19:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L20
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, -40(%rbp)
	addq	$192, -40(%rbp)
	movl	-20(%rbp), %eax
	cltq
	imulq	$186, %rax, %rax
	addq	%rax, -32(%rbp)
	addl	$32, -12(%rbp)
.L18:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L21
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	rotate2, .-rotate2
	.globl	new_rotate_descr
	.data
	.align 8
	.type	new_rotate_descr, @object
	.size	new_rotate_descr, 11
new_rotate_descr:
	.string	"new_rotate"
	.text
	.globl	new_rotate
	.type	new_rotate, @function
new_rotate:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L23
.L28:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.L24
.L27:
	movl	$0, -4(%rbp)
	jmp	.L25
.L26:
	movl	-12(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %edx
	addl	%ecx, %edx
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	addl	%ecx, %eax
	imull	-20(%rbp), %eax
	movl	%eax, %ecx
	movl	-20(%rbp), %eax
	subl	$1, %eax
	subl	-12(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -4(%rbp)
.L25:
	cmpl	$31, -4(%rbp)
	jle	.L26
	subl	$1, -12(%rbp)
.L24:
	cmpl	$0, -12(%rbp)
	jns	.L27
	addl	$32, -8(%rbp)
.L23:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L28
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	new_rotate, .-new_rotate
	.globl	rotate1_descr
	.data
	.align 8
	.type	rotate1_descr, @object
	.size	rotate1_descr, 8
rotate1_descr:
	.string	"rotate1"
	.text
	.globl	rotate1
	.type	rotate1, @function
rotate1:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$32, -4(%rbp)
	cmpl	$1024, -20(%rbp)
	jne	.L30
	movl	$88, -4(%rbp)
.L30:
	cmpl	$64, -20(%rbp)
	jne	.L31
	movl	$32, -4(%rbp)
.L31:
	movl	$0, -12(%rbp)
	jmp	.L32
.L37:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.L33
.L36:
	movl	$0, -8(%rbp)
	jmp	.L34
.L35:
	movl	-16(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %edx
	addl	%ecx, %edx
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	addl	%ecx, %eax
	imull	-20(%rbp), %eax
	movl	%eax, %ecx
	movl	-20(%rbp), %eax
	subl	$1, %eax
	subl	-16(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -8(%rbp)
.L34:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L35
	subl	$1, -16(%rbp)
.L33:
	cmpl	$0, -16(%rbp)
	jns	.L36
	movl	-4(%rbp), %eax
	addl	%eax, -12(%rbp)
.L32:
	movl	-20(%rbp), %eax
	cltd
	idivl	-4(%rbp)
	movl	-20(%rbp), %eax
	subl	%edx, %eax
	cmpl	-12(%rbp), %eax
	jg	.L37
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.L38
.L40:
	movl	-16(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, %ecx
	movl	-20(%rbp), %eax
	subl	$1, %eax
	subl	-16(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -12(%rbp)
.L39:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L40
	subl	$1, -16(%rbp)
.L38:
	cmpl	$0, -16(%rbp)
	jns	.L39
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	rotate1, .-rotate1
	.globl	rotate_v7_descr
	.data
	.align 8
	.type	rotate_v7_descr, @object
	.size	rotate_v7_descr, 10
rotate_v7_descr:
	.string	"rotate_v7"
	.text
	.globl	rotate_v7
	.type	rotate_v7, @function
rotate_v7:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	-36(%rbp), %eax
	subl	$1, %eax
	imull	-36(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L43
.L46:
	movl	-16(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	$0, -24(%rbp)
	jmp	.L44
.L45:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -16(%rbp)
	movl	-36(%rbp), %eax
	addl	%eax, -12(%rbp)
	addl	$1, -24(%rbp)
.L44:
	movl	-24(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L45
	movl	-8(%rbp), %eax
	subl	-36(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	addl	$1, -20(%rbp)
.L43:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L46
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	rotate_v7, .-rotate_v7
	.globl	desc
	.data
	.align 8
	.type	desc, @object
	.size	desc, 11
desc:
	.string	"rotate_web"
	.text
	.globl	rotate_web
	.type	rotate_web, @function
rotate_web:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	-36(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L48
.L55:
	movl	$0, -16(%rbp)
	jmp	.L49
.L54:
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.L50
.L53:
	movl	-16(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L51
.L52:
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %ecx
	movl	-8(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -8(%rbp)
.L51:
	movl	-16(%rbp), %eax
	addl	$8, %eax
	cmpl	-8(%rbp), %eax
	jg	.L52
	addl	$1, -12(%rbp)
.L50:
	movl	-20(%rbp), %eax
	addl	$8, %eax
	cmpl	-12(%rbp), %eax
	jg	.L53
	addl	$8, -16(%rbp)
.L49:
	movl	-16(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L54
	addl	$8, -20(%rbp)
.L48:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L55
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	rotate_web, .-rotate_web
	.globl	szq_rotate_descr
	.data
	.align 8
	.type	szq_rotate_descr, @object
	.size	szq_rotate_descr, 11
szq_rotate_descr:
	.string	"szq_rotate"
	.text
	.globl	szq_rotate
	.type	szq_rotate, @function
szq_rotate:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$32, -4(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L57
.L62:
	movl	$0, -12(%rbp)
	jmp	.L58
.L61:
	movl	$0, -8(%rbp)
	jmp	.L59
.L60:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	subl	-12(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	-16(%rbp), %ecx
	movl	-8(%rbp), %edx
	addl	%ecx, %edx
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-16(%rbp), %ecx
	movl	-8(%rbp), %eax
	addl	%ecx, %eax
	imull	-20(%rbp), %eax
	movl	%eax, %ecx
	movl	-12(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	%ecx, (%rdx)
	movzwl	4(%rax), %eax
	movw	%ax, 4(%rdx)
	addl	$1, -8(%rbp)
.L59:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L60
	addl	$1, -12(%rbp)
.L58:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L61
	movl	-4(%rbp), %eax
	addl	%eax, -16(%rbp)
.L57:
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L62
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	szq_rotate, .-szq_rotate
	.globl	register_rotate_functions
	.type	register_rotate_functions, @function
register_rotate_functions:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$naive_rotate_descr, %esi
	movl	$naive_rotate, %edi
	call	add_rotate_function
	movl	$new_rotate_descr, %esi
	movl	$new_rotate, %edi
	call	add_rotate_function
	movl	$szq_rotate_descr, %esi
	movl	$szq_rotate, %edi
	call	add_rotate_function
	movl	$rotate2_descr, %esi
	movl	$rotate2, %edi
	call	add_rotate_function
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	register_rotate_functions, .-register_rotate_functions
	.type	initialize_pixel_sum, @function
initialize_pixel_sum:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movl	8(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 4(%rax)
	movq	-8(%rbp), %rax
	movl	4(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	movq	-8(%rbp), %rax
	movl	$0, 12(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	initialize_pixel_sum, .-initialize_pixel_sum
	.type	accumulate_sum, @function
accumulate_sum:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %edx
	movzwl	-16(%rbp), %eax
	movzwl	%ax, %eax
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	movq	-8(%rbp), %rax
	movl	4(%rax), %edx
	movzwl	-14(%rbp), %eax
	movzwl	%ax, %eax
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 4(%rax)
	movq	-8(%rbp), %rax
	movl	8(%rax), %edx
	movzwl	-12(%rbp), %eax
	movzwl	%ax, %eax
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 8(%rax)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 12(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	accumulate_sum, .-accumulate_sum
	.type	assign_sum_to_pixel, @function
assign_sum_to_pixel:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, %rax
	movq	%rdx, %rcx
	movq	%rcx, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movl	-32(%rbp), %eax
	movl	-20(%rbp), %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movw	%dx, (%rax)
	movl	-28(%rbp), %eax
	movl	-20(%rbp), %edi
	cltd
	idivl	%edi
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movw	%dx, 2(%rax)
	movl	-24(%rbp), %eax
	movl	-20(%rbp), %ecx
	cltd
	idivl	%ecx
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movw	%dx, 4(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	assign_sum_to_pixel, .-assign_sum_to_pixel
	.type	avg, @function
avg:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -84(%rbp)
	movl	%esi, -88(%rbp)
	movl	%edx, -92(%rbp)
	movq	%rcx, -104(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	initialize_pixel_sum
	movl	-88(%rbp), %eax
	subl	$1, %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	max
	movl	%eax, -72(%rbp)
	jmp	.L71
.L74:
	movl	-92(%rbp), %eax
	subl	$1, %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	max
	movl	%eax, -68(%rbp)
	jmp	.L72
.L73:
	movl	-72(%rbp), %eax
	imull	-84(%rbp), %eax
	movl	%eax, %edx
	movl	-68(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-104(%rbp), %rax
	addq	%rdx, %rax
	leaq	-32(%rbp), %rdx
	movzwl	(%rax), %ecx
	movzwl	2(%rax), %esi
	salq	$16, %rsi
	orq	%rsi, %rcx
	movzwl	4(%rax), %eax
	salq	$32, %rax
	orq	%rcx, %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	accumulate_sum
	addl	$1, -68(%rbp)
.L72:
	movl	-84(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	min
	cmpl	-68(%rbp), %eax
	jge	.L73
	addl	$1, -72(%rbp)
.L71:
	movl	-84(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-88(%rbp), %eax
	addl	$1, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	min
	cmpl	-72(%rbp), %eax
	jge	.L74
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	assign_sum_to_pixel
	movl	-64(%rbp), %eax
	movl	%eax, -48(%rbp)
	movzwl	-60(%rbp), %eax
	movw	%ax, -44(%rbp)
	movl	$0, %eax
	movzwl	-48(%rbp), %edx
	movzwl	%dx, %edx
	movw	$0, %ax
	orq	%rdx, %rax
	movzwl	-46(%rbp), %edx
	movzwl	%dx, %edx
	movq	%rdx, %rcx
	salq	$16, %rcx
	movabsq	$-4294901761, %rdx
	andq	%rdx, %rax
	orq	%rcx, %rax
	movzwl	-44(%rbp), %edx
	movzwl	%dx, %edx
	movq	%rdx, %rcx
	salq	$32, %rcx
	movabsq	$-281470681743361, %rdx
	andq	%rdx, %rax
	orq	%rcx, %rax
	movq	-8(%rbp), %rdi
	xorq	%fs:40, %rdi
	je	.L76
	call	__stack_chk_fail
.L76:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	avg, .-avg
	.globl	naive_smooth_descr
	.data
	.align 32
	.type	naive_smooth_descr, @object
	.size	naive_smooth_descr, 44
naive_smooth_descr:
	.string	"naive_smooth: Naive baseline implementation"
	.text
	.globl	naive_smooth
	.type	naive_smooth, @function
naive_smooth:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	$0, -24(%rbp)
	jmp	.L78
.L81:
	movl	$0, -20(%rbp)
	jmp	.L79
.L80:
	movl	-24(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movq	-48(%rbp), %rcx
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %esi
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	avg
	movw	%ax, (%rbx)
	movq	%rax, %rdx
	shrq	$16, %rdx
	andb	$255, %dh
	movw	%dx, 2(%rbx)
	shrq	$32, %rax
	andb	$255, %ah
	movw	%ax, 4(%rbx)
	addl	$1, -20(%rbp)
.L79:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L80
	addl	$1, -24(%rbp)
.L78:
	movl	-24(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L81
	nop
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	naive_smooth, .-naive_smooth
	.globl	optavg
	.type	optavg, @function
optavg:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movl	%edi, -100(%rbp)
	movl	%esi, -104(%rbp)
	movl	%edx, -108(%rbp)
	movq	%rcx, -120(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-108(%rbp), %eax
	subl	$1, %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	max
	movl	%eax, -80(%rbp)
	movl	-100(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-108(%rbp), %eax
	addl	$1, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	min
	movl	%eax, -76(%rbp)
	movl	-104(%rbp), %eax
	subl	$1, %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	max
	movl	%eax, -72(%rbp)
	movl	-100(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-104(%rbp), %eax
	addl	$1, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	min
	movl	%eax, -68(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	initialize_pixel_sum
	movl	-72(%rbp), %eax
	movl	%eax, -88(%rbp)
	jmp	.L83
.L86:
	movl	-80(%rbp), %eax
	movl	%eax, -84(%rbp)
	jmp	.L84
.L85:
	movl	-88(%rbp), %eax
	imull	-100(%rbp), %eax
	movl	%eax, %edx
	movl	-84(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	addq	%rdx, %rax
	leaq	-32(%rbp), %rdx
	movzwl	(%rax), %ecx
	movzwl	2(%rax), %esi
	salq	$16, %rsi
	orq	%rsi, %rcx
	movzwl	4(%rax), %eax
	salq	$32, %rax
	orq	%rcx, %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	accumulate_sum
	addl	$1, -84(%rbp)
.L84:
	movl	-84(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jle	.L85
	addl	$1, -88(%rbp)
.L83:
	movl	-88(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jle	.L86
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	assign_sum_to_pixel
	movl	-64(%rbp), %eax
	movl	%eax, -48(%rbp)
	movzwl	-60(%rbp), %eax
	movw	%ax, -44(%rbp)
	movl	$0, %eax
	movzwl	-48(%rbp), %edx
	movzwl	%dx, %edx
	movw	$0, %ax
	orq	%rdx, %rax
	movzwl	-46(%rbp), %edx
	movzwl	%dx, %edx
	movq	%rdx, %rcx
	salq	$16, %rcx
	movabsq	$-4294901761, %rdx
	andq	%rdx, %rax
	orq	%rcx, %rax
	movzwl	-44(%rbp), %edx
	movzwl	%dx, %edx
	movq	%rdx, %rcx
	salq	$32, %rcx
	movabsq	$-281470681743361, %rdx
	andq	%rdx, %rax
	orq	%rcx, %rax
	movq	-8(%rbp), %rdi
	xorq	%fs:40, %rdi
	je	.L88
	call	__stack_chk_fail
.L88:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	optavg, .-optavg
	.globl	smooth_descr
	.data
	.align 32
	.type	smooth_descr, @object
	.size	smooth_descr, 32
smooth_descr:
	.string	"smooth: Current working version"
	.text
	.globl	smooth
	.type	smooth, @function
smooth:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	$0, -24(%rbp)
	jmp	.L90
.L93:
	movl	$0, -20(%rbp)
	jmp	.L91
.L92:
	movl	-24(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movq	-48(%rbp), %rcx
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %esi
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	optavg
	movw	%ax, (%rbx)
	movq	%rax, %rdx
	shrq	$16, %rdx
	andb	$255, %dh
	movw	%dx, 2(%rbx)
	shrq	$32, %rax
	andb	$255, %ah
	movw	%ax, 4(%rbx)
	addl	$1, -20(%rbp)
.L91:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L92
	addl	$1, -24(%rbp)
.L90:
	movl	-24(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L93
	nop
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	smooth, .-smooth
	.globl	register_smooth_functions
	.type	register_smooth_functions, @function
register_smooth_functions:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$smooth_descr, %esi
	movl	$smooth, %edi
	call	add_smooth_function
	movl	$naive_smooth_descr, %esi
	movl	$naive_smooth, %edi
	call	add_smooth_function
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	register_smooth_functions, .-register_smooth_functions
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
