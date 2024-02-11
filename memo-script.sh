#!/bin/bash

# Option text
opt=$1

# Text passed in after option; not using currently for -a option
#text=$2
text="${@:2}"

# File where txt of memos is found
file='/Users/britta/Desktop/memo-program/memos.txt'

# Text the user wants placed in front of their notes
preface='Reminders'

# Earlier way to display memo text; discard
# cat -n /Users/britta/Desktop/memo-program/memos.txt



### If the -a or add options are used, add new text to the note. 

if 
  [ "$opt" = -a -o "$opt" = add ]
then
  read -p "Add note: " newNote
  
# Get only the lines not starting with # and add a new note to the bottom
  insertLine=$(cat -n memos.txt | grep '^\s\s\s\s\s\d\d*\s[^#]' | tail -1 | cut -f 1)
  echo $insertLine
  sed -i '' "${insertLine}a\\
${newNote}
" $file
fi

### If the -d <num> option is used, comment out that line ###

if 
 [ "$opt" = -d -o "$opt" = "del" ]
then
  read -p "Delete which line? " lineToDel
  sed -i '' "${lineToDel}s/^/# /" $file
 # sed -i '' $text

fi




### Output text of memo that is not commented with a # symbol ###

echo %B${preface}:%b
grep -n '^[^#]' /Users/britta/Desktop/memo-program/memos.txt
echo __________
