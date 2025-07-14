.PHONY: all clean injector cli

all: injector cli

injector:
	$(MAKE) -C injector

cli: injector
	$(MAKE) -C cli

clean:
	$(MAKE) -C injector clean
	$(MAKE) -C cli clean
	rmdir lib bin 2>/dev/null || true