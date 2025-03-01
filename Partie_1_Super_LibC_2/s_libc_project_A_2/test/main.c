#include <stdio.h>
#include "s_string.h"
#include "s_math.h"
#include "s_stdio.h"
#include "s_stdlib.h"

int main() {
    // ==== TEST s_string.h ====
    printf("\n==== TEST s_string.h ====\n");
    char str1[50] = "Hello";
    char str2[50] = "World";
    char buffer[50];

    printf("s_strlen(\"%s\") = %d\n", str1, s_strlen(str1));

    s_strcpy(str2, str1);
    printf("s_strcpy: str2 = %s\n", str2);

    s_strcat(str1, " World!");
    printf("s_strcat: %s\n", str1);

    printf("phrase :C programming (buffer = 4)\n");
    s_strncpy(buffer, "C programming", 4);
    buffer[4] = '\0'; // s'assurer de bien terminer la chaîne
    printf("s_strncpy: %s\n", buffer);

    printf("phrase : is fun! (buffer = 4)\n");
    s_strncat(buffer, " is fun!", 4);
    printf("s_strncat: %s\n", buffer);

    printf("Comparaison de \"%s\" et \"%s\"\n", str1, str2);
    int cmp1 = s_strcmp(str1, str2);
    printf("s_strcmp(\"%s\", \"%s\") = %d\n", str1, str2, cmp1);

    int cmp2 = s_strcmp("Hello", "World");
    printf("s_strcmp(\"Hello\", \"World\") = %d\n", cmp2);

    int cmp3 = s_strncmp("Hello", "Hellz", 4);
    printf("s_strncmp(\"Hello\", \"Hellz\", 4) = %d\n", cmp3);

    char *found = s_strchr("abcdef", 'd');
    if (found)
        printf("s_strchr(\"abcdef\", 'd') = %s\n", found);
    else
        printf("s_strchr(\"abcdef\", 'd') = NULL\n");

    // ==== TEST s_math.h ====
    printf("\n==== TEST s_math.h ====\n");
    printf("s_abs(-10) = %d\n", s_abs(-10));
    printf("s_div(10, 2) = %d\n", s_div(10, 2));
    printf("s_pow(2, 3) = %d\n", s_pow(2, 3));
    printf("s_exp(1.0) ≈ %f\n", s_exp(1.0));

    // ==== TEST s_stdlib.h ====
    printf("\n==== TEST s_stdlib.h ====\n");
    printf("s_abs2(-20) = %d\n", s_abs2(-20));
    printf("s_abs2(15) = %d\n", s_abs2(15));
    printf("s_abs2(0) = %d\n", s_abs2(0));
    printf("s_atoi(\"1234\") = %d\n", s_atoi("1234"));
    
    // ==== TEST s_stdio.h ====
    printf("\n==== TEST s_stdio.h ====\n");
    s_puts("Test de s_puts!");


    return 0;
}


