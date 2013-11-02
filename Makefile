
#=== VARIABLES ===
NAME = MY_PROG
SRCS =	main.c
INCLUDE = -I/usr/local/include/SDL2
LIBS = -L/usr/local/lib -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_gfx

SRCS_DIR = srcs/
INC_DIR = includes/
OBJ_DIR = obj/
OBJ = $(SRCS:.c=.o)

CC = gcc
# !! ansi + sdl wont work
CFLAGS = -Wall -Wextra -pedantic -I $(INC_DIR) $(INCLUDE)

#=== SPECIAL ===
.PHONY: all, clean, mrproper, re, cls
.SUFFIXES:

#=== REGLES BINAIRES ===
all: $(NAME)

$(NAME): $(addprefix $(OBJ_DIR), $(OBJ))
	@echo "building app"
	@$(CC) $(CFLAGS) $(LIBS) $^ -o $@

$(OBJ_DIR)%.o: $(SRCS_DIR)%.c $(INC_DIR)constantes.h $(INC_DIR)%.h
	@echo "building $@"
	@mkdir -p obj
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)main.o: $(SRCS_DIR)main.c $(INC_DIR)constantes.h
	@echo "building $@"
	@mkdir -p obj
	@$(CC) $(CFLAGS) -c $< -o $@

#=== REGLES SPECIALES ===
cls:
	clear

clean:
	@echo "cleaning directory (*.obj)"
	@rm -f $(addprefix $(OBJ_DIR), $(OBJ))

mrproper: clean
	@echo "cleaning directory (app + *.obj)"
	@rm -f $(NAME)

re: cls mrproper all
	@echo "re"
