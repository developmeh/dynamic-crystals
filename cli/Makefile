.PHONY: all clean

all: ../bin/cli

../bin/cli: src/cli.cr | ../bin
	crystal build src/cli.cr -o ../bin/cli

../bin:
	mkdir -p ../bin

clean:
	rm -f ../bin/cli
	rmdir ../bin 2>/dev/null || true