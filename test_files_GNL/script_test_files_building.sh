#!/bin/sh

rm test_file*

for i in `seq 1 6`
do
	touch test_file${i}
	for j in `seq 1 ${i}`
	do
		if [ ${j} != 0 ]
		then
			echo "" >>test_file${i}	
		fi
	done
	#echo "." >>test_file${i}
done

touch test_file7
for i in `seq 1 3`
do
	echo "WIN?" >>test_file7
done

echo "salut, je kiff les '\n',\net toi?\n" >test_file8

echo "hey!\nc'est cadeau\n voila.\na\n.\n." >test_file9

for j in `seq 10 13`
do
		touch test_file${j}
		for k in `seq 0 $(( ${j} - 10 ))`
		do
			printf "WIN?" >>test_file${j}
		done
done

for j in `seq 14 17`
do
		touch test_file${j}
		for k in `seq 0 $(( ${j} - 14 ))`
		do
			if [ ${k} != $(( ${j} - 14 )) ]
			then
				printf "WIN?\n" >>test_file${j}
			else
				printf "WIN?" >>test_file${j}
			fi
		done
done
