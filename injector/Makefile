.PHONY: all clean

CRYSTAL_LIB_PATH := $(shell crystal env CRYSTAL_LIBRARY_PATH 2>/dev/null || echo "/usr/lib/crystal")

all: ../lib/libinjector.so

../lib/libinjector.so: injector.o | ../lib
	cc injector.o -o ../lib/libinjector.so -shared -rdynamic -L$(CRYSTAL_LIB_PATH) -lgc -lpthread -ldl

injector.o: src/injector.cr
	crystal build --cross-compile -d src/injector.cr

../lib:
	mkdir -p ../lib

clean:
	rm -f injector.o ../lib/libinjector.so
	rmdir ../lib 2>/dev/null || true