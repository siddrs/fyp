	.file	"dotprod.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C23 (Arch Linux Repositories) version 16.2.0 (riscv64-elf)
#	compiled by GNU C version 16.2.1 20260810, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version isl-0.28-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=lp64d -misa-spec=20191213 -march=rv64imafdc_zicsr_zifencei_zmmul_zaamo_zalrsc_zca_zcd -O2
	.text
	.align	1
	.globl	dot_base
	.type	dot_base, @function
dot_base:
# src/dotprod.c:20:     for (int i = 0; i < n; i++) {
	ble	a2,zero,.L4	#, n,,
	mv	a5,a0	# ivtmp.11, a
	add	a2,a0,a2	# n, _10, ivtmp.11
# src/dotprod.c:18:     int64_t sum = 0;
	li	a0,0		# <retval>,
.L3:
# src/dotprod.c:21:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:21:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:20:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.11, ivtmp.11
	addi	a1,a1,1	#, ivtmp.12, ivtmp.12
# src/dotprod.c:21:         sum += (int64_t)a[i] * b[i];
	mul	a4,a4,a3	# _8, _4, _7
# src/dotprod.c:21:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a4	# _8, <retval>, <retval>
# src/dotprod.c:20:     for (int i = 0; i < n; i++) {
	bne	a2,a5,.L3	#, _10, ivtmp.11,
	ret	
.L4:
# src/dotprod.c:18:     int64_t sum = 0;
	li	a0,0		# <retval>,
# src/dotprod.c:24: }
	ret	
	.size	dot_base, .-dot_base
	.align	1
	.globl	dot_custom
	.type	dot_custom, @function
dot_custom:
# src/dotprod.c:31:     int n_vec = n / 8;
	sraiw	t1,a2,31	#, tmp173, n
	srliw	t1,t1,29	# tmp175, tmp173,
	addw	t1,t1,a2	# n, tmp177, tmp175
# src/dotprod.c:34:     for (int i = 0; i < n_vec; i++) {
	li	a4,7		# tmp180,
# src/dotprod.c:27: int64_t dot_custom(const int8_t *a, const int8_t *b, int n) {
	mv	a5,a0	# a, a
# src/dotprod.c:31:     int n_vec = n / 8;
	sraiw	t1,t1,3	#, tmp179, tmp177
# src/dotprod.c:34:     for (int i = 0; i < n_vec; i++) {
	ble	a2,a4,.L12	#, n, tmp180,
	mv	a7,a0	# ivtmp.30, a
	mv	a6,a1	# ivtmp.31, b
# src/dotprod.c:34:     for (int i = 0; i < n_vec; i++) {
	li	a3,0		# i,
# src/dotprod.c:28:     int64_t sum = 0;
	li	a0,0		# <retval>,
