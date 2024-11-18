# Define variables
SRC := src/ex00.c src/ex02.c src/ex03.c src/ex04.c
MAIN := src/ex00_main.c
OUT_DIR := answers
EXECUTABLES := $(OUT_DIR)/ex00 $(OUT_DIR)/ex02 $(OUT_DIR)/ex03 $(OUT_DIR)/ex04

# Default target
all: prepare $(EXECUTABLES)

# Create the answers directory if it doesn't exist
prepare:
	@mkdir -p $(OUT_DIR)

# Rule to compile ex00 with additional main file
$(OUT_DIR)/ex00: src/ex00.c $(MAIN) | prepare
	gcc -Wall -Wextra -Werror $^ -o $@

# Generic rule for the other executables
$(OUT_DIR)/ex%: src/ex%.c | prepare
	gcc -Wall -Wextra -Werror $< -o $@

# Clean rule to remove executables and the answers directory
clean:
	rm -rf $(OUT_DIR)

# Phony targets
.PHONY: all clean prepare
