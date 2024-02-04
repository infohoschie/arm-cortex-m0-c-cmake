format:
	find . -name '*.[ch]' -exec clang-format --style=LLVM -i {} +

init_submodule:
	git submodule update --init --recursive