#!/bin/bash

opt=$1
#text=$2
text="${@:2}"

file='/Users/britta/Desktop/memo-program/memos.txt'
preface='Reminders'

# cat -n /Users/britta/Desktop/memo-program/memos.txt



### If the -a or add options are used, add new text to the note. 

if 
  [ "$opt" = -a -o "$opt" = add ]
then
  read -p "Add note: " newNote
  echo $newNote >> $file
  echo "HERE'S YOUR NEW TEXT"
  sed -n '/^[^#]/ p' $file | wc -l |
  
  echo "END OF TEST"
fi

# Get all the lines not starting with #
# Insert new note at line after last one





### Output text of memo that is not commented with a # symbol ###

echo %B${preface}:%b
grep '^[^#]' /Users/britta/Desktop/memo-program/memos.txt
echo __________




### If the -d <num> option is used, comment out that line ###

#if 
# [ $opt = -d ]
#then
#  echo d option used
#  sed -i 's/^/# /' $file
#  sed -i $text

#fi
