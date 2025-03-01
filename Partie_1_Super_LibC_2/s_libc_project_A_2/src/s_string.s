.text

# -------------------------------------
# Implémentation de s_strlen
# int s_strlen(char *str)
.global s_strlen
s_strlen:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %esi  # Adresse de la chaîne
    xorl %eax, %eax

strlen_loop:
    movb (%esi,%eax), %dl
    cmpb $0, %dl
    jz strlen_end
    incl %eax
    jmp strlen_loop

strlen_end:
    pop %ebp
    ret

# -------------------------------------
# Implémentation de s_strcpy
# char *s_strcpy(char *dest, const char *src)
.global s_strcpy
s_strcpy:
    pushl %ebp
    movl %esp, %ebp
    pushl %edi
    pushl %esi

    movl 8(%ebp), %edi  # dest
    movl 12(%ebp), %esi # src

strcpy_loop:
    movb (%esi), %al  # Charge un octet de src
    movb %al, (%edi)  # Copie dans dest
    incl %esi
    incl %edi
    testb %al, %al    # Vérifie si on est à la fin ('\0')
    jnz strcpy_loop

    movl 8(%ebp), %eax  # Retourne dest
    popl %esi
    popl %edi
    popl %ebp
    ret

# -------------------------------------
# Implémentation de s_strncpy
# char *s_strncpy(char *dest, const char *src, size_t n)
.global s_strncpy
s_strncpy:
    pushl %ebp
    movl %esp, %ebp
    pushl %edi
    pushl %esi
    pushl %ecx

    movl 8(%ebp), %edi  # dest
    movl 12(%ebp), %esi # src
    movl 16(%ebp), %ecx # n

strncpy_loop:
    cmp $0, %ecx
    je strncpy_end
    movb (%esi), %al
    movb %al, (%edi)
    testb %al, %al
    jz strncpy_end
    incl %esi
    incl %edi
    decl %ecx
    jmp strncpy_loop

strncpy_end:
    movl 8(%ebp), %eax
    popl %ecx
    popl %esi
    popl %edi
    popl %ebp
    ret

# -------------------------------------
# Implémentation de s_strcat
# char *s_strcat(char *dest, const char *src)
.global s_strcat
s_strcat:
    pushl %ebp
    movl %esp, %ebp
    pushl %edi
    pushl %esi

    movl 8(%ebp), %edi  # dest
    movl 12(%ebp), %esi # src

strcat_find_end:
    movb (%edi), %al
    testb %al, %al
    jz strcat_copy
    incl %edi
    jmp strcat_find_end

strcat_copy:
    movb (%esi), %al
    movb %al, (%edi)
    testb %al, %al
    jz strcat_done
    incl %esi
    incl %edi
    jmp strcat_copy

strcat_done:
    movl 8(%ebp), %eax
    popl %esi
    popl %edi
    popl %ebp
    ret

# -------------------------------------
# Implémentation de s_strncat
# char *s_strncat(char *dest, const char *src, size_t n)
.global s_strncat
s_strncat:
    pushl %ebp
    movl %esp, %ebp
    pushl %edi
    pushl %esi
    pushl %ecx

    movl 8(%ebp), %edi  # dest
    movl 12(%ebp), %esi # src
    movl 16(%ebp), %ecx # n

strncat_find_end:
    movb (%edi), %al
    testb %al, %al
    jz strncat_copy
    incl %edi
    jmp strncat_find_end

strncat_copy:
    cmp $0, %ecx
    je strncat_done
    movb (%esi), %al
    movb %al, (%edi)
    testb %al, %al
    jz strncat_done
    incl %esi
    incl %edi
    decl %ecx
    jmp strncat_copy

strncat_done:
    movb $0, (%edi)
    movl 8(%ebp), %eax
    popl %ecx
    popl %esi
    popl %edi
    popl %ebp
    ret

# -------------------------------------
# Implémentation de s_strcmp
# int s_strcmp(const char *s1, const char *s2)
.global s_strcmp
s_strcmp:
    pushl   %ebp                 
    movl    %esp, %ebp           
    pushl   %esi                 
    pushl   %edi                 
    movl    8(%ebp), %esi        
    movl    12(%ebp), %edi       

compare:
    movb    (%esi), %al          
    movb    (%edi), %dl          
    cmpb    $0, %al              
    je      end_compare          
    cmpb    %dl, %al             
    jne     not_equal            
    incl    %esi                 
    incl    %edi                 
    jmp     compare              


end_compare:
    movl    $0, %eax              
    jmp     finish_strcmp         

not_equal:
    movl    $1, %eax              

finish_strcmp:
    popl    %edi                 
    popl    %esi                 
    popl    %ebp                 
    ret

# -------------------------------------
# Implémentation de s_strncmp
# int s_strncmp(const char *s1, const char *s2, size_t n)
.global s_strncmp
s_strncmp:
    pushl   %ebp                 
    movl    %esp, %ebp           
    pushl   %esi                 
    pushl   %edi                 
    pushl   %ebx                 
    movl    16(%ebp), %ecx       
    movl    12(%ebp), %esi       
    movl    8(%ebp), %edi       

# Boucle de comparaison
compare2:
    movb    (%esi), %al          
    movb    (%edi), %dl          
    cmpb    $0, %al              
    je      end_compare2          
    cmpb    $0, %dl              
    je      end_compare2          
    cmpb    %dl, %al             
    jne     not_equal2            
    incl    %esi                 
    incl    %edi                 
    loop    compare2              


end_compare2:
    movl    $0, %eax              
    jmp     finish_strncmp        


not_equal2:
    movl    $1, %eax              


finish_strncmp:
    popl    %ebx                 
    popl    %edi                 
    popl    %esi                 
    popl    %ebp                 
    ret


# -------------------------------------
# Implémentation de s_strchr
# char *s_strchr(const char *s, int c)
.global s_strchr
s_strchr:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %esi
    movl 12(%ebp), %eax

    testl %esi, %esi
    jz strchr_not_found  # Retourne NULL si s est NULL

strchr_loop:
    movb (%esi), %dl
    cmpb %al, %dl
    je strchr_found
    testb %dl, %dl
    jz strchr_not_found
    incl %esi
    jmp strchr_loop

strchr_found:
    movl %esi, %eax
    pop %ebp
    ret

strchr_not_found:
    movl $0, %eax
    pop %ebp
    ret

