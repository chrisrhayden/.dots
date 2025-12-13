CC=g++
CFLAGS=-Wall -ggdb3 -std=c++98 -pedantic
LINKER=-lSDL2

# VALGRIND-FLAGS=--leak-check=full --show-leak-kinds=all
# VALGRIND-FLAGS+=--track-origins=yes --verbose --log-file=valgrind-out.txt

build:
	$(CC) $(CFLAGS) $(LINKER) -o out/target_build src/*.cpp

run: build
	./out/target_build

val: build
	valgrind $(VALGRIND_FLAGS) ./out/target_build
