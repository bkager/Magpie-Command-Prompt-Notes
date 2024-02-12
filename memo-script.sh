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
  if
    [ -n "$arg" ]
  then
    shift 1
    newNote=$@
  else
    read -p "Add note: " newNote
  fi
# Get only the lines not starting with # and add a new note to the bottom
insertLine=$(cat -n memos.txt | grep '^\s\s\s\s\s\d\d*\s[^#]' | tail -1 | cut -f 1)
sed -i '' "${insertLine}a\\
${newNote}
" $file
exit 0
fi



### DELETING NOTES
### If the -d option is used, comment out a line ###

### FLOW of this: 
# If there is no arg, get an arg
# Process the received arg into 1-2 variables
# If there is only one arg, delete that line
# If there is a second arg, delete a range of lines 



if 
 [ "$opt" = -d -o "$opt" = "del" ]

 
then

  if
    #there is no arg
    [ -z "$arg" ]
  then
    #read in arg
    read -p "Delete which line? " arg
  fi

  # You now have an arg whether one was originally passed in or not. 
  # Process the arg into variables.
  
  num1=$( echo $arg | cut -d'-' -f1 )
  num2=$( echo $arg | cut -d'-' -f2 )

  if
    #there is a second var
    [ -n "$num2" ]
  then
    #delete a range of lines
    sed -i '' -e "${num1},${num2}s/^/# /" -e "${num1},${num2}h" -e "${num1},${num2}d" -e '$G' -e '$a\
#' $file    
  else
    #delete the one line
    sed -i '' -e "${num1}s/^/# /" -e "${num1}h" -e "${num1}d" -e '$G' -e '$a\
#' $file
  fi



  
exit 0
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
  exit 0
fi


### If some text is passed in with -d or del arg, match it to line texts and delete that line with either read dialogue or without
### Allow users to delete all notes with arg: clear all


### If -o or option arg is used, open option menu to change: 
### Preface on/of
### What preface is
### line numbers
### If backup file is created

### Add help function: invoke with args help, usage, -h, -u





### FINAL OUTPUT
### Output text of memo that is not commented with a # symbol ###

echo %B${preface}:%b
grep -n '^[^#]' /Users/britta/Desktop/memo-program/memos.txt
echo __________
exit 0
