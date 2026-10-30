# DOT8 Instruction Specification

`DOT8` is a custom RISC-V instruction designed to accelerate
INT8 dot-product operations relevant to transformer workloads

## Instruction

```
dot8 rd, rs1, rs2
```

## Operands
- `rs1`: 64-bit register containing eight signed INT8 values
- `rs2`: 64-bit register containing eight signed INT8 values
- `rd`: destination register containing the 64-bit result

## Operation
Let
```
rs1 = [a7 a6 a5 a4 a3 a2 a1 a0]
rs2 = [b7 b6 b5 b4 b3 b2 b1 b0]
```
where `ai` and `bi` are signed 8-bit ints

The instruction computes:

$$
rd \leftarrow \sum_{0}^{7} a_i \cdot b_i
$$

## Result
The eight products are stored into a signed 64-bit result

## Example
```
A = [2, 1, 4, 5, 6, 2, 8, 4]
B = [1, 3, 3, 2, 4, 2, 1, 2]


DOT8 → 71
```

## TODO
- [ ] Instruction encoding defined
- [ ] Spike decoder implemented
- [ ] Spike execution semantics implemented
- [ ] Assembly test
- [ ] Functional verification
- [ ] Benchmark

___
### Baseline
```
	lb         a4,0(a5)
	lb         a3,0(a1)
	addi       a5,a5,1
	addi       a1,a1,1
	mul        a4,a4,a3
	add        a0,a0,a4
	bne        a2,a5,.L3
	ret
```
- load 1 byte from a
- load 1 byte from b
- multiply them
- add result to sum
- repeat