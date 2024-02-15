# Magpie Notes

Magpie is a shell script which displays small snippets of text in your shell prompt. It's useful for reminders or keeping brief notes while you work.

![image](https://github.com/bkager/Magpie/assets/68086185/089fff15-35b9-426c-9ee1-292109ea8747)

Add or delete notes from the command line while you work, or open the notes file in a text editor to perform more complex editing. Your notes will refresh every time your prompt does.

![image](https://github.com/bkager/Magpie/assets/68086185/7cab2546-a129-4b4b-9e7b-a7f1325fe50a)

Magpie is compatible with **bash/zsh** shells.

## Setup 1: Files

To use Magpie, download the script file (magpie-notes.sh) and the text file in which your notes will be kept (magpie-notes.txt) and place them in your preferred directory. They do not have to be kept in the same place. You may want to put the .txt file somewhere easy to access; while you can add/delete notes from the command line, it's also sometimes handy to open the text file directly in an editor.

## Setup 2: Configure Your Script File

Open your copy of magpie-notes.sh. On line 12, add the path to the location where you saved magpie-notes.txt: 
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

To add a note, type **magpie add "Whatever you want to type"**

![image](https://github.com/bkager/Magpie/assets/68086185/58a06b9e-86ef-4ec4-b4a5-4c958766222b)

To delete a note, type **magpie del \<line num>**:

![image](https://github.com/bkager/Magpie/assets/68086185/a8618f62-675a-4d0a-83d2-6928905d7be2)

You can also delete a range: **magpie del 3-5**

![image](https://github.com/bkager/Magpie/assets/68086185/bbd8170d-ae57-4291-acca-df9df6dd2901)

"Deleted" notes aren't actually lost--they're moved to the bottom of the file as a comment. You can see all current and deleted notes by opening the notes file in a text editor or by typing **magpie all**: 

![image](https://github.com/bkager/Magpie/assets/68086185/c13622f0-b502-4831-a82d-c2e11715b217)

To get rid of all your old notes, open the file in a text editor. Of if you want to entirely clear your file of all current and deleted notes, type **magpie clear**: 

![image](https://github.com/bkager/Magpie/assets/68086185/b4366602-5be7-4930-a4fc-832928500665)

To see a quick summary of usage, including abbreviated forms of these commands, type **magpie help**. 

![image](https://github.com/bkager/Magpie/assets/68086185/e4e39a37-75bd-400c-a5e5-91952d49a1c4)


