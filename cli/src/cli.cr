require "./libC/lib_c.cr"

def load_injector_library
  # Get the absolute path to the executable
  exe_path = Process.executable_path
  if exe_path.nil?
    STDERR.puts "Error: Could not determine executable path"
    exit 1
  end

  # Get the directory containing the executable (bin/)
  exe_dir = File.dirname(exe_path)

  # Get the parent directory (project root)
  project_root = File.dirname(exe_dir)

  # Construct path to the library in the sibling lib directory
  library_path = File.join(project_root, "lib", "libinjector.so")

  # Check if library exists
  unless File.exists?(library_path)
    STDERR.puts "Error: Library not found at #{library_path}"
    exit 1
  end

  # Load the injector library
  LibC.dlopen(library_path, LibC::RTLD_LAZY | LibC::RTLD_GLOBAL)
end

# Load the injector library
LIB = load_injector_library

puts LIB.inspect

SYM = LibC.dlsym LIB, "register"

puts SYM.inspect

PROC = Proc(Void).new SYM, Pointer(Void).null

PROC.call

# TODO: Write documentation for `Cli`
module Cli
  VERSION = "0.1.0"

  # TODO: Put your code here
end
