#!/bin/sh

WEIRD_BG="\033[48;5;194m"
BLACK_FG="\033[38;5;0m"
BLACK_BG="\033[48;5;0m"

CLEAR_COLOR="\033[m"

MAIN_BG="\033[48;5;39m"
SIZE_BG="\033[48;5;11m"
TEST_FILE_BG="\033[48;5;172m"

FOLD="./copy_in_here_GNL_files/"

if [ ! -f "${FOLD}get_next_line.c" ] || [ ! -f "${FOLD}get_next_line_utils.c" ] || [ ! -f "${FOLD}get_next_line.h" ]
then
	echo "get_next_line.c or\nget_next_line_utils.c or\nget_next_line.h\033[38;5;1m is missing${CLEAR_COLOR} in folder '${FOLD}'"
	echo "\n\t🥰  RTFM 🥰 "
	exit
fi

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
					echo "when BUFFER_SIZE=${SIZE}:\t\033[32mOK with file ending with a '\ n'\033[0m"
				else
					echo "when BUFFER_SIZE=${SIZE}:\t\033[31mKO with file ending with a '\ n'\033[0m"
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
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t${MAIN_NAME}\t${CLEAR_COLOR}"
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
					echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with no '\ n' at end of file\033[0m"
				else
					echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with no '\ n' at end of file\033[0m"
				fi
			done
		done
	elif [ ${MAIN_NAME} == "mains/main_INPUTS_WRONG.c" ]
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t${MAIN_NAME}\t\t${CLEAR_COLOR}"
		SIZE=3
		TEST_FILE=Makefile
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t\t${TEST_FILE}\t\t${CLEAR_COLOR}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with WRONG_INPUTS\033[0m"
		else
			echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with WRONG INPUTS\033[0m"
		fi
		SIZE=0
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line ${TEST_FILE}
		RESULT=$?
		if [ ${RESULT} -eq 0 ]
		then
			echo "when BUFFER_SIZE=${SIZE}:\t\033[32mGNL OK with BUFFER_SIZE = 0\033[0m"
		else
			echo "when BUFFER_SIZE=${SIZE}:\t\033[31mGNL KO with BUFFER_SIZE = 0\033[0m"
		fi
	elif [ ${MAIN_NAME} == "mains/main_dev_null.c" ];
	then
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t${MAIN_NAME}\t\t\t${CLEAR_COLOR}"
		SIZE=12
		TEST_FILE=/dev/null
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t${WEIRD_BG}${BLACK_FG}\t${TEST_FILE}\t${TEST_FILE_BG}${BLACK_FG}\t${CLEAR_COLOR}"
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
		echo "\n\n\tbuilding with main: ${MAIN_BG}${BLACK_FG}\t\t${MAIN_NAME}\t\t${CLEAR_COLOR}"
		SIZE=12
		TEST_FILE=/dev/stdin
		echo "\n\n\t\ttest_file is:\t\t${TEST_FILE_BG}${BLACK_FG}\t${WEIRD_BG}${BLACK_FG}\t${TEST_FILE}\t${TEST_FILE_BG}${BLACK_FG}\t${CLEAR_COLOR} BUFFER_SIZE=${SIZE}"
		make re MAIN=${MAIN_NAME} BUF_SIZE=${SIZE}	
		./get_next_line
	fi
done

echo "\n\n\n 🔎 check if the read function is called with 'BUFFER_SIZE': 🔎\n"
cat copy_in_here_GNL_files/get_next_line.c copy_in_here_GNL_files/get_next_line_utils.c | grep "read(" | grep -n --colour "BUFFER_SIZE"
RESULT=$?
if [ ${RESULT} == 0 ]
then
	echo "\033[38;5;2m\n\t=====> ✅\n\033[0m"
else
	echo "\033[38;5;1m\n\t=====> ❌\n\033[0m"
fi

echo "\n\n\n 🔎 check if a global was declared: 🔎\n"

RESULT=`cat copy_in_here_GNL_files/* | grep -n --colour "global" | wc -l`
if [ ${RESULT} == 0 ]
then
	echo "\033[38;5;2m\t=====> ✅\t 0 \033[0mglobal variable used.\n"
else
	echo "\033[38;5;1m${RESULT}${CLEAR_COLOR} global variable(s) used.\n"	
fi

echo "\n\n\n 🔎 check how many static variables were declared: 🔎\n"

RESULT=`cat copy_in_here_GNL_files/get_next_line.c copy_in_here_GNL_files/get_next_line_utils.c | grep -n --colour "^.static.*;$" | wc -l`
if [ ${RESULT} != 0 ]
then
	if [ ${RESULT} == 1 ]
	then
		echo "\033[38;5;2m\t=====> ✅ ${RESULT}${CLEAR_COLOR} static variable used in basic files.\n"	
	else
		echo "\033[38;5;2m\t=====> ✅ ${RESULT}${CLEAR_COLOR} static variables used in basic files.\n"	
	fi
fi

RESULT=`cat copy_in_here_GNL_files/get_next_line_bonus.c copy_in_here_GNL_files/get_next_line_utils_bonus.c | grep -n --colour "^.static.*;$" | wc -l`
if [ ${RESULT} != 0 ]
then
	if [ ${RESULT} == 1 ]
	then
		echo "\033[38;5;2m\t=====> ✅ ${RESULT}${CLEAR_COLOR} static variable used in bonus files.\n"	
	else
		echo "\033[38;5;2m\t=====> ✅ ${RESULT}${CLEAR_COLOR} static variables used in bonus files.\n"
	fi
fi


if [ ${RESULT} -gt 0 ]
then
	echo "  ===>  BONUS FILES PRESENT... "
	echo  ""
	for i in `seq 5 0`
	do
		echo "\033[1A\033[38;5;10m$i\033[m"
		sleep 0.6
	done
	echo "\033[1A "
	echo "  ===>  START "
	sleep 0.5
	make fclean
	make bonus MAIN="mains/main_multy_fd.c"
	./get_next_line mains/main.c mains/main_INPUTS_WRONG.c mains/main_STDIN_FILENO.c mains/main_dev_null.c
	echo "  ===>  END "
fi

rm user_output
make fclean
