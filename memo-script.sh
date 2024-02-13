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
export preface

### VIEWING NOTES
### The program outputs all non-commented notes by default. This option outputs the contents of the entire notes file, including "deleted" (commented out) ntoes

if
  [ "$opt" = all ]
then
 echo "All notes:
 "
 cat -n $file
 exit 0
fi


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
insertLine=$(cat -n memos.txt | grep '^\s\s\s\s\s\d\d*\s[^#]' | tail -1 | cut -f1)
insertLine=${insertLine:-1}
  if
    [ "$insertLine" = 1 ]
  then
    sed -i '' "1i\\
${newNote}
" $file
  else
    sed -i '' "${insertLine}a\\
${newNote}
" $file
  fi


exit 0
fi



### DELETING NOTES
### If the -d/del/delete option is used, comment out a line ###

if 
 [ "$opt" = -d -o "$opt" = "del" -o "$opt" = "delete" ]
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
  # Exit script
  exit 0
fi

### DELETING ALL NOTES
### If the -c/clear option is used, permanently remove all notes
if 
  [ "$opt" = -c -o "$opt" = "clear" ]
then
  read -p "Fully delete all notes? " deleteConf
  if 
    [ "$deleteConf" = y -o "$deleteConf" = Y -o "$deleteConf" = yes -o "$deleteConf" = Yes ]
  then 
    echo "
### Lines preceded with # will not be printed ###
#" > $file
  fi
  exit 0
fi



### HELP FUNCTION
### If the  help/usage/h/u options are used, print usage info

if [ "$opt" = -h -o "$opt" = "help" -o "$opt" = "clear" ]
then
  echo "
***MEMO: USAGE NOTES***

Pattern: memo command <optional arguments>

memo 				: Output contents of notes.

memo all			: Output contents of all notes, including 
				  \"deleted\" (commented out) notes.
				  
memo help/usage/-h/-u 		: Display this help text.

memo add/-a <'note'> 		: Add a new note. Follow the command
   memo add		  	  with a string in quotes to enter
   memo add \"Get milk\"		  it as a new note. If no argument
	   			  is given, a prompt will ask you 
	   	  		  to enter text.   	
	  	   	
   	
memo del/-d <n | n-z>		: Delete a note. Follow the command 
   memo del			  with a line number or a range of 
   memo del 4			  line numbers separated by a - to 
   memo del 2-4			  delete. If no number is given, a 
				  prompt will ask you to enter 
				  line numbers. Please note that the 
				  delete option does not actually 
				  delete text, but instead moves it 
				  to the end of the text as a 
				  comment. You can see notes you 
				  have deleted by opening the memo.txt 
				  file in an editor or with the memo all 
				  command.  

memo clear/-c 			: Permanently delete all notes and 
   memo clear			  return memo file to a pristine state. 
				  Unlike the delete function, this does not 
				  save notes as comments. A confirmation 
				  dialogue will open. Reply y/Y/yes/Yes 
				  to clear all notes. 
	 
"
  exit 0
fi


### FINAL OUTPUT
### Output text of all notes not commented with a # symbol ###

#echo %B${preface}:%b
grep -n '^[^#]' /Users/britta/Desktop/memo-program/memos.txt
echo __________
exit 0
