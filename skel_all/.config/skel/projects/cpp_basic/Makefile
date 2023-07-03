CC=g++
CFLAGS=-Wall -ggdb3 -std=c++98 -pedantic

VALGRIND-FLAGS=--leak-check=full --show-leak-kinds=all
VALGRIND-FLAGS+=--track-origins=yes --verbose --log-file=valgrind-out.txt

build:
	$(CC) $(CFLAGS) -o out/target_build src/*.cc

run: build
	./out/target_build

val: build
	valgrind $(VALGRIND_FLAGS) ./out/target_build
