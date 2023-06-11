#!/bin/bash
cd "/dev/shm/"
AllSubsFile="subreddit_list.txt"
AllSubsLines=$(cat $AllSubsFile | sed '/^\s*$/d' )
#LineCount=(cat "$AllSubsFile" | sed '/^\s*$/d' | wc -l)

i=0
for Subreddit in $AllSubsLines
do
	if [[ "$Subreddit" == "r/"* ]]; then
		curl https://old.reddit.com/$Subreddit -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0" --output - | grep "over18" | sed 's/^.*%2Fr%2F\(.*\)<.*/r\/\1/' >> "nsfwonly.txt"
		echo "$Subreddit"
		sleep 1
	else
		echo "$Subreddit" >> "nsfwonly.txt"
	fi
	
	((i++))
#	echo "$i/$LineCount"
	echo "$i"
done