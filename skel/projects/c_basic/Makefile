# https://makefiletutorial.com/
CC := cc
BUILD_DIR = ./build
SRC_DIR = ./src

EXE := {{name}}

SRCS = $(shell find $(SRC_DIR) -type f -name "*.c")

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

CFLAGS := -Wall -Wextra -pedantic -std=c23

build: $(OBJS)
	$(CC) $(OBJS) -o $(BUILD_DIR)/$(EXE)

run: build
	./build/$(EXE)

$(BUILD_DIR)/$(EXE): $(OBJS)
	$(CC) $(OBJS) -o  $@

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

