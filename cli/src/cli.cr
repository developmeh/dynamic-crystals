require "./libC/lib_c.cr"

# TODO: Write documentation for `Cli`
module Cli
  VERSION = "0.1.0"

  # TODO: Put your code here

LIB = LibC.dlopen("/home/paulscoder/repos/crystal/network-cli/injector/injector", LibC::RTLD_LAZY | LibC::RTLD_GLOBAL)

puts LIB.inspect

SYM = LibC.dlsym LIB, "register"

puts SYM.inspect

PROC = Proc(Void).new SYM, Pointer(Void).null

PROC.call

end
