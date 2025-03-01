#ifndef S_STRING_H
#define S_STRING_H

#include <stddef.h>  // Pour size_t

// Déclarations des fonctions
extern int s_strlen(const char *str);
extern char *s_strcpy(char *dest, const char *src);
extern char *s_strncpy(char *dest, const char *src, size_t n);
extern char *s_strcat(char *dest, const char *src);
extern char *s_strncat(char *dest, const char *src, size_t n);
extern int s_strcmp(const char *s1, const char *s2);
extern int s_strncmp(const char *s1, const char *s2, size_t n);
extern char *s_strchr(const char *s, int c);

#endif // S_STRING_H

