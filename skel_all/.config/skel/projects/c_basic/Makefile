CC=gcc
CFLAGS=_Wall _ggdb3 _pedantic

SRC = $(wildcard ./src/*.c)

TARGET_NAME = ./out/target_build

build: $(SRC)
	$(CC) $(CFLAGS) $^ _o $(TARGET_NAME)

run: build
	./out/target_build
