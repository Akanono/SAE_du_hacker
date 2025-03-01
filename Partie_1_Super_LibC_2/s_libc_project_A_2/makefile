# Définitions des variables
CC = gcc
AS = as
CFLAGS = -m32 -Wall
LDFLAGS = -shared
BUILD_DIR = build
SRC_DIR = src
LIB_DIR = lib
INCLUDE_DIR = include
TEST_DIR = test
TARGET_LIB = $(LIB_DIR)/libs_libc.so
TARGET_TEST = $(TEST_DIR)/test_prog
OBJS = $(BUILD_DIR)/s_string.o $(BUILD_DIR)/s_math.o $(BUILD_DIR)/s_stdio.o $(BUILD_DIR)/s_stdlib.o

# Liste des fichiers sources en assembleur
ASM_SRC = $(SRC_DIR)/s_string.s $(SRC_DIR)/s_math.s $(SRC_DIR)/s_stdio.s $(SRC_DIR)/s_stdlib.s

# Convertit chaque fichier .s en .o dans le répertoire build
ASM_OBJ = $(ASM_SRC:$(SRC_DIR)/%.s=$(BUILD_DIR)/%.o)

# Règle principale : Compiler la bibliothèque
all: $(TARGET_LIB)

# Compilation des fichiers objets
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Création du dossier build s'il n'existe pas
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Création de la bibliothèque partagée
$(TARGET_LIB): $(OBJS) | $(LIB_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

# Création du dossier lib s'il n'existe pas
$(LIB_DIR):
	mkdir -p $(LIB_DIR)

# Compilation du programme de test
test: $(TARGET_TEST)

$(TARGET_TEST): $(TEST_DIR)/main.c $(TARGET_LIB)
	$(CC) $(CFLAGS) -o $@ $(TEST_DIR)/main.c -L$(LIB_DIR) -ls_libc -I$(INCLUDE_DIR) -Wl,-rpath=$(LIB_DIR)

# Nettoyage des fichiers objets et du dossier build
clean:
	rm -rf $(BUILD_DIR)/*.o $(TARGET_LIB) $(TARGET_TEST)

# Installation de la bibliothèque dans le système
install: $(TARGET_LIB)
	sudo cp $(TARGET_LIB) /usr/local/lib/
	sudo ldconfig
	echo "Bibliothèque installée dans /usr/local/lib/"

.PHONY: all test clean install

