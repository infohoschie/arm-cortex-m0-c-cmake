CFILES=*.c

format:
	clang-format --style=LLVM -i $(CFILES)