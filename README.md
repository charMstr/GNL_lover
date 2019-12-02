# GNL_lover
test for the get_next_line project at school 42. (cursus42, november 2019)
mainly combinatory tricky tests :)


1/	copy the 3 files get_next_line.c get_next_line_utils.c et get_next_line.h
	inside the folder "copy_in_here_GNL_files"

2/	in the root directory, run the script:
	ex: $>./GNL_lover.sh	or	$>sh GNL_lover.sh
	note: if you kill the script while running you can run a "make fclean"
	command to clean the "./objects" directory...

3/	GNL_lover does a nice little check on the multi fd at the very end of this
	script. it also helps the corrector for different correction key points:
	- read function is using the BUFFER_SIZE defined value.
	- no global
	- works with BUFFER_SIZE=1 (many tests)
	- works with BUFFER_SIZE=1024
	- single static variable is used? (bonus)

4/	keep in mind that it does use the -g -fsanitize=address at each compile
	time. therefore it won't work fine if there is erors in memory management
	in some of your functions.
	therefore warnings will probably occur in each single tests if they are not
	isolated problems
	Keep also in mind that it doesnt check for leaks... you should check for
	leaks even in the worst case scenarios like when gnl should returns -1.

5/	what it does technicaly.
	This GNL_lover script will use a makefile and compile many times with
	different mains, different files, each time with different 
	-D BUFFER_SIZE=xx parameters, in order to cross check all possible
	comninations within a reasonable enough range of value.

	Each time it will run the "get_next_line" executable taking a test folder
	as input argument:
	ex: $>./get_next_line test_file3
	And redirect the output in user_output file.
	Then do a diff with the original file.
	ex: $>diff -u user_output test_file3

7/	The "manual_correction_sandbox" folder is there for ease of correction...
	but not used.
	You can copy the get_next_line* files there and have a main ready for you.
	it takes as input argument the name of a file to display on stdout.

	note: the second main contains a "fake_malloc()" function (always returns
	NULL) which you can substitute to the real "malloc" and check the behavior
	of the GNL project in case of insuficsient allocatable memory.

6/	the scripts have been set to a 777 rights for you to enjoy life at its
	maximum.

with love, charmstr@student.42.fr
