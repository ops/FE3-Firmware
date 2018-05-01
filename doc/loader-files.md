# Final Expansion Documentation - LOADER files

Original German by Diddl

Translated by Vic20-Ian

Edited by ops



## The purpose of the Loader files

The loader file is needed by FE3 Disk Loader which always looking for the file
"LOADER" in the current directory. Disk Loader interprets these script files
saved in the form of VIC Basic prg files but not actually executable Basic
Programs.

Using these scripts you can select and easily start any games and / or programs
with no computer skills - once you have set them up or downloaded them.

Once the FE3 Disk Loader can load a program it can also be added to the FE3
Flash Rom. The Cart Utilities (F6) Flash Program (F3) makes use of the Loader
scripts to package the files and commands into an executable block of code
before flashing to the rom.

## Structure of the file "LOADER"

The LOADER file consists of one or several sections. Each section is presented
as a menu item in Diskloader. A section consists of:

- a name : each section begins with a name in the menu displayed in Diskloader
- one or more instructions
- comment lines may be added optionally.

The section name will begin and end simply with a quotation mark ("). The name
can be up to 20 characters and may include any special characters. If the name
is longer than 20 characters, Disk Loader shows only the first 20. Control
characters are ignored.

The instructions in a section are performed when the user activates the menu
item in Disk Loader by pressing the RETURN key or the joystick FIRE button.
Instruction lines always begin with a plus (+) sign.

The sequence of instructions will be chosen by Disk Loader as follows:
Diskloader always executes LOAD instructions first, then BLK and IO, after
this it executes RUN, SYS or RESET commands. The order in the script is only
relevant for commands of the same sub type e.g. multiple LOAD commands.

The optional comment lines begin with a colon (:). The comment line can be
blank (Section divider) or contain any text strings. A comment line does not
end the section. Comment lines are optional and can therefore be omitted
entirely.

A section ends with the end of the script file or the beginning of a new
section.

Instructions

Instruction lines always start with a plus sign (+). The following statements
are recognized by Disk Loader and interpreted:

- Load statement : Loads a file from a floppy disk or SD
- Disk Command : Sends a command to the SD2IEC or to a floppy.
- BLK, BLKP, BLKD : Instructions for configuring the FE3 hardware - block
write protect or disable.
- NOIO : Instructions for configuring the hardware FE3 – Hide FE3 IO registers.
- RESET : Instruction to restart the VC-20 (Soft Reset)
- SYS : Starts a machine code program at the given address (in hexadecimal!)
- RUN : Starts a BASIC program
- RELOAD: Restart command to the File Loader (runs the Loader script in the
current directory)

The Load Statement loads a file from the SD card or from a floppy. Several
load instructions can be sequenced if for example games with several parts
exist. In the simplest case the statement can consist of only one file name.
The file name consists of up to 16 characters and is enclosed in quotation
marks.

An optional type can be specified and appended to the load command. File types
are B (BASIC), P (PROGRAM) and C (cartridge). These correspond to the secondary
address (0,1,2) of the modified LOAD command in FE3 Wedge.

The file type BASIC is automatically always loaded at the address where the
BASIC memory starts (secondary address 0). This address may vary depending on
memory configuration.

The file type PROGRAM is always loaded at the address that is contained in the
file (the first two bytes). This corresponds to a LOAD with secondary
address 1. The load address can optionally be overridden - See - optional load
address.

The file type CARTRIDGE is for files without a load address. These files are
often recognised by the exact file size of 4K, 8K or 16K. This file type
requires always an indication of the load address!

The load statement may also have an optional load address appended. For file
type C, the load address is always required. The load address must always be
hexadecimal, starting with a $ sign.

The load commands are executed in the order given. If you intend to load
something into the cassette buffer from $330 onwards, this must be the last
section! This is because the Disk Loader uses this area of memory.

Examples of load commands:
```
+ "MOONPATROL"
+ "EXBASIC2",C,$A000
+ "AUSTRO COMP",B
+ "VICMON",P,$3000
```

A Disk Command starts with the AT sign (@ ) followed by the actual command in
quotes. You can send any possible commands to the target device (SD2IEC or
floppy) provided the device understands the command.

The main application of the Disk Command may be to change the current directory
or the current disk image (D64). We can comfortably navigate the SD card this
way. You do not have to have all the games in a single huge list it can be
arranged as you wish.

As stated any disk command is possible. You can for example erase a high score
table with an "S" command or a high score table could be saved by the C (Copy)
or R (Rename). This is limited only by your imagination.

Disk Commands can be used before or after a Load command.

The configuration of the FE3 is only necessary for the specific games and
programs. If a game or program runs without running a configuration you can do
without these instructions.

There are games and programs that do not run by normal load and start. The
program does not find the necessary environment and can / will therefore not
run. By configuring the hardware, FE3 can simulate every possible memory
expansion hardware and run every known program except for those which require
very specific hardware modules e.g. 80 character card, IEEE-488 card,
RS-232/Modem cards etc.

The commands BLK, BLKD and BLKP configure the memory. The block numbers can
follow the command in any order: 0,1,2,3,5. All five memory blocks are enabled
by default and must be turned off to get smaller or unexpanded memory
configurations.

The block numbers correspond to the physical blocks of the VIC-20:
```
0 = Block 0 ($0400-$0FFF)
1 = Block 1 ($2000-$3FFF)
2 = Block 2 ($4000-$5FFF)
3 = Block 3 ($6000-$7FFF)
5 = Block 5 ($A000-$BFFF)
```

The blocks can be disabled individually (BLKD) and protected against
overwrite (BLK or BLKP).

Inactive blocks are quasi-non existent. The FE3 acts like it is not populated
in the corresponding range of addresses. Another cartridge could be used with
FE3 in a multi slot expansion in the address blocks that have been disabled.

Blocks with write protection act like a ROM or EPROM. These blocks can only be
read from, write commands are ignored.

The command NOIO hides the registers of FE3. After this is set, further
configuration of the FE3 is no longer possible and the corresponding IO area is
free. A hardware reset puts the FE3 back to the original state and allows
reconfiguration.

Examples of configurations:
```
+BLK 1,3
+BLKD 0,1,2,3
+BLKP 0,1,2,3,5
+NOIO
```

Loaded games or programs must be started, the commands RESET, RUN and SYS are
available to do this. One of the three commands is used depending on the
requirements of the program.

After the Disk Command to change the directory or the disk image, the command
RELOAD must be used. In the new directory or the new D64 Image is another
LOADER file that must be loaded by the new Disk Loader.

Without the RELOAD command Disk Loader works with the wrong file and thus the
wrong LOADER instructions. The statements can not be executed because for
example, the file to load is longer accessible in the directory.

Example
```
10 "HW Demo unexpanded"
20 +"hello world",b
30 +blk 0,1,2,3,5
40 +run
50 :
60 "HW Demo 3K"
70 +"hello world",b
80 +blk 1,2,3,5
90 +run
100 :
110 "HW Demo 8K"
120 +"hello world",b
130 +blk 0,2,3,5
140 +run
150 :
160 "HW Demo 16K"
170 +"hello world",b
180 +blk 0,3,5
190 +run
200 :
210 "HW Demo 24K +8 +3"
220 +"hello world",b
230 : no blk command
240 +run
250 :
```
