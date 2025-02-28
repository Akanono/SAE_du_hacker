
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // Verification du nombre d'arguments
    if (argc < 3) {
        printf("Missing login and password !\n");
        return 1;
    }

    // Conversion des entrees en entiers
    int login = atoi(argv[1]);
    int password = atoi(argv[2]);

    // Valeurs correctes attendues
    int correct_login = 77;
    int correct_password = 99;

    // Verification des identifiants
    if (login == correct_login && password == correct_password) {
        printf("** ACCESS GRANTED **\n");
    } else {
        printf("** ACCESS DENIED **\n");
    }

    return 0;
}
