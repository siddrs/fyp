	.file	"dot.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	dot_product
	.type	dot_product, @function
dot_product:
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
	.size	dot_product, .-dot_product
	.section	.note.GNU-stack,"",@progbits
