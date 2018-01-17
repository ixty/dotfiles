set disassembly-flavor intel

set prompt gdb\033[1;36m> \033[m

define hook-stop
#    echo \033[1;30m
#    bt
#    echo \033[m===============================================\n
#    echo \033[1;30m
#    i threads
#    echo \033[m
#    x/i $rip
end
          
define xxd
    dump binary memory dump.bin $arg0 $arg0+$arg1
    shell xxd dump.bin
end
        

# set  disassemble-next-line on
# show disassemble-next-line
