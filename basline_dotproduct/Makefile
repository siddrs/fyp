CC     := riscv64-elf-gcc
DMP    := riscv64-elf-objdump
CFLAGS := -O2 -Wall -Wextra -march=rv64gc -mabi=lp64d
SPIKE  := spike
PK     := $(HOME)/.local/bin/pk

all: build/baseline build/dot.s

build/baseline: dot.c main.c
	@mkdir -p build
	$(CC) $(CFLAGS) $^ -o $@

build/dot.s: dot.c
	@mkdir -p build
	$(CC) $(CFLAGS) -fno-asynchronous-unwind-tables -fno-ident -S $< -o $@

show: all
	@printf "\n== C source ==\n"; cat dot.c
	@printf "\n== generated assembly (-O2) ==\n"; cat build/dot.s
	@printf "\n== run (expect 71) ==\n"; $(SPIKE) $(PK) build/baseline

clean:
	rm -rf build

.PHONY: all show clean