# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: charmstr <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/18 18:51:52 by charmstr          #+#    #+#              #
#    Updated: 2019/11/22 04:13:24 by charmstr         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ifndef $(MAIN)
MAIN = $(MAINS_PATH)main.c
endif

ifndef $(BUF_SIZE)
BUF_SIZE = 32
endif


############################ BASICS ###########################################
###############################################################################
CFLAGS = -g -fsanitize=address -Wall -Wextra -Werror -D BUFFER_SIZE=$(BUF_SIZE)
CC = gcc
NAME = get_next_line
I_FLAGS = -I $(INCLUDE_PATH)
.PHONY = clean fclean re all bonus
###############################################################################
###############################################################################



############################ PATHS ############################################
###############################################################################
OBJ_PATH = ./objects/
SRC_PATH = ./copy_in_here_GNL_files/
MAINS_PATH = ./mains/
INCLUDE_PATH = ./copy_in_here_GNL_files/
###############################################################################
###############################################################################



############################ COLORS ###########################################
###############################################################################
REMOVE_FG = \033[38;5;196m 
CREAT_FG = \033[38;5;46m
BLACK_FG = \033[38;5;0m
BLACK_BG = \033[48;5;0m
CLEAR_COLOR = \033[m

NAME_BG = \033[48;5;39m 
BONUS_BG = \033[48;5;213m
OBJECTS_BG = \033[48;5;11m
RANLIB_BG = \033[48;5;172m
###############################################################################
###############################################################################



########################### HEADER FILES ######################################
###############################################################################
HEADER_FILES = get_next_line.h GNL_TESTS.h
FILE_H = $(patsubst %, $(INCLUDE_PATH)%, $(HEADER_FILES))

BONUS_HEADER_FILES = ./get_next_line_bonus.h GNL_TESTS.h
BONUS_FILE_H = $(patsubst %, $(INCLUDE_PATH)%, $(BONUS_HEADER_FILES))
###############################################################################
###############################################################################



########################### FILES #############################################
###############################################################################
FILES = get_next_line\
		get_next_line_utils\
		GNL_TESTS\

BONUS_FILES = get_next_line_bonus\
		get_next_line_utils_bonus\
		GNL_TESTS_BONUS\

SRC = $(patsubst %, $(SRC_PATH)%.c, $(FILES))
OBJ = $(patsubst %, $(OBJ_PATH)%.o, $(basename $(notdir $(SRC))))

OBJ_MAIN = $(OBJ_PATH)main.o

SRC_BONUS = $(patsubst %, $(SRC_PATH)%.c, $(BONUS_FILES))
OBJ_BONUS = $(patsubst %, $(OBJ_PATH)%.o, $(basename $(notdir $(SRC_BONUS))))
###############################################################################
###############################################################################



all: $(NAME)

$(OBJ_PATH):
	@mkdir -p $(OBJ_PATH)
#	@echo "\t\t$(CREAT_FG)created the $(OBJECTS_BG)$(BLACK_FG)$@ $(BLACK_BG)$(CREAT_FG) repository$(CLEAR_COLOR)"

$(OBJ_MAIN):
	@$(CC) $(CFLAGS) $(IFLAGS) -c $(MAIN) -o $@

$(NAME): $(OBJ) $(FILE_H) $(OBJ_MAIN)
#	@echo "\t\t$(CREAT_FG)compiling $(NAME_BG)$(BLACK_FG)$(NAME)$(BLACK_BG)$(CREAT_FG) with the BUFFER_SIZE= $(BLACK_FG)$(BONUS_BG) $(BUF_SIZE) $(BLACK_BG)$(CREAT_FG) and the main: $(BLACK_FG)$(BONUS_BG) $(MAIN) $(CLEAR_COLOR)"
	@$(CC) $(CFLAGS) $(OBJ) $(OBJ_MAIN) $(IFLAGS) -o $@

$(OBJ): $(OBJ_PATH)%.o: $(SRC_PATH)%.c | $(OBJ_PATH)
	@$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

bonus: $(OBJ_BONUS) $(BONUS_FILE_H) $(OBJ_MAIN)
#	@echo "\t\t$(CREAT_FG)compiling $(NAME_BG)$(BLACK_FG)$(NAME) $(BLACK_BG)$(CREAT_FG) with $(BONUS_BG)$(BLACK_FG) BONUSES $(BLACK_BG)$(CREAT_FG)...$(CLEAR_COLOR)"
	@$(CC) $(CFLAGS) $(OBJ_BONUS) $(OBJ_MAIN) $(IFLAGS) -o $(NAME)

$(OBJ_BONUS): $(OBJ_PATH)%.o : $(SRC_PATH)%.c | $(OBJ_PATH)
	@$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

clean:
#	@echo "\t\t$(REMOVE_FG)deleting $(OBJECTS_BG)$(BLACK_FG)$(OBJ_PATH) $(BLACK_BG)$(REMOVE_FG) containing all the .o files...$(CLEAR_COLOR)" 
	@rm -rf $(OBJ_PATH)

fclean: clean
#	@echo "\t\t$(REMOVE_FG)deleting $(NAME_BG)$(BLACK_FG)$(NAME) $(BLACK_BG)$(REMOVE_FG)...$(CLEAR_COLOR)" 
	@rm -rf user_output
	@rm -rf $(NAME)

#clean_name:
#	@rm -rf $(OBJ_MAIN)

#run: clean_name all 
#	@echo "\t\t$(CREAT_FG)running $(NAME_BG)$(BLACK_FG)$(NAME) $(BLACK_BG)$(CREAT_FG)  ./test_files_GNL/file_test$(BLACK_FG)$(BONUS_BG) $(TEST) $(CLEAR_COLOR)"
#	./$(NAME) test_files_GNL/file_test$(TEST)
#	cat test_files_GNL/file_test$(TEST)

re: fclean all