.L9:
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(a7)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	t3,0(a6)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, t3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:34:     for (int i = 0; i < n_vec; i++) {
 #NO_APP
	addiw	a3,a3,1	#, i, i
# src/dotprod.c:35:         sum += dot8(ptr_a[i], ptr_b[i]);
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:34:     for (int i = 0; i < n_vec; i++) {
	addi	a7,a7,8	#, ivtmp.30, ivtmp.30
	addi	a6,a6,8	#, ivtmp.31, ivtmp.31
	bgt	t1,a3,.L9	#, tmp179, i,
.L8:
# src/dotprod.c:39:     for (int i = n_vec * 8; i < n; i++) {
	slliw	a4,t1,3	#, tmp187, tmp179
# src/dotprod.c:39:     for (int i = n_vec * 8; i < n; i++) {
	bge	a4,a2,.L7	#, tmp187, n,
	subw	a3,a2,a4	# tmp192, n, tmp187
	slli	t1,t1,3	#, _49, tmp179
	slli	a3,a3,32	#, _56, tmp192
	srli	a3,a3,32	#, _56, _56
	add	a5,a5,t1	# _49, ivtmp.24, a
	add	a3,a3,a5	# ivtmp.24, _57, _56
	add	a1,a1,t1	# _49, ivtmp.25, b
.L11:
# src/dotprod.c:40:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a5)		# _10, MEM[(const int8_t *)_41]
# src/dotprod.c:40:         sum += (int64_t)a[i] * b[i];
	lb	a2,0(a1)		# _13, MEM[(const int8_t *)_30]
# src/dotprod.c:39:     for (int i = n_vec * 8; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.24, ivtmp.24
	addi	a1,a1,1	#, ivtmp.25, ivtmp.25
# src/dotprod.c:40:         sum += (int64_t)a[i] * b[i];
	mul	a4,a4,a2	# _14, _10, _13
# src/dotprod.c:40:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a4	# _14, <retval>, <retval>
# src/dotprod.c:39:     for (int i = n_vec * 8; i < n; i++) {
	bne	a5,a3,.L11	#, ivtmp.24, _57,
.L7:
# src/dotprod.c:43: }
	ret	
.L12:
# src/dotprod.c:28:     int64_t sum = 0;
	li	a0,0		# <retval>,
	j	.L8		#
	.size	dot_custom, .-dot_custom
	.align	1
	.globl	dot_base_unroll
	.type	dot_base_unroll, @function
dot_base_unroll:
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	ble	a2,zero,.L18	#, n,,
	andi	a4,a2,7	#, tmp157, n
	mv	a5,a0	# ivtmp.41, a
	add	a2,a0,a2	# n, _10, ivtmp.41
# src/dotprod.c:50:     int64_t sum = 0;
	li	a0,0		# <retval>,
	beq	a4,zero,.L17	#, tmp157,,
	li	a3,1		# tmp163,
	beq	a4,a3,.L41	#, tmp157, tmp163,
	li	a3,2		# tmp162,
	beq	a4,a3,.L42	#, tmp157, tmp162,
	li	a3,3		# tmp161,
	beq	a4,a3,.L43	#, tmp157, tmp161,
	li	a3,4		# tmp160,
	beq	a4,a3,.L44	#, tmp157, tmp160,
	li	a3,5		# tmp159,
	beq	a4,a3,.L45	#, tmp157, tmp159,
	li	a3,6		# tmp158,
	bne	a4,a3,.L49	#, tmp157, tmp158,
.L46:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
.L45:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
.L44:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
.L43:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
.L42:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
.L41:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	beq	a2,a5,.L50	#, _10, ivtmp.41,
.L17:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,8	#, ivtmp.41, ivtmp.41
	addi	a1,a1,8	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-7(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-7(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-6(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-6(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-5(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-5(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-4(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-4(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-3(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-3(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-2(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-2(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,-1(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,-1(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a6,a3,a4	# _8, _4, _7
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a6	# _8, <retval>, <retval>
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	bne	a2,a5,.L17	#, _10, ivtmp.41,
	ret	
.L18:
# src/dotprod.c:50:     int64_t sum = 0;
	li	a0,0		# <retval>,
# src/dotprod.c:56: }
	ret	
.L49:
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a3,0(a5)		# _4, MEM[(const int8_t *)_23]
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a1)		# _7, MEM[(const int8_t *)_22]
# src/dotprod.c:52:     for (int i = 0; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.41, ivtmp.41
	addi	a1,a1,1	#, ivtmp.42, ivtmp.42
# src/dotprod.c:53:         sum += (int64_t)a[i] * b[i];
	mul	a0,a3,a4	# <retval>, _4, _7
	j	.L46		#
.L50:
	ret	
	.size	dot_base_unroll, .-dot_base_unroll
	.align	1
	.globl	dot_custom_unroll
	.type	dot_custom_unroll, @function
dot_custom_unroll:
# src/dotprod.c:63:     int n_vec = n / 8;
	sraiw	a6,a2,31	#, tmp173, n
	srliw	a6,a6,29	# tmp175, tmp173,
	addw	a6,a6,a2	# n, tmp177, tmp175
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	li	a4,7		# tmp180,
# src/dotprod.c:59: int64_t dot_custom_unroll(const int8_t *a, const int8_t *b, int n) {
	mv	a5,a0	# a, a
# src/dotprod.c:63:     int n_vec = n / 8;
	sraiw	a6,a6,3	#, tmp179, tmp177
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	ble	a2,a4,.L56	#, n, tmp180,
	addiw	t4,a6,-1	#, tmp198, tmp179
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(a0)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	a3,0(a1)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
	andi	t4,t4,3	#, tmp201, tmp198
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a0, a4, a3	# <retval>, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
 #NO_APP
	li	t3,1		# i,
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addi	t1,a5,8	#, ivtmp.59, a
	addi	a7,a1,8	#, ivtmp.60, b
	ble	a6,t3,.L52	#, tmp179, i,
	sext.w	a4,t4	# tmp206, tmp201
	beq	t4,zero,.L53	#, tmp201,,
	beq	a4,t3,.L70	#, tmp206, i,
	li	t4,2		# tmp203,
	beq	a4,t4,.L71	#, tmp206, tmp203,
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	a3,0(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
 #NO_APP
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	mv	t3,t4	# i, tmp203
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addi	t1,a5,16	#, ivtmp.59, a
	addi	a7,a1,16	#, ivtmp.60, b
.L71:
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	a3,0(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
 #NO_APP
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addiw	t3,t3,1	#, i, i
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addi	t1,t1,8	#, ivtmp.59, ivtmp.59
	addi	a7,a7,8	#, ivtmp.60, ivtmp.60
.L70:
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	a3,0(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
 #NO_APP
	addiw	t3,t3,1	#, i, i
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addi	t1,t1,8	#, ivtmp.59, ivtmp.59
	addi	a7,a7,8	#, ivtmp.60, ivtmp.60
	ble	a6,t3,.L52	#, tmp179, i,
.L53:
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a4,0(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
	ld	a3,0(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
 #NO_APP
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a3,8(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
	ld	a4,8(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
 #NO_APP
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a3,16(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
	ld	a4,16(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
 #NO_APP
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:9:     asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
	ld	a3,24(a7)		# MEM[(const u64a * {ref-all})_65], MEM[(const u64a * {ref-all})_65]
	ld	a4,24(t1)		# MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_64]
 #APP
# 9 "src/dotprod.c" 1
	.insn r 0x0b, 0, 0, a4, a4, a3	# r, MEM[(const u64a * {ref-all})_64], MEM[(const u64a * {ref-all})_65]
# 0 "" 2
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
 #NO_APP
	addiw	t3,t3,4	#, i, i
# src/dotprod.c:67:         sum += dot8(ptr_a[i], ptr_b[i]);
	add	a0,a0,a4	# r, <retval>, <retval>
# src/dotprod.c:66:     for (int i = 0; i < n_vec; i++) {
	addi	t1,t1,32	#, ivtmp.59, ivtmp.59
	addi	a7,a7,32	#, ivtmp.60, ivtmp.60
	bgt	a6,t3,.L53	#, tmp179, i,
.L52:
# src/dotprod.c:71:     for (int i = n_vec * 8; i < n; i++) {
	slliw	a4,a6,3	#, tmp187, tmp179
# src/dotprod.c:71:     for (int i = n_vec * 8; i < n; i++) {
	bge	a4,a2,.L51	#, tmp187, n,
	subw	a3,a2,a4	# tmp192, n, tmp187
	slli	a6,a6,3	#, _49, tmp179
	slli	a3,a3,32	#, _56, tmp192
	srli	a3,a3,32	#, _56, _56
	add	a5,a5,a6	# _49, ivtmp.53, a
	add	a3,a3,a5	# ivtmp.53, _57, _56
	add	a1,a1,a6	# _49, ivtmp.54, b
.L55:
# src/dotprod.c:72:         sum += (int64_t)a[i] * b[i];
	lb	a4,0(a5)		# _10, MEM[(const int8_t *)_41]
# src/dotprod.c:72:         sum += (int64_t)a[i] * b[i];
	lb	a2,0(a1)		# _13, MEM[(const int8_t *)_30]
# src/dotprod.c:71:     for (int i = n_vec * 8; i < n; i++) {
	addi	a5,a5,1	#, ivtmp.53, ivtmp.53
	addi	a1,a1,1	#, ivtmp.54, ivtmp.54
# src/dotprod.c:72:         sum += (int64_t)a[i] * b[i];
	mul	a4,a4,a2	# _14, _10, _13
# src/dotprod.c:72:         sum += (int64_t)a[i] * b[i];
	add	a0,a0,a4	# _14, <retval>, <retval>
# src/dotprod.c:71:     for (int i = n_vec * 8; i < n; i++) {
	bne	a5,a3,.L55	#, ivtmp.53, _57,
.L51:
# src/dotprod.c:75: }
	ret	
.L56:
# src/dotprod.c:60:     int64_t sum = 0;
	li	a0,0		# <retval>,
	j	.L52		#
	.size	dot_custom_unroll, .-dot_custom_unroll
	.ident	"GCC: (Arch Linux Repositories) 16.2.0"
	.section	.note.GNU-stack,"",@progbits
