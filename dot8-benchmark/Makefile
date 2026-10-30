# always use -O2. -O0 will have stack spills, never use that as the baseline
CFLAGS := -O2 -Wall -Wextra
ARCH   := -march=rv64gc -mabi=lp64d

SRC  := src/dotprod.c
MAIN := src/main.c
HDR  := src/dotprod.h

LINUX_CC := riscv64-linux-gnu-gcc
ELF_CC   := riscv64-elf-gcc
ELF_DMP  := riscv64-elf-objdump

# sspike / pk
SPIKE_STOCK := spike
SPIKE_DOT8  := $(HOME)/fyp/spike-dot8/install/bin/spike
PK          := $(HOME)/.local/bin/pk

LINUX_ASM := asm/linux/dotprod.s
ELF_ASM   := asm/elf/dotprod.s

LINUX_BIN := bin/linux/dotprod

# ELF binaries: bench = baseline + dot8, bench_base = baseline only
BENCH      := bin/elf/bench
BENCH_BASE := bin/elf/bench_base


# `all` builds only the ELF flow. Linux is separate so a missing
# linux toolchain can never break the demo build.
all: elf


###################
## ELF Toolchain ##
###################

elf: $(BENCH) $(BENCH_BASE) $(ELF_ASM)

# baseline + dot8 kernel: needs the patched spike
$(BENCH): $(SRC) $(MAIN) $(HDR)
	@mkdir -p $(@D)
	$(ELF_CC) $(CFLAGS) $(ARCH) $(SRC) $(MAIN) -o $@

# baseline only: dot8 is never executed, so this runs on stock spike
$(BENCH_BASE): $(SRC) $(MAIN) $(HDR)
	@mkdir -p $(@D)
	$(ELF_CC) $(CFLAGS) $(ARCH) -DBASE_ONLY $(SRC) $(MAIN) -o $@

## Generate assembly for dotprod.c (both kernels)
$(ELF_ASM): $(SRC)
	@mkdir -p $(@D)
	$(ELF_CC) $(CFLAGS) $(ARCH) -fverbose-asm -S $< -o $@
	$(ELF_CC) $(CFLAGS) $(ARCH) -fno-asynchronous-unwind-tables -fno-ident -S $< -o asm/elf/dotprod_nocomm.s	# no comments, clean for slides



#####################
## Linux Toolchain ##
#####################
# Optional and NOT part of 'all'. Built baseline-only: a linux binary
# containing dot8 would trap on stock spike.

linux: $(LINUX_ASM) $(LINUX_BIN)

$(LINUX_BIN): $(SRC) $(MAIN) $(HDR)
	@mkdir -p $(@D)
	$(LINUX_CC) $(CFLAGS) $(ARCH) -DBASE_ONLY -static $(SRC) $(MAIN) -o $@

$(LINUX_ASM): $(SRC)
	@mkdir -p $(@D)
	$(LINUX_CC) $(CFLAGS) $(ARCH) -fverbose-asm -S $< -o $@


#################
## CHECK / DEMO ##
#################

# confirm packing: dot_custom's loop must show ld, ld, the dot8 word, no lb
check-loop: $(BENCH)
	@$(ELF_DMP) -d $(BENCH) | awk '/<dot_custom>:/{p=1} p{print} /bne/&&p{exit}'

# the three-run demo
demo: $(BENCH) $(BENCH_BASE)
	@printf "\n== 1. baseline, stock Spike ==\n"
	@$(SPIKE_STOCK) $(PK) $(BENCH_BASE)
	@printf "\n== 2. dot8 binary, stock Spike ==\n"
	@$(SPIKE_STOCK) $(PK) $(BENCH) 2>&1 | grep -i "illegal" || true
	@printf "(expected: stock Spike does not know dot8)\n"
	@printf "\n== 3. dot8 binary, patched Spike ==\n"
	@$(SPIKE_DOT8) $(PK) $(BENCH)


################
### RUN FILES ##
################

run_base: $(BENCH_BASE)
	@printf "» Baseline only, stock spike\n-------------------------\n\n"
	@$(SPIKE_STOCK) $(PK) $(BENCH_BASE)
	@printf "\n-------------------------\n"

run_dot8: $(BENCH)
	@printf "» Baseline vs dot8, patched spike\n-------------------------\n\n"
	@$(SPIKE_DOT8) $(PK) $(BENCH)
	@printf "\n-------------------------\n"

run_linux: $(LINUX_BIN)
	@printf "» Running Linux Binary (baseline only)\n-------------------------\n\n"
	@$(SPIKE_STOCK) pk $(LINUX_BIN)
	@printf "\n-------------------------\n"


###########
## CLEAN ##
###########

clean:
	rm -rf bin obj asm


.PHONY: all elf linux check-loop demo run_base run_dot8 run_linux clean