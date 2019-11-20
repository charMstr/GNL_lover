# GNL_lover
test for the get_next_line project at school 42. (cursus42, november 2019)


1/	copy the 3 files get_next_line.c get_next_line_utils.c et get_next_line.h
	inside the folder "copy_in_here_GNL_files"

2/	in the root directory, run the script: ex: ./GNL_lover.sh
	note: if you kill the script while running you can run a "make fclean"
	command to clean the ./object directory...

3/	GNL_lover does not check the multi fd bonus yet even though the rule exists
	in the Makefile aready...

4/	keep in mind that it does use the -g -fsanitize=address at each compile
	time. therefore it wont work fine if there is leaks in your functions.

5/	what it does:
	This GNL_lover script will use a makefile and compile many times with
	different mains, different -D BUFFER_SIZE=... size parameter to check all
	comninations within a reasonable enough range of value.

	Each time it will run the "get_next_line" executable taking a test folder
	as input argument:
	ex: $>./get_next_line test_file3
	And redirect the output in a file. Then do a diff with the original file.
	ex: $>diff -u user_output test_file3

7/	the "manual_correction_sandbox" folder is there for ease. but not used.
	you can copy the get_next_line* files there and have a main ready for you.
	it takes as input argument the name of a file to display on stdin.
	note: it always add a '\n' to the last read line.

6/	the scripts have been set to a 777 rights for you to enjoy life at its
	maximum.

with love, charmstr@student.42.fr
