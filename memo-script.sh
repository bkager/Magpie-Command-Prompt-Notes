#!/bin/bash

### VARIABLES

# Option text
opt=$1

# Argument text
arg=$2


# File where text of memos is found
file='/Users/britta/Desktop/memo-program/memos.txt'

# Text the user wants placed in front of their notes
preface='Reminders'



### ADDING NOTES
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



### DELETING NOTES
### If the -d option is used, comment out a line ###

if 
 [ "$opt" = -d -o "$opt" = "del" ]
then
  if 
    [ -n "$arg" ]
  then
 	lineToDel=$arg
  else 	
    read -p "Delete which line? " lineToDel
  fi 
    sed -i '' -e "${lineToDel}s/^/# /" -e "${lineToDel}h" -e "${lineToDel}d" -e '$G' -e '$a\
#' $file
fi

### If the -c or clear option is used, permanently remove all notes
if 
  [ "$opt" = -c -o "$opt" = "clear" ]
then
  read -p "Fully delete all notes? " deleteConf
  if 
    [ "$deleteConf" = yes -o "$deleteConf" = y -o "$deleteConf" = Y ]
  then 
    echo "
### Lines preceded with # will not be printed ###
#" > $file
  fi
fi

### If number is passed in with -d or del arg, delete that line without read dialogue
### If some text is passed in with -d or del arg, match it to line texts and delete that line with either read dialogue or without
### Allow users to delete all notes with arg: clear all


### If -o or option arg is used, open option menu to change: 
### Preface on/of
### What preface is
### line numbers
### If backup file is created







### FINAL OUTPUT
### Output text of memo that is not commented with a # symbol ###

echo %B${preface}:%b
grep '^[^#]' /Users/britta/Desktop/memo-program/memos.txt
echo __________
