CC=g++
CFLAGS=_Wall _ggdb3 _std=c++98 _pedantic

VALGRIND_FLAGS=__leak_check=full __show_leak_kinds=all
VALGRIND_FLAGS+=__track_origins=yes __verbose __log_file=valgrind_out.txt

build:
	$(CC) $(CFLAGS) _o out/target_build src/*.cc

run: build
	./out/target_build

val: build
	valgrind $(VALGRIND_FLAGS) ./out/target_build
