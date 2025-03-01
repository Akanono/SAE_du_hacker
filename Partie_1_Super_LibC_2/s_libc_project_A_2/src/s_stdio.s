.section .text_s_stdio
.global init_s_stdio

init_s_stdio:
    ret

.section .text
.global s_puts

s_puts:
    pushl %ebp
    movl %esp, %ebp
    pushl %esi          # Sauvegarde des registres utilisés
    pushl %edi

    movl 8(%ebp), %ecx  # Charger l'adresse de la chaîne

    test %ecx, %ecx     # Vérifier si la chaîne est NULL
    jz error_case       # Si NULL, retourner -1

    # Calcul de la longueur de la chaîne
    movl %ecx, %esi     # Sauvegarder l'adresse de départ
    xor %eax, %eax      # Réinitialiser %eax
    
count_length:
    movb (%esi), %al    # Charger un octet de la chaîne
    test %al, %al       # Vérifier si c'est '\0'
    jz length_found     # Si c'est le cas, on a la longueur
    incl %esi           # Passer au caractère suivant
    jmp count_length    # Boucle jusqu'à la fin de la chaîne

length_found:
    subl %ecx, %esi     # Longueur = adresse actuelle - adresse initiale
    movl %esi, %edx     # Charger la longueur dans %edx pour `sys_write`

    # Appel du syscall write (sys_write) pour afficher la chaîne
    movl $4, %eax       # syscall numéro 4 (sys_write)
    movl $1, %ebx       # File descriptor 1 (stdout)
    int $0x80           # Appel du noyau

    # Écrire le saut de ligne '\n'
    movl $4, %eax       # syscall numéro 4 (sys_write)
    movl $1, %ebx       # stdout
    movl $newline, %ecx # Adresse du saut de ligne
    movl $1, %edx       # Longueur de 1 caractère
    int $0x80           # Appel du noyau

    movl $0, %eax       # Retourner 0 (succès)
    jmp end_s_puts

error_case:
    movl $-1, %eax      # Retourner -1 en cas d'erreur

end_s_puts:
    popl %edi           # Restaurer les registres
    popl %esi
    popl %ebp
    ret

.section .data
newline:
    .byte 10  # '\n'

