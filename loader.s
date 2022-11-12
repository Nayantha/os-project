    global loader                  		   		; the entry symbol for ELF

    MAGIC_NUMBER equ 0x1BADB002     		; define the magic number constant
    FLAGS                  equ 0x0              	    		; multiboot flags
    CHECKSUM         equ -MAGIC_NUMBER 		; calculate the checksum
                                    				; (magic number + checksum + flags should equal 0)
                                    
    KERNEL_STACK_SIZE equ 4096     			; size of stack in bytes

    section .bss
    align 4                         				; align at 4 bytes
    kernel_stack:                   				; label points to beginning of memory
        resb KERNEL_STACK_SIZE      			; reserve stack for the kernel

    section .text:                  				; start of the text (code) section
    align 4                         				; the code must be 4 byte aligned
        dd MAGIC_NUMBER             			; write the magic number to the machine code,
        dd FLAGS                    				; the flags,
        dd CHECKSUM                			; and the checksum

    loader:                         				; the loader label (defined as entry point in linker script)
    mov esp, kernel_stack + KERNEL_STACK_SIZE   	; point esp to the start of the
                                                			; stack (end of memory area)
        
        
    ; The assembly code
<<<<<<< HEAD
<<<<<<< HEAD
    extern main   		  ; the function main is defined in kmain.c
    call main                   	; call the function, the result will be in eax
=======
    extern sum_of_three   		  ; the function sum_of_three is defined elsewhere
    push dword 3           		  ; arg3
    push dword 2            	     	  ; arg2
    push dword 1            		  ; arg1
    call sum_of_three                   ; call the function, the result will be in eax
>>>>>>> d49567d6a6eebd64ef778a18ce21b5b92a8fba32
=======
    extern main   		  ; the function main is defined in kmain.c
    call main                   	; call the function, the result will be in eax
>>>>>>> 4f904a0727bf821067d824a5f264c465c2a69310
    
    
    .loop:
        jmp .loop                   ; loop forever