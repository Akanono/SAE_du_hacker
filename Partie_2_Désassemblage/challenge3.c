
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Missing login and password !\n");
        return 1;
    }

    char correct_login[] = "XahHaf1J";
    char correct_password[] = "Fae9v";

    if (strcmp(argv[1], correct_login) == 0 && strcmp(argv[2], correct_password) == 0) {
        printf(" ACCESS GRANTED \n");
    } else {
        printf(" ACCESS DENIED \n");
    }
    return 0;
}
