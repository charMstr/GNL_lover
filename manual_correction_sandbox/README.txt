the first main called "main.c" will simply print on the standard output the
file given to the executable as argument.

the second main named "main_replace_malloc_with_fake_malloc.c" should be
compiled with the files altered, replacing succecively each "malloc" with 
"fake_malloc" (which always returns NULL).
