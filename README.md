# Crystal Dynamic C Bindings Demo

This project demonstrates how to use dynamic C bindings in Crystal by loading and calling functions from shared libraries at runtime using `dlopen` and `dlsym`.

## What This Demo Shows

### inspired by
https://github.com/fabianloewe/dynamic-library

The project consists of two components:

1. **Injector** (`injector/`): A Crystal module that defines a C function called `register` which simply prints "registered". This gets compiled into a shared library (`libinjector.so`).

2. **CLI** (`cli/`): A Crystal program that dynamically loads the injector shared library at runtime, finds the `register` function using `dlsym`, and calls it as a `Proc`.

This demonstrates the power of Crystal's C bindings system - instead of linking libraries at compile time, you can load and call C functions dynamically at runtime.

## Building and Running

### Prerequisites

- Crystal compiler
- Make
- GCC (for linking the shared library)

### Build

```bash
# Build everything (injector library + CLI executable)
make

# Or build components individually:
make injector  # Builds lib/libinjector.so
make cli       # Builds bin/cli
```

### Run

```bash
./bin/cli
```

Expected output:
```
Pointer(Void)@0x7f...  # Address of loaded library
Pointer(Void)@0x7f...  # Address of register function
registered             # Output from calling the function
```

### Clean

```bash
make clean
```

## How It Works

### The Injector Library

The injector (`injector/src/injector.cr`) defines a simple C function:

```
fun register : Void
  puts "registered"
end
```

This gets cross-compiled to an object file and linked into a shared library using Crystal's `--cross-compile` flag.

### The CLI Application

The CLI (`cli/src/cli.cr`) demonstrates dynamic loading:

1. **Load Library**: Uses `dlopen()` to load `libinjector.so` at runtime
2. **Find Symbol**: Uses `dlsym()` to find the `register` function
3. **Call Function**: Converts the function pointer to a Crystal `Proc` and calls it

### LibC Bindings

The project includes custom LibC bindings (`cli/src/libC/lib_c.cr`) for dynamic loading functions:

- `dlopen` - Load a shared library
- `dlsym` - Find a symbol in a loaded library  
- `dlclose` - Close a loaded library
- `dlerror` - Get error information

## Use Cases

Dynamic C bindings are useful for:

- Plugin systems
- Optional dependencies
- Runtime library selection
- Interfacing with system libraries
- Hot-swapping code modules

## Project Structure

```
├── Makefile              # Main build file
├── bin/                  # Built CLI executable
├── lib/                  # Built shared library
├── cli/                  # CLI application source
│   ├── src/cli.cr       # Main CLI code
│   └── src/libC/lib_c.cr # LibC bindings
└── injector/            # Injector library source
    └── src/injector.cr  # C function definition
```

This is a minimal but complete example of Crystal's dynamic C binding capabilities.
