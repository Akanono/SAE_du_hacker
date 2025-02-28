
#include <stdio.h>
#include <string.h>

int main() {
    char correct_login[] = "superuser";
    char correct_password[] = "AlphaPass";
    char input_login[50], input_password[50];

    printf("Login : ");
    scanf("%s", input_login);
    printf("Password : ");
    scanf("%s", input_password);

    if (strcmp(input_login, correct_login) == 0 && strcmp(input_password, correct_password) == 0) {
        printf("** ACCESS GRANTED **\n");
    } else {
        printf("** ACCESS DENIED **\n");
    }
    return 0;
}

