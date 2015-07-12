
NAME := a.out
INCS_DIR := incs/
SRCS_DIR := srcs/
SRCS := $(notdir $(wildcard $(SRCS_DIR)/*.c))
OBJS_DIR := obj/
OBJS := $(SRCS:.c=.o)

CWARNINGS := -Wall -Wextra -pedantic \
	-Wcast-align -Wfloat-equal -Winit-self -Wmissing-prototypes -Wshadow \
	-Wswitch-default -Wswitch-enum  -Wunreachable-code -Wuninitialized \
	-Wstrict-prototypes
CINCS := #-I/usr/local/include/SDL2
CLIBS := #-L/usr/local/lib -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_gfx
CFLAGS := $(CWARNINGS) -I $(INCS_DIR) $(CINCS) -std=c99 -g-O2

CC := gcc

.PHONY: all, clean_bin, clean_obj re
.SUFFIXES:

all: clean_bin $(NAME)

$(NAME): $(addprefix $(OBJS_DIR), $(OBJS))
	$(CC) $(CFLAGS) $^ -o $@ $(CLIBS)

$(OBJ_DIR)%.o: $(SRCS_DIR)%.c  $(INCS_DIR)%.h
	@mkdir -p $(OBJS_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean_bin:
	rm -f $(NAME)

clean_obj:
	rm -f $(OBJS_DIR)/*

re: clean_obj all

