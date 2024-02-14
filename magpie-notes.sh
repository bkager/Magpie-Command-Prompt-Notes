#!/bin/bash

### VARIABLES

# Command text
command=$1

# Argument text
arg=$2

# Location of text file
file='ABSOLUTE PATH TO YOUR NOTES FILE HERE'


### VIEWING NOTES
### The program outputs all non-commented notes by default. The "magpie all" command outputs the contents of the entire notes file, including "deleted" (commented out) ntoes

if
  [ "$command" = all ]
then
 echo "All notes:
 "
 cat -n $file
 exit 0
fi


### ADDING NOTES
### If the a or add commands are used, add new text to the note. 

if 
  [ "$command" = a -o "$command" = add ]
  
then
  if
  	#an argument is given at $2 when the script is run
    [ -n "$arg" ]
  then
  	#the new note text includes everything typed after the "add" command
    shift 1
    newNote=$@
  else
  	#if new note text was not supplied as an argument, open a read prompt to capture it
    read -p "Add note: " newNote
  fi
  
# Find the line number of the last line not starting with #, and save it in variable $insertLine. A new note will be inserted on the line after this number. If there are no lines that do not start with #, a new note will be inserted at line 1.  
insertLine=$(cat -n $file | grep '^\s*\d\d*\s[^#]' | tail -1 | cut -f1)
insertLine=${insertLine:-1}

  if
    #If there were no uncommented lines (current notes),
    [ "$insertLine" = 1 ]
  then
    #insert the new note at line 1
    sed -i '' "1i\\
${newNote}
" $file
  else
    #If there were already uncommented lines (current notes), add the new note on the line below the last one
	echo $insertLine
    sed -i '' "${insertLine}a\\
${newNote}
" $file
  fi
  exit 0
fi


### DELETING SPECIFIC NOTES
### If the d/del/delete commands are used, comment out a line ###

if 
 [ "$command" = d -o "$command" = "del" -o "$command" = "delete" ]
then
  if
    #If line number(s) to delete were not supplied as an argument when the script was run,
    [ -z "$arg" ]
  then
    #read in line number(s)
    read -p 'Delete which line(s)? ' arg
  fi

  # Process the line number(s) into separate variables. The only/first number supplied is named $num1; if a range of numbers was given, the second number is named $num2.
  
  num1=$( echo $arg | cut -d'-' -f1 )
  num2=$( echo $arg | cut -d'-' -f2 )

  if
    #If a range of numbers was given (and so $num2 exists), 
    [ -n "$num2" ]
  then
    #delete the range of lines from $num1 to $num2
    sed -i '' -e "${num1},${num2}s/^/# /" -e "${num1},${num2}h" -e "${num1},${num2}d" -e '$G' -e '$a\
#' $file    
  else
    #If only one line number was given, delete the line at $num1
    sed -i '' -e "${num1}s/^/# /" -e "${num1}h" -e "${num1}d" -e '$G' -e '$a\
#' $file
  fi
  exit 0
fi


### DELETING ALL NOTES
### If the c/clear commands are used, permanently remove all notes. Unlike the "delete" command, this does not save notes as comments at the bottom of the file.
if 
  [ "$command" = c -o "$command" = "clear" ]
then
  # Open confirmation dialogue
  read -p "Fully delete all notes and reset note file?  " delete_conf
  if 
    [ "$delete_conf" = y -o "$delete_conf" = Y -o "$delete_conf" = yes -o "$delete_conf" = Yes ]
  then 
    echo "
### Lines preceded with # will not be printed ###
#" > $file
  fi
  exit 0
fi


### HELP FUNCTION
### If the  help/usage/h/u commands are used, print usage info

if [ "$command" = -h -o "$command" = "help" -o "$command" = "clear" ]
then
  echo "
***MAGPIE: USAGE NOTES***

Pattern: magpie command <optional arguments>

magpie 				: Output contents of notes.

magpie all			: Output contents of all notes, including 
				  \"deleted\" (commented out) notes.
				  
magpie help/usage/-h/-u 	: Display this help text.

magpie add/-a <'note'> 		: Add a new note. Follow the command
   magpie add		  	  with a string in quotes to enter
   magpie add \"Get milk\"	  it as a new note. If no argument
	   			  is given, a prompt will ask you 
	   	  		  to enter text.   	
	  	   	
   	
magpie del/-d <n | n-z>		: Delete a note. Follow the command 
   magpie del			  with a line number or a range of 
   magpie del 4			  line numbers separated by a - to 
   magpie del 2-4		  delete. If no number is given, a 
				  prompt will ask you to enter 
				  line numbers. Please note that the 
				  delete command does not actually 
				  delete text, but instead moves it 
				  to the end of the text as a 
				  comment. You can see notes you 
				  have deleted by opening the magpie.txt 
				  file in an editor or with the magpie all 
				  command.  

magpie clear/-c 		: Permanently delete all notes and 
   magpie clear			  return magpie file to a pristine state. 
				  Unlike the delete function, this does not 
				  save notes as comments. A confirmation 
				  dialogue will open. Reply y/Y/yes/Yes 
				  to clear all notes. 
	 
"
  exit 0
fi


### FINAL OUTPUT
### Output text of all notes not commented with a # symbol ###
### This text will display if the "magpie" command is used with no sub-commands; this is also what will show in the prompt. 

grep -n '^[^#]' $file
echo __________
exit 0
