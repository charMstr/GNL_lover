#!/bin/sh

REMOVE_FG="\033[38;5;196m"
CREAT_FG="\033[38;5;46m"
BLACK_FG="\033[38;5;0m"
BLACK_BG="\033[48;5;0m"

CLEAR_COLOR="\033[m"

MAIN_BG="\033[48;5;39m"
SIZE_BG="\033[48;5;11m"
TEST_FILE_BG="\033[48;5;172m"

for MAIN_NAME in  mains/*
do
	if [ $MAIN_NAME == "mains/main.c" ]
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		for TEST in `seq 1 8`
		do
			TEST_FILE=./test_files_GNL/test_file${TEST}
			echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\ttest_file${TEST}\t\t${CLEAR_COLOR}"
			for SIZE in `seq 1 10`
			do
				make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}
				./get_next_line ${TEST_FILE}
				diff -u user_output ${TEST_FILE}
				RESULT=$?
				if [ ${RESULT} -eq 0 ]
				then
					echo "when BUFFER_SIZE=${SIZE} \033[32mOK\033[0m"
				else
					echo "when BUFFER_SIZE=${SIZE} \033[31mKO\033[0m"
				fi
			done
		done
	elif [ ${MAIN_NAME} == "mains/main_no_end_of_line_at_end.c" ]
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=4
		TEST_FILE=./test_files_GNL/test_file9
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${TEST_FILE}\t\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line ${TEST_FILE}
		diff -u user_output ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "\033[32mGNL OK with no end of line present\033[0m"
		else
			echo "\033[31mGNL KO with no end of line present\033[0m"
		fi
	elif [ ${MAIN_NAME} == "mains/main_INPUTS_WRONG.c" ]
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=3
		TEST_FILE=Makefile
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${TEST_FILE}\t\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "\033[32mGNL OK with WRONG_INPUTS\033[0m"
		else
			echo "\033[31mGNL KO with WRONG INPUTS\033[0m"
		fi
	elif [ ${MAIN_NAME} == "mains/main_STDIN_FILENO.c" ];
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=12
		TEST_FILE=/dev/stdin
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${TEST_FILE}\t\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line
	fi
done

rm user_output
make fclean
