.section .text

# s_abs: Retourne la valeur absolue d'un entier
.global s_abs
s_abs:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax   # Charger n
    testl %eax, %eax
    jge end_abs          # Si n >= 0, retour
    negl %eax            # Sinon, prendre l'opposé
end_abs:
    popl %ebp
    ret

# s_div: Effectue la division entière n / d et retourne le quotient
.global s_div
s_div:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax   # Charger n
    cltd                 # Étendre le signe de eax en edx:eax
    idivl 12(%ebp)       # Diviser par d
    popl %ebp
    ret

# s_pow: Calcule x^y (exponentiation entière)
.global s_pow
s_pow:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax   # Charger x
    movl 12(%ebp), %ecx  # Charger y
    cmpl $0, %ecx
    jne pow_loop
    movl $1, %eax        # x^0 = 1
    jmp end_pow
pow_loop:
    imull 8(%ebp), %eax
    loop pow_loop
end_pow:
    popl %ebp
    ret

# s_exp: Approximation de e^x en utilisant la série de Taylor
# e^x = 1 + x/1! + x^2/2! + x^3/3! + ... (approximé jusqu'à N termes)
.global s_exp
s_exp:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp           # Réserver un espace pour stocker `n` en mémoire

    fld1                    # Charger 1.0 (premier terme de la série)
    flds 8(%ebp)            # Charger x
    flds 8(%ebp)            # Charger x (on le garde pour les puissances)
    flds 8(%ebp)            # Charger x (on le garde encore pour le facteur)
    
    movl $1, %ecx           # Initialiser le compteur n = 1
    fld1                    # Charger 1.0 (facteur de division)
    
exp_loop:
    fmul %st(1), %st        # Multiplier par x
    movl %ecx, -4(%ebp)     # Stocker `n` dans la pile
    fildl -4(%ebp)          # Charger `n` en flottant
    fdiv %st(1), %st        # Diviser par n!
    fadd %st(2), %st        # Ajouter au résultat final
    incl %ecx               # Incrémenter n
    cmpl $10, %ecx          # Limite d'approximation (10 termes)
    jl exp_loop

    fstp %st(1)             # Nettoyer la pile FPU
    fstp %st(1)
    addl $4, %esp           # Restaurer l'espace alloué
    popl %ebp
    ret


