# Magpie: Notes in the command prompt

Magpie is a shell script compatible with **bash/zsh** which displays small snippets of text in your shell prompt. It's useful for reminders or for keeping brief notes while you work.

![Screenshot of a command prompt with three numbered notes following the usual prompt text, each on a separate line. An example is "2: Add readme"](https://github.com/bkager/Magpie/assets/68086185/089fff15-35b9-426c-9ee1-292109ea8747)

Add or delete notes from the command line while you work, or open the notes file in a text editor to perform more complex editing. Your notes will refresh every time your prompt does.

![Screenshot showing three a user typing "magpie add 'Buy eggs'. The note is added to the command prompt as line 3. The user then types "magpie del 3", and the note has been removed from the prompt the next time it appears.](https://github.com/bkager/Magpie/assets/68086185/7cab2546-a129-4b4b-9e7b-a7f1325fe50a)


## Setup 1: Files

To use Magpie, download the script file (magpie-notes.sh) and the text file in which your notes will be kept (magpie-notes.txt) and place them in your preferred directory. They do not have to be kept in the same place. You may want to put the .txt file somewhere easy to access; while you can add/delete notes from the command line, it's also sometimes handy to open the text file directly in an editor.

## Setup 2: Configure Your Script File

Open your copy of magpie-notes.sh. On line 12, add the path to the location where you saved magpie-notes.txt: 
```
# Location of text file
file='/Users/myname/Desktop/magpie-notes.txt'
```

## Setup 3: Configure Your Prompt

### Bash Setup
Place the following line in your shell's config file (**.bashrc**), adding the path to your copy of magpie-notes.sh:
```
  alias magpie="ABSOLUTE_PATH_TO_THE_SCRIPTFILE"
```
Add to end of PS1 value in **.bashrc** file: 
```
  "\n$(magpie)\n"
```

Example .bashrc file: 
```
alias magpie="/Users/myname/Desktop/magpie/magpie-notes-script.sh"

PS1='\n\u@\w \d \T\n"$(magpie)"\n'
```
Note that you need to include the double quotes!

Also make sure you have ```source ~/.bashrc``` somewhere in your .bash_profile. 

### Zsh Setup

Place the following lines in your shell's config file (**.zshrc**), adding the path to your copy of magpie-notes.sh:
```
  setopt PROMPT_SUBST
  NEWLINE=$'\n'
  alias magpie="ABSOLUTE_PATH_TO_THE_SCRIPTFILE"
```
Add to end of PS1 value in **.zshrc** file: 
```
  ${NEWLINE}`magpie`
```

Example .zshrc file: 
```
setopt PROMPT_SUBST

NEWLINE=$'\n'

PS1='%d (%D{%A, %B %e})${NEWLINE}`magpie`'

alias magpie="/Users/myname/Desktop/magpie/magpie-notes-script.sh"
```
## Setup 4: Permissions

From the command line, type this to give the script permission to execute:
```
chmod +x \<PATH TO YOUR MAGPIE-NOTES.SH FILE>
```

# Usage

To add a note, type **magpie add "Whatever you want to type"**

![Screenshot showing the user type "magpie add "Add license". It is added to the command prompt as a new line.](https://github.com/bkager/Magpie/assets/68086185/58a06b9e-86ef-4ec4-b4a5-4c958766222b)

To delete a note, type **magpie del \<line num>**:

![Screenshot showing the user type "magpie del 3". The note numbered 3 is removed.](https://github.com/bkager/Magpie/assets/68086185/a8618f62-675a-4d0a-83d2-6928905d7be2)

You can also delete a range: **magpie del 3-5**

![Screenshot showing the user type "magpie del 2-6". The notes on those line numbers are removed.](https://github.com/bkager/Magpie/assets/68086185/bbd8170d-ae57-4291-acca-df9df6dd2901)

"Deleted" notes aren't fully gone--they're moved to the bottom of the file as a comment. You can see all current and deleted notes by opening the notes file in a text editor or by typing **magpie all**: 

![Screenshot showing the user type "magpie all". The output of the command is the contents of the magpie text file. Active notes are at the top. Below them, a line reads "### Lines preceded with a # will not be printed ###". Below it, each line is numbered, followed by a #, followed by the text of previously deleted notes.](https://github.com/bkager/Magpie/assets/68086185/c13622f0-b502-4831-a82d-c2e11715b217)

To get rid of all your old notes, open the file in a text editor. Or if you want to entirely clear your file of all current and deleted notes and start over, type **magpie clear**: 

![Screenshot showing the user type "magpie clear". A confirmation dialogue appears. When the user types "y" all notes are removed from the command prompt and the text file.](https://github.com/bkager/Magpie/assets/68086185/b4366602-5be7-4930-a4fc-832928500665)

To see a quick summary of usage, including abbreviated forms of these commands, type **magpie help**. 

![Screenshot showing a sample of the help output when a user types "magpie help".](https://github.com/bkager/Magpie/assets/68086185/90ed2270-5086-4f45-9c1d-e6bdd009b696)

