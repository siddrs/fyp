	.file	"dotprod.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	dot_base
	.type	dot_base, @function
dot_base:
	ble	a2,zero,.L4
	mv	a5,a0
	add	a2,a0,a2
	li	a0,0
.L3:
	lb	a4,0(a5)
	lb	a3,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a4,a4,a3
	add	a0,a0,a4
	bne	a2,a5,.L3
	ret
.L4:
	li	a0,0
	ret
	.size	dot_base, .-dot_base
	.align	1
	.globl	dot_custom
	.type	dot_custom, @function
dot_custom:
	sraiw	t1,a2,31
	srliw	t1,t1,29
	addw	t1,t1,a2
	li	a4,7
	mv	a5,a0
	sraiw	t1,t1,3
	ble	a2,a4,.L12
	mv	a7,a0
	mv	a6,a1
	li	a3,0
	li	a0,0
.L9:
	ld	a4,0(a7)
	ld	t3,0(a6)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, t3
# 0 "" 2
 #NO_APP
	addiw	a3,a3,1
	add	a0,a0,a4
	addi	a7,a7,8
	addi	a6,a6,8
	bgt	t1,a3,.L9
.L8:
	slliw	a4,t1,3
	bge	a4,a2,.L7
	subw	a3,a2,a4
	slli	t1,t1,3
	slli	a3,a3,32
	srli	a3,a3,32
	add	a5,a5,t1
	add	a3,a3,a5
	add	a1,a1,t1
.L11:
	lb	a4,0(a5)
	lb	a2,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a4,a4,a2
	add	a0,a0,a4
	bne	a5,a3,.L11
.L7:
	ret
.L12:
	li	a0,0
	j	.L8
	.size	dot_custom, .-dot_custom
	.align	1
	.globl	dot_base_unroll
	.type	dot_base_unroll, @function
dot_base_unroll:
	ble	a2,zero,.L18
	andi	a4,a2,7
	mv	a5,a0
	add	a2,a0,a2
	li	a0,0
	beq	a4,zero,.L17
	li	a3,1
	beq	a4,a3,.L41
	li	a3,2
	beq	a4,a3,.L42
	li	a3,3
	beq	a4,a3,.L43
	li	a3,4
	beq	a4,a3,.L44
	li	a3,5
	beq	a4,a3,.L45
	li	a3,6
	bne	a4,a3,.L49
.L46:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
.L45:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
.L44:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
.L43:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
.L42:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
.L41:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a6,a3,a4
	add	a0,a0,a6
	beq	a2,a5,.L50
.L17:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,8
	addi	a1,a1,8
	mul	a6,a3,a4
	lb	a3,-7(a5)
	lb	a4,-7(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-6(a5)
	lb	a4,-6(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-5(a5)
	lb	a4,-5(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-4(a5)
	lb	a4,-4(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-3(a5)
	lb	a4,-3(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-2(a5)
	lb	a4,-2(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	lb	a3,-1(a5)
	lb	a4,-1(a1)
	add	a0,a0,a6
	mul	a6,a3,a4
	add	a0,a0,a6
	bne	a2,a5,.L17
	ret
.L18:
	li	a0,0
	ret
.L49:
	lb	a3,0(a5)
	lb	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a0,a3,a4
	j	.L46
.L50:
	ret
	.size	dot_base_unroll, .-dot_base_unroll
	.align	1
	.globl	dot_custom_unroll
	.type	dot_custom_unroll, @function
dot_custom_unroll:
	sraiw	a6,a2,31
	srliw	a6,a6,29
	addw	a6,a6,a2
	li	a4,7
	mv	a5,a0
	sraiw	a6,a6,3
	ble	a2,a4,.L56
	addiw	t4,a6,-1
	ld	a4,0(a0)
	ld	a3,0(a1)
	andi	t4,t4,3
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a0, a4, a3
# 0 "" 2
 #NO_APP
	li	t3,1
	addi	t1,a5,8
	addi	a7,a1,8
	ble	a6,t3,.L52
	sext.w	a4,t4
	beq	t4,zero,.L53
	beq	a4,t3,.L70
	li	t4,2
	beq	a4,t4,.L71
	ld	a4,0(t1)
	ld	a3,0(a7)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	add	a0,a0,a4
	mv	t3,t4
	addi	t1,a5,16
	addi	a7,a1,16
.L71:
	ld	a4,0(t1)
	ld	a3,0(a7)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	add	a0,a0,a4
	addiw	t3,t3,1
	addi	t1,t1,8
	addi	a7,a7,8
.L70:
	ld	a4,0(t1)
	ld	a3,0(a7)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	addiw	t3,t3,1
	add	a0,a0,a4
	addi	t1,t1,8
	addi	a7,a7,8
	ble	a6,t3,.L52
.L53:
	ld	a4,0(t1)
	ld	a3,0(a7)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	add	a0,a0,a4
	ld	a3,8(a7)
	ld	a4,8(t1)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	add	a0,a0,a4
	ld	a3,16(a7)
	ld	a4,16(t1)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	add	a0,a0,a4
	ld	a3,24(a7)
	ld	a4,24(t1)
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	addiw	t3,t3,4
	add	a0,a0,a4
	addi	t1,t1,32
	addi	a7,a7,32
	bgt	a6,t3,.L53
.L52:
	slliw	a4,a6,3
	bge	a4,a2,.L51
	subw	a3,a2,a4
	slli	a6,a6,3
	slli	a3,a3,32
	srli	a3,a3,32
	add	a5,a5,a6
	add	a3,a3,a5
	add	a1,a1,a6
.L55:
	lb	a4,0(a5)
	lb	a2,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	mul	a4,a4,a2
	add	a0,a0,a4
	bne	a5,a3,.L55
.L51:
	ret
.L56:
	li	a0,0
	j	.L52
	.size	dot_custom_unroll, .-dot_custom_unroll
	.section	.note.GNU-stack,"",@progbits
