# Magpie Notes

Magpie is a shell script which displays small snippets of text in your shell prompt. It's useful for reminders or keeping brief notes while you work.

![image](https://github.com/bkager/Magpie/assets/68086185/089fff15-35b9-426c-9ee1-292109ea8747)


Add or delete notes from the command line while you work, or open the notes file in a text editor to perform more complex editing. Your notes will refresh every time your prompt does.
~~~
GIF of note being added and deleted. 
~~~
![image](https://github.com/bkager/Magpie/assets/68086185/7cab2546-a129-4b4b-9e7b-a7f1325fe50a)

~~~
GIF of note being edited elsewhere and the prompt updating. 
~~~

Magpie is compatible with **bash/zsh** shells.

## Setup 1: Files

To use Magpie, download the script file (magpie-notes.sh) and the text file in which your notes will be kept (magpie-notes.txt) and place them in your preferred directory. They do not have to be kept in the same place. You may want to put the .txt file somewhere easy to access; while you can add/delete notes from the command line, it's also sometimes handy to open the text file directly in an editor.

## Setup 2: Configure Your Script File

Open your copy of magpie-notes.sh. On line 12, you'll see: 
```
# Location of text file
file='ABSOLUTE PATH TO YOUR NOTES FILE HERE'
```
Add the path to the location where you stored magpie-notes.txt: 
```
# Location of text file
file='/Users/britta/Desktop/magpie-notes.txt'
```

## Setup 3: Configure Your Prompt

**####### ADD BASH SECTION IF DIFFERENT #########**

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

alias magpie="/Users/britta/Desktop/magpie/magpie-notes-script.sh"
```
## Setup 4: Permissions

From the command line, type chmod +x \<path to your magpie-notes.sh file> to give the script permission to execute. 

# Usage

To add a note, type **magpie add "I'm a new note!"**
```
GIF of note added
```
To delete a note, type **magpie del \<line num>**:
```
GIF of note deleted
```
You can also delete a range: **magpie del 3-5**
```
GIF of note with range deleted
```
"Deleted" notes aren't actually lost--they're moved to the bottom of the file as a comment. You can see all current and deleted notes by opening the notes file in a text editor or by typing **magpie all**: 
```
SCREENSHOT of all notes being shown
```
To get rid of all your old notes, open the file in a text editor. Of if you want to entirely clear your file of all current and deleted notes, type **magpie clear**: 
```
GIF of note added
```
To see a quick summary of usage, including abbreviated forms of these commands, type **magpie help**. 
```
GIF of note added
```
