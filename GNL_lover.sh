#!/bin/sh

WEIRD_BG="\033[48;5;203m"
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
		for TEST in `seq 1 9`
		do
			TEST_FILE=./test_files_GNL/test_file${TEST}
			echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\ttest_file${TEST}\t\t${CLEAR_COLOR}"
			for SIZE in `seq 1 5`
			do
				make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}
				./get_next_line ${TEST_FILE}
				diff -u user_output ${TEST_FILE}
				RESULT=$?
				if [ ${RESULT} -eq 0 ]
				then
					echo "when BUFFER_SIZE=${SIZE}:\t\033[32mOK with only '\ n' or file ending with a '\ n'\033[0m"
				else
					echo "when BUFFER_SIZE=${SIZE}:\t\033[31mKO with only '\ n' or file ending with a '\ n'\033[0m"
				fi
			done
		done
		SIZE=1024
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}
		./get_next_line ${TEST_FILE}
		diff -u user_output ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "\t\twhen BUFFER_SIZE= ⚠️  ${WEIRD_BG}${BLACK_FG} ${SIZE} ${CLEAR_COLOR} ⚠️ : \033[32mOK${CLEAR_COLOR}"
		else
			echo "\t\twhen BUFFER_SIZE= ${WEIRD_BG}${BLACK_FG} ${SIZE} ${CLEAR_COLOR} : \033[32mOK${CLEAR_COLOR}"
		fi
	elif [ ${MAIN_NAME} == "mains/main_no_end_of_line_at_end.c" ] 							########						#modify the iF in a elif
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		for TEST in `seq 10 17`
		do
			TEST_FILE=./test_files_GNL/test_file${TEST}
			echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\ttest_file${TEST}\t\t${CLEAR_COLOR}"
			for SIZE in `seq 3 5`
			do
				make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}
				./get_next_line ${TEST_FILE}
				diff -u user_output ${TEST_FILE}
				RESULT=$?
				if [ ${RESULT} -eq 0 ]
				then
					echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with no '\ n' present at end of file\033[0m"
				else
					echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with no '\ n' present at end of file\033[0m"
				fi
			done
		done
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
			echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with WRONG_INPUTS\033[0m"
		else
			echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with WRONG INPUTS\033[0m"
		fi
	elif [ ${MAIN_NAME} == "mains/main_dev_null.c" ];
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=12
		TEST_FILE=/dev/null
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${WEIRD_BG}${BLACK_FG}${TEST_FILE}${TEST_FILE_BG}${BLACK_FG}\t\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with /dev/null\033[0m"
		else
			echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with /dev/null\033[0m"
		fi
	elif [ ${MAIN_NAME} == "mains/main_STDIN_FILENO.c" ];
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=12
		TEST_FILE=/dev/stdin
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${WEIRD_BG}${BLACK_FG}${TEST_FILE}${TEST_FILE_BG}${BLACK_FG}\t\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line
	fi
done

rm user_output
make fclean
