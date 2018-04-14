; VIC 20 Final Expansion Cartridge - Revision 013
; Thomas Winkler - May 3, 2009

; Thanks to Leif Bloomquist
; Thanks to everyone on the Denial forums
; http://www.sleepingelephant.com/denial/

  processor 6502                        ;VIC20



CAS_BUF     = $033c                     ;CASSETTE BUFFER
F_IO        = CAS_BUF +0                ;IO FLAG
F_WE        = CAS_BUF +1                ;WEDGE FLAG
F_CURDEV    = CAS_BUF +2                ;WEDGE FLAG

MY_WEDGE_LO = CAS_BUF +4                ;WEDGE LOW ADDRESS



FLGCOM  = $08


CHRPTR  = $7a                           ;Char Pointer
PT1     = $22                           ;Pointer
PT2     = $24                           ;Pointer
PT3     = $14                           ;Pointer

FAC     = $61

C_LINE  = $d1                           ;pointer current line char RAM
C_COLP  = $f3                           ;pointer current line color RAM

C_CTRL  = $d4                           ;control mode

C_ROW   = $d6                           ;cursor row
C_COL   = $d3                           ;cursor column
C_CHR   = $d7                           ;cuurent char


BASSTRT = $2B                           ;BASIC START
BASVAR  = $2d                           ;BASIC VARS
BASARR  = $2f                           ;BASIC ARRAYS
BASAEND = $31                           ;BASIC ARRAYS END
BASSTR  = $33                           ;BASIC STRINGS
STRPTR  = $35                           ;STRING POINTER
BASEND  = $37                           ;BASIC END

SAVESTART = $c1
LOADPTR   = $c3
LOADSTART = $ac
LOADEND   = $ae

KEYANZ  = $c6


IECSTAT  = $90

LEN_FNAM = $b7
PTR_FNAM = $bb

SY_VERIFY   = $93
SY_STATUS   = $90
SY_SA       = $b9
SY_DN       = $ba
SY_FN       = $b8



CHRGET  = $0073                      ;GET NEXT CHAR
CHRGOT  = $0079                      ;GET LAST CHAR

BIP     = $0200                      ;BASIC Input Buffer 88 Bytes
CAS_BUF = 828                        ;Kassetten Buffer

IO_FINAL = $9c02                     ;FINAL EXPANSION REGISTER 1 (39938,39939)

FEMOD_START = $00                    ;MODE START
FEMOD_ROM   = $40                    ;MODE EEPROM (READ EEPROM, WRITE RAM)
FEMOD_ROM_P = $20                    ;MODE FLASH EEPROM (READ EEPROM, WRITE EEPROM)
FEMOD_RAM   = $80                    ;MODE SRAM (SRAM 40KB, BANK 0 and BANK 1)
FEMOD_RAM2  = $A0                    ;MODE BIG SRAM (SRAM 512KB, BANK 0 TO 15)


SOFT_RESET = $fd22                   ;SOFT RESET
CURSOR_POS = $e50a

BSOUT      = $ffd2
GETIN      = $ffe4



OPEN    = $ffc0     ; Open Vector [F40A] Open File
                    ; Preparing: SETLFS, SETNAM
CLOSE   = $ffc3     ; Close Vector [F34A] Close File
SETLFS  = $ffba     ; Set Logical File Parameters
SETNAM  = $ffbd     ; Set Filename / Command
LOAD    = $ffd5     ; Load RAM From Device
;CHROUT  = $ffd2     ; Output Vector, chrout [F27A] Output One Character
                    ; Preparing: OPEN, CHKOUT (not for video output)
CHKIN   = $ffc6     ; Set Input [F2C7] Set Input Device
                    ; Preparing: OPEN
CHRIN   = $ffcf     ; Input Vector, chrin [F20E] Input a byte
                    ; Preparing: OPEN, CHKIN
PRNSTR  = $cb1e     ; print string in A/Y, 0 terminated
PRNINT  = $ddcd     ; print integer in X/A
PRNERR  = $c437     ; print basic error message in X = (from $01 to $1e)
BASSFT  = $e467     ; BASIC Warm Restart [RUNSTOP-RESTORE]
CHRGETSUB = $0079   ; CHRGET subroutine return point after modify
MOVMEM  = $c3bf     ; Move memory from (start($5f-$60)/end+1($5a-$5b)) to (end+1($58-$59))
GETIN   = $ffe4     ; Get a byte From Keyboad or serial device
FRMEVL  = $cd9e     ; Evaluate Expression in Text
RESET   = $fd22     ; Reset Vic
READY   = $c474     ; Restart BASIC
CINT1   = $e518     ; Initialize I/O
CLRSCN  = $e55f     ; clear screen

; TurboLoad
secnd	= $ff93	    ; send secondary address for LISTEN
ciout	= $ffa8     ; write serial data
unlsn	= $ffae	    ; send UNLISTEN command
listn	= $ffb1	    ; send LISTEN command
fa	= $ba	    ; Current Device Number

CLRCH   = $ffcc     ; Restore Default I/O status

dir_current_device = $ba
dir_current_curposline = $d3
dir_status_word_st = $90
dir_reverse_flag = $c7
dir_basicstartaddress_lo = $2b
dir_basicstartaddress_hi = $2c

dir_basiclinenumber_hi = $3a
dir_index1_lo = $22
dir_index1_hi = $23
dir_basicpointer_lo = $7a
dir_basicpointer_hi = $7b
dir_tapecharparity = $9b ;unmovable ???
dir_current_key = $c5
dir_chars_in_key_buffer = $c6
dir_output_control = $9d     ;Direct=$80/RUN=0
dir_char_under_cursor = $ce

; TurboLoad
fl_status_word_st = $90
fl_load_verify_flag = $93      ; Load=0 else Verify
fl_current_device = $ba
fl_char_in_file_name = $b7
fl_filename_pointer_lo = $bb   
fl_filename_pointer_hi = $bc
fl_current_sa = $b9
fl_current_logical_file = $b8
fl_endprogram_address_lo = $ae ; is used as temp pointer of code
fl_endprogram_address_hi = $af ; to send to the drive too
fl_filename_pointer = $bb      ; $BB-$BC Pointer: to file name
fl_output_control = $9d        ; Direct=$80/RUN=0 

fl_basicstartaddress_lo = $2b
fl_basicstartaddress_hi = $2c

; ----- other zero page locations (movable) ------

dir_old_key = $fd
dir_command_set = $fe

; TurboLoad
; $f7-$fa is RS232 pointers, $fb-$fe is unused
iec0d1a = $f7
iec0d1b = $f8
iec1d1a = $f9
iec1d1b = $fa

store   = $fc

mwcmd = $f7   ;f7-fc used first to temp store SETLFS & SETNAM parameters
              ;      and after to send the "M-W" command to the drive.
	      ;      Since these operations are made before the
	      ;      fastloading process i share the same location of
	      ;      iec0d1a,iec0d1b,iec1d1a,iec1d1b and store variables.
              ;      Used as temp value for loader start routine too.

; shared address because used with CTRL+F1/F3/F5/F7 
From_Lo    = $f7 ;FB        ;From address (lo-byte)
From_Hi    = $f8 ;FC        ;From address (hi-byte)
To_Lo      = $f9 ;FD        ;to address (lo-byte)
To_Hi      = $fa ;FE        ;ti address (hi-byte)

; **************** other page locations used ****************

; ----- used by the kernal (unmovable) ------
dir_shift_ctrl_cbm_flag = $028d
dir_keyboard_buffer = $0277 ;($0277-$0280)

dir_start_memory_hi = $282 ; Start of memory (hi-byte)
dir_top_memory_hi = $284   ; Top of memory (hi-byte)
dir_screen_mem_page = $288 ; Screen memory page start (hi-byte)


; **************** I/O constants ****************************

; TurboLoad
AMOUNT = $20	; amount of data bytes to transfer with one M-W command
ESCBYTE = $ef	; the escape char used in the transfers
RETRIES = 20	; amount of retries in reading a block

DEFAULT_DEVICE = 8	; Default device number

CheckByte = #214

iecport1 = $912c	;$dd00	;$912c
dato = 32		;32	;32
clko = 2		;16	;2
iecport2 = $911f	;$dd00	;$911f
atno = 128		;8	;128
clki = 1		;64	;1
dati = 2		;128	;2

; ***********************************************************************



  org $a000,0                           ;$A000   (Fill value=0)

; ==============================================================
; Startup
; ==============================================================
  dc.w START   ; Entry point for power up
  dc.w RESTORE ; Entry point for warm start (RESTORE)

CARTID
  dc.b "A0",$C3,$C2,$CD	; 'A0CBM' boot string



SY_RAMTAS  = $fd8d
;SY_RAMTAS2 = $fd9b
SY_INITVEC = $fd52
SY_INITIO1 = $fdf9
SY_INITIO2 = $e518

SY_INITVEC2 = $e45b ; Init Vectors
SY_BASRAM   = $e3a4 ; BASIC RAM
SY_INITMSG  = $e404 ; INIT Message (needed so keycheck routine below works)




START
  jsr SY_RAMTAS                         ; RAMTAS - Initialise System Constants
  jsr SY_INITVEC                        ; Init Vectors
  jsr SY_INITIO1                        ; Init I/O
  jsr SY_INITIO2                        ; Init I/O
  cli

  ;BASIC Init (Partial)
  jsr SY_INITVEC2                       ; Init Vectors
  jsr SY_BASRAM                         ; BASIC RAM
  jsr SY_INITMSG                        ; INIT Message (needed so keycheck routine below works)

  ; Force startup with device #8 (disk)
  lda #$08
  sta F_CURDEV
  bne START2


  org $a028                             ; - equals 41000 decimal, easy to remember!

JMPTABLE
  jmp HELP2                             ; sys 41000: Help sreen
  jmp MY_WEDGE_INIT                     ; sys 41003: Init Wedge
  jmp MOVE_WEDGE_0500                   ; sys 41006: Copy Wedge


COPYROM
  lda #FEMOD_ROM                        ;ROM
  ldx #0
  jsr UNLOCK_IO

  lda #$a0
  ldy #$00
  sta PT1 +1
  sty PT1
  ldx #32                               ; copy 32 pages
  ;ldy #0
CORO_1
  lda (PT1),y
  sta (PT1),y
  iny
  bne CORO_1
  inc PT1 +1
  dex
  bne CORO_1
  sty CARTID
  sty CARTID +1

  lda #FEMOD_RAM +$10                ; ALL RAM, PROTECT BLK-5
  sta IO_FINAL
  rts

INIT_CART
  lda #$6e                ; Blue Screen
  ;lda #$6d                 ; Blue Screen,green border
  ;lda #$6b                 ; Blue Screen, cyan border
  sta $900f                ; Screen Color
  rts


START2
  lda #"."
  sta F_IO
  lda #"X"
  sta F_WE

CHECK
; Check which control keys are pressed.
  lda $028d

; if C=, go straight to BASIC.
  cmp #$02
  bne SHIFT
  jmp BASIC

; if SHIFT, go straight to BASIC with wedge enabled.
SHIFT
  cmp #$01
  beq STARTWEDGE_H

  jsr COPYROM

; ==============================================================
; Default Startup - show init screen
; ==============================================================
SSCREEN
  jsr INIT_CART

  lda #<STARTUPSCREEN
  ldy #>STARTUPSCREEN
  jsr STROUT

SETUPTIMEOUT
  ;Initialize Timer
  ldy $a1 ; part of TI clock, updated every 256/60 = 4.2 seconds
  iny
  iny
  iny     ;Jump ahead three 'ticks' = 12.6 seconds

; Check for timeout
TIMEOUT
  cpy $a1
  bne KEYS

STARTWEDGE_H
  jmp STARTWEDGE

; Check keys
KEYS
  jsr GETIN
  cmp #$00
  beq TIMEOUT

DENIAL
  cmp #$44   ;D
  bne F1
  jsr CREDITS
  jmp WAITSPACE_2

F1
  cmp #$85  ;F1
  bne DEL
  jmp RAMMENU

DEL
  cmp #$14  ;DEL
  bne F2
  jmp STARTWEDGE

F2
  cmp #$89  ;F2
  bne F3
  ;jsr INIT_DEF
  jsr INIT_BASIC
  jsr SY_INITMSG                        ; INIT Message
  jmp DO_UNNEW

F3
  cmp #$86  ;F3
  bne F4
  jmp DLOADER

F4
  cmp #$8a  ;F4
  bne F5
  jmp HELP

F5
  cmp #$87  ;F5
  bne PLUS
  ;jmp CARTLOADER

PLUS
  cmp #$2b  ;+
  bne MINUS
  jmp INCDRIVE

MINUS
  cmp #$2D  ;-
  bne F7
  jmp DECDRIVE

F7
  cmp #$88  ;F7
  bne F8
  jmp STARTWEDGE

F8
  cmp #$8C
  bne TIMEOUT
  jmp BASIC


; ==============================================================
; Start Wedge and return to BASIC
; ==============================================================
INIT_BASIC
  jsr SY_INITVEC                        ; Init Vectors
  jsr SY_INITIO1                        ; Init I/O
  jsr SY_INITIO2                        ; Init I/O
  cli

;  lda #$06
;  sta $0286 ; Restore blue text

  ;BASIC Init (Partial)
  jsr SY_INITVEC2                       ; Init Vectors
  jmp SY_BASRAM                         ; BASIC RAM

  ;Clear keyboard buffer
;  lda #$00
;  sta KEYANZ

  ; Restore normal startup colors
INIT_DEF
  lda #$1b
  sta $900f

  ; Restore normal startup colors
  lda #FONT1
  jmp CHROUT


BASIC_WARM = $e467


STARTWEDGE
  sei
  jsr SY_RAMTAS                         ; RAMTAS - Initialise System Constants
  jsr INIT_BASIC
  jsr MY_WEDGE_INIT

STARTWEDGE2
  jsr SY_INITMSG                        ; INIT Message

  lda #<WEDGEMESSAGE1b
  ldy #>WEDGEMESSAGE1b
  jsr STROUT

  lda PTR_INPUT_LOOP +1

STWE_3
  jsr HEX2
  lda #<WEDGEMESSAGE2
  ldy #>WEDGEMESSAGE2
  jsr STROUT
  jmp BASIC2


; ==============================================================
; Wedge Message
; ==============================================================

;WEDGEMESSAGE1a
;  dc.b $11, $1C, "EASYWEDGE ($", 0

WEDGEMESSAGE2
  dc.b ")",$11, $1F, 0


; ==============================================================
; Return to BASIC
; ==============================================================
BASIC
  sei
  jsr SY_RAMTAS                         ; RAMTAS - Initialise System Constants
  jsr INIT_BASIC
BASIC1
  jsr SY_INITMSG                        ; INIT Message
BASIC2
  ;lda #0
  ;jsr SY_RAMTAS2                         ;calculate RAM size

  ; Complete BASIC Warm Start (since init is done above)
  jmp BASIC_WARM





; ==============================================================
; Handle the RESTORE key
; ==============================================================
RESTORE
  jmp $fec7   ; Continue as if no cartridge installed

;Don't use $fea9!
;$fea9 goes to ($0318) which goes to $fead which ends up with a jmp ($a002)...



; ==============================================================
; List all the Denial Helpers
; ==============================================================
CREDITS
  lda #$1e
  sta $900f ; Screen colors
  lda #<THECREDITS
  ldy #>THECREDITS
  jmp STROUT

; ==============================================================
; Wait here for space bar or F8
; ==============================================================
WAITSPACE_2
  jsr WAITSPACE
  jmp SSCREEN


WAITSPACE
  jsr $ffe4
  cmp #$8C                              ;F8
  beq WASP_1
  cmp #$20                              ;SPACE
  bne WAITSPACE
WASP_1
  rts


; ==============================================================
; Help Screen
; ==============================================================
HELP
  jsr HELP2
  jmp WAITSPACE_2


HELP2
  lda #<HELPSCREEN3
  ldy #>HELPSCREEN3
  jmp STROUT


; ==============================================================
; Increment/Decrement the drive#
; ==============================================================

INCDRIVE
  inc F_CURDEV
  jmp CHECKDRIVE

DECDRIVE
  dec F_CURDEV

; Make sure drive is valid - 8 to 15
CHECKDRIVE
  clc
CHECKLOW
  lda F_CURDEV
  sbc #$08
  bcs CHECKHIGH  
  lda #$08
  sta F_CURDEV
CHECKHIGH
  clc
  lda F_CURDEV
  sbc #$0F
  bcc SHOWDRIVE
  lda #$0F
  sta F_CURDEV

SHOWDRIVE
  lda #$01
  sta $0286  ;White text

  ;Move Cursor
  ldx #$15              ; Row
  ldy #$0b              ; Column
  jsr SET_CURSOR

  lda F_CURDEV
  cmp #$08
  beq DIGIT
  cmp #$09
  beq DIGIT
  jmp DIGITS
  
DIGIT
  adc #$2F  ;convert to ascii
  jsr $ffd2
  lda #$20
  jsr $ffd2 ;append a space
  jmp SETUPTIMEOUT

DIGITS
  lda #$31  ;'1'
  jsr $ffd2
  lda F_CURDEV
  adc #$26
  jsr $ffd2
  jmp SETUPTIMEOUT


; ==============================================================
; SUBMENU RAM CONFIG
; ==============================================================

RAMMENU
  lda #<RAMSCREEN
  ldy #>RAMSCREEN
  jsr STROUT

  ; Check keys
KEYS_0
  jsr SHOW_IO
  jsr SHOW_WE

KEYS_1
  jsr $ffe4



F1_1
  cmp #$85  ;F1
  bne F2_1

  ;jsr SetVicAs3K
  lda #FEMOD_RAM +$1E                   ;3KB RAM
  bne SET_RAM

F2_1
  cmp #$89  ;F2
  bne F3_1

  ;jsr SetVicAs8K
  lda #FEMOD_RAM +$1D                   ;8KB RAM
  bne SET_RAM

F3_1
  cmp #$86  ;F3
  bne F4_1

  ;jsr SetVicAs16K
  lda #FEMOD_RAM +$19                   ;16KB RAM
  bne SET_RAM

F4_1
  cmp #$8a  ;F4
  bne F5_1

  ;jsr SetVicAs24K
  lda #FEMOD_RAM +$11                   ;24KB RAM
  bne SET_RAM

F5_1
  cmp #$87  ;F5
  bne F6_1

  ;jsr SetVicAs24K
  lda #FEMOD_RAM +$10                   ;24+3KB RAM
  bne SET_RAM

F6_1
  cmp #$8b  ;F6
  bne F7_1

  lda #FEMOD_RAM                        ;3KB RAM
  ldx #$FF                              ;OFF
  jmp RESET_SYSTEM

F7_1
  cmp #$88  ;F7
  bne F8_1

  ;jsr SetVicAs24K
  lda #FEMOD_RAM                        ;ALL RAM
  bne SET_RAM

F8_1
  cmp #$8C
  bne KEY_W
  jmp SSCREEN

KEY_W
  cmp #"W"
  beq W_FLAG

KEY_R
  cmp #"R"
  beq IO_FLAG
  bne KEYS_1


;-------- CHANGE IO REGISTER FLAG
IO_FLAG
  lda #"."
  cmp F_IO
  bne IOF2
  lda #"X"

IOF2
  sta F_IO
  jmp KEYS_0


;-------- CHANGE WEDGE FLAG
W_FLAG
  lda #"."
  cmp F_WE
  bne WEF2
  lda #"X"

WEF2
  sta F_WE
  jmp KEYS_0




SET_RAM
  ;sta DL_IOBASE
  sta IO_FINAL
  pha
  ldx F_IO
  cpx #"."
  bne SET_RAM5

  ldx #$80
  stx IO_FINAL +1                       ; LOCK IO (REGISTER INVISIBLE)
SET_RAM5
  and #$a0
  cmp #$80
  bne SET_RAM6                          ; WEDGE ONLY FOR RAM, RAM-NOIO

  ldx F_WE
  cpx #"X"
  beq SET_RAM8
SET_RAM6
  pla
  jsr SetVicMemConfig
  jmp BASIC1

SET_RAM8
  pla
  pha
  jsr SetVicMemConfig
  jsr MY_WEDGE_INIT
  pla
  and #$bf
  cmp #$80                              ; WEDGE $5 ONLY FOR ALL RAM
  bne SET_RAM9
  jsr MOVE_WEDGE_0500                   ; COPY WEDGE TO $500
SET_RAM9
  jmp STARTWEDGE2


;-------- SWITCH CARTRIDGE AND RUN BASIC
RUNBASIC
  ;jsr INIT_BASIC
  ;jsr $e404 ; INIT Message

  ; Complete BASIC Warm Start (since init is done above)
  ;jmp BASIC_WARM

  ldy #(__SET_IO_RUN_E - __SET_IO_RUN)
  lda #>__SET_IO_RUN
  ldx #<__SET_IO_RUN
  jsr COPY_PROC

  lda BIP_IOBASE
  ldx BIP_IOBASE +1
  jmp BIP


BASICSCREEN
  dc.b FONT1,CLRHOME,0




;-------- SWITCH CARTRIDGE AND RUN CODE
SYS_XY
  tya
  pha
  txa
  pha

  ;jsr INIT_BASIC

  ldy #(__SET_IO_RESET_E - __SET_IO_RESET)
  lda #>__SET_IO_RESET
  ldx #<__SET_IO_RESET
  jsr COPY_PROC

  ldy #(__SET_IO_RESET_E - __SET_IO_RESET) -2
  pla
  sta BIP,y
  pla
  sta BIP+1,y
SYS_XY_2
  lda BIP_IOBASE
  ldx BIP_IOBASE +1
  jmp BIP



;-------- RAM PROCEDURE TO SWITCH CARTRIDGE AND RUN BASIC
__SET_IO_RUN
  sta IO_FINAL
  stx IO_FINAL +1
  JSR BASCLR2                           ;CLR
  jsr PGMLINK                           ;Relinks BASIC Program from and to any address...
  JMP $C7AE
__SET_IO_RUN_E







;-------- COPY ROM TO RAM
UNLOCK_IO
  pha
  txa
  pha
  ldy #(__UNLOCK_IO_E - __UNLOCK_IO)
  lda #>__UNLOCK_IO
  ldx #<__UNLOCK_IO
  jsr COPY_PROC
  pla
  tax
  pla
  jmp BIP



;-------- UNLOCK START MODE AND SET MODE
__UNLOCK_IO
  sta $a000                             ;UNLOCK IO
  sta IO_FINAL
  stx IO_FINAL +1
  rts
__UNLOCK_IO_E





SHOW_IO
  ;Move Cursor
  ldx #21               ; Row
  ldy #13               ; Column
  jsr SET_CURSOR

  lda F_IO
  jmp BSOUT

SHOW_WE
  ;Move Cursor
  ldx #22               ; Row
  ldy #13               ; Column
  jsr SET_CURSOR

  lda F_WE
  jmp BSOUT


; ==============================================================
; Define some common PETSCII codes
; http://sta.c64.org/cbm64petkey.html
; ==============================================================

CLRHOME = $93
HOME    = $13
RVSON   = $12
RVSOFF  = $92
CR      = $0D
BLACK   = $90
WHITE   = $05
RED     = $1C
BLUE    = $1F
PURPLE  = $9C
YELLOW  = $9E
FONT1   = 142               ; BIG LETTERS & GRAFIC
FONT2   = 14                ; BIG AND SMALL LETTERS
AT      = $40

; ==============================================================
; Help screen
; ==============================================================


HELPSCREEN
  dc.b WHITE
HELPSCREEN3
  dc.b CLRHOME,FONT2,RVSON,"fe3 wEDGE cOMMANDS", CR, CR  ;RVSOFF Not Needed
  dc.b "$  dIRECTORY", CR
  dc.b AT, "  sTATUS/cOMMAND", CR
  dc.b "/  lOAD", CR
  dc.b "%  lOAD bINARY", CR
  dc.b "#  dRIVE", CR,CR
  dc.b "OLD/UNNEW basic", CR
  dc.b "KILL/OFF  END WEDGE", CR
  dc.b "NOIO/BLKD/BLKP", CR
  dc.b "RESET", CR
  dc.b CR  ;RVSOFF Not Needed
  dc.b "sys41000 hELP", CR
  dc.b "sys41003 wEDGE", CR
  dc.b "sys41006 wEDGE at $5", CR
  dc.b $00

; ==============================================================
; Startup screen
; ==============================================================

STARTUPSCREEN
; dc.b CLRHOME, WHITE, CR, RVSON, "DISK UTILITY CARTRIDGE", CR, CR
  dc.b CLRHOME,FONT2,YELLOW,RVSON,"*fINAL eXPANSION V3.1*", CR
  dc.b RVSON,                     "512/512kb sYSTEM  R013", CR, CR, CR
  dc.b WHITE,RVSON,"f1",RVSOFF," ram mANAGER", CR, CR
  dc.b "",RVSON,"f2",RVSOFF,"  basic uN-new", CR, CR
  dc.b RVSON,"f3",RVSOFF," dISK lOADER", CR, CR
  dc.b "",RVSON,"f4",RVSOFF,"  hELP", CR, CR
  dc.b RVSON,"f5",RVSOFF," cART lOADER", CR, CR
  dc.b "",RVSON,"f6",RVSOFF,"  fe uTILITIES", CR, CR
  dc.b RVSON,"f7",RVSOFF," basic (wEDGE)", CR, CR
  dc.b "",RVSON,"f8",RVSOFF,"  basic (NORMAL)", CR, CR, CR
  dc.b RVSON,"+",RVSOFF,"/",RVSON,"-",RVSOFF," dRIVE #8"
  dc.b $00

; ==============================================================
; RAMM setting menu
; ==============================================================

RAMSCREEN
  dc.b CLRHOME,FONT2,YELLOW,RVSON, "  ram cONFIGURATION   ",CR,CR,CR
  dc.b WHITE,RVSON,"f1",RVSOFF," 3 kb (6655)", CR, CR
  dc.b "",RVSON,"f2",RVSOFF,"  8 kb (11775)", CR, CR
  dc.b RVSON,"f3",RVSOFF," 16 kb (19967)", CR, CR
  dc.b "",RVSON,"f4",RVSOFF,"  24 kb (28159)", CR, CR
  dc.b RVSON,"f5",RVSOFF," 24+3 kb (28159)", CR, CR
  dc.b "",RVSON,"f6",RVSOFF,"  oFF", CR, CR
  dc.b RVSON,"f7",RVSOFF," aLL ram (28159)", CR, CR, CR
  dc.b "",RVSON,"f8",RVSOFF,"  mAIN mENU", CR, CR, CR
  dc.b "io ",RVSON,"r",RVSOFF,"EGISTER ( )", CR
  dc.b "eASY ",RVSON,"w",RVSOFF,"EDGE  ( )"
  dc.b $00







; ========================================================================
; DISK LOADER
; Schaltet in den RAM Modus
; Ladet die Loaderkonfig Datei (LOADER) in den BASIC Speicher
; Baut eine String Zeigertabelle auf ab TBL_NAMES ($6)
; Führt die Menü Auswahl Prozedur aus
; ========================================================================



;-------------- PRINT DLOADER SCREEN
DLOADER
  jsr DLOADER1
  jmp SSCREEN


DLOADER1
  jsr DLOADER_INIT
  bcs DLOADER_E

  jsr BLD_TABLE
  jsr MENU_HANDLER
  clv
  bvc DLOADER1


;-------------- LOAD LOADER FILE
DLOADER_INIT
  jsr INIT_CART                         ; Screen Colors

  lda #<DLOADSCREEN
  ldy #>DLOADSCREEN
  jsr STROUT

  jsr MENU_INIT

  lda #<MSG_LOAD
  ldy #>MSG_LOAD
  jsr STR_AT

  jsr LOAD_MENU
  php
  ldx #1
  jsr DEL_LINE
  plp
DLOADER_E
  rts


;-------------- PRINT DLOADER SCREEN
MENU_INIT
  lda #<MENUSCREEN
  ldy #>MENUSCREEN
  jsr STROUT

  lda #0
  sta DL_SLINIDX
  lda #DL_STARTLINE
  sta DL_SEL
MEIN_E
  rts


; ==============================================================
; DISKLOADER menu
; ==============================================================

DLOADSCREEN
  dc.b CLRHOME,YELLOW,FONT2,RVSON,"---- dISK lOADER  ----",CR,CR,0

MSG_LOAD
  dc.b 1, 3, WHITE, "LOADING ...",0


; ==============================================================
; MENU HANDLER
; ==============================================================

TBL_NAMES  = $6000

TBL_NAMES_CNT = TBL_NAMES


DL_CURLIN  = C_ROW                        ;TEMP. AKT LINE TO DRAW

TBL_DATA   = CAS_BUF +32
DL_SLINIDX = TBL_DATA                     ;INDEX OF FIRST LINE
DL_CURIDX  = TBL_DATA +1                  ;TEMP. AKT. INDEX
DL_CNT     = TBL_DATA +2                  ;TEMP. COUNTER
DL_SEL     = TBL_DATA +3                  ;selected menu line
DL_LINCNT  = TBL_DATA +4                  ;count of lines
DL_LASTLIN = TBL_DATA +5                  ;last line
DL_CNTLDR  = TBL_DATA +6                  ;LOAD FILES COUNT
DL_IOBASE  = TBL_DATA +7                  ;BASE FOR IO2 REGISTER 1 AND 2
;DL_RUNADR  = TBL_DATA +9                  ;RUN ADDRESS: 0=RUN BASIC, 1=RESET, 2=invalid, n=SYS

DL_LDBUF   = TBL_DATA +11                 ;LOAD BUFFER - bis zu 4 x DATEI,OPTIONS
LDBUF_LEN  = 0                            ;OFFSET FILENAME LENGTH
LDBUF_FN   = 1                            ;OFFSET FILENAME
LDBUF_TYP  = 17                           ;OFFSET TYPE: B=BASIC, P=PROGRAM, C=CARTRIDGE
LDBUF_LAD  = 18                           ;OFFSET LOAD ADRESS
LDBUF_END  = 20                           ;STRUCT LDBUF LEN


DL_STARTLINE = 3                          ;start line
DL_LINES     = 17                         ;number of lines



;-------------- RETURN TO MAIN SCREEN
MEHA_E
  pla
  pla
  rts


;-------------- HANDLE MENU KEY INPUT
MENU_HANDLER
  jsr LIST_PAGE
  jsr LIST_MARKER

MEHA_1
  lda #0
  sta KEYANZ
MEHA_5
  jsr GETIN
  cmp #$00
  beq MEHA_5

  cmp #$8C                                ;F8
  beq MEHA_E

  cmp #13                                 ;CR
  beq MENU_SEL

  jsr MEHA_8
  clv
  bvc MEHA_1


MEHA_8
  cmp #17                                 ;CURSOR DOWN
  beq MARKER_DOWN

  cmp #145                                ;CURSOR up
  beq MARKER_UP

  cmp #$85                                ;F1
  beq PAGEUP

  cmp #$86                                ;F3
  beq PAGEDWN

  cmp #$87                                ;F5
  beq MARKER_FIRST

  cmp #$88                                ;F7
  beq MARKER_LAST
  rts


;--------------------
PAGEUP
  lda DL_SLINIDX
  beq PAUP_E
  sec
  sbc #DL_LINES
PAUP_1
  sta DL_SLINIDX
  jsr LIST_PAGE

  ldx DL_SEL
  cpx DL_LASTLIN
  bcs MARKER_DOWN
PAUP_E
  inx
  rts


PAGEDWN
  lda DL_SLINIDX
  clc
  adc #DL_LINES
  bcs PADW_E
  cmp TBL_NAMES_CNT
  bcc PAUP_1
PADW_E
  ldx #1
  rts


MARKER_FIRST
  jsr HIDE_MARKER
  ldx #(DL_STARTLINE)
  bne SET_MARKER

MARKER_LAST
  jsr HIDE_MARKER
  ldx DL_LASTLIN
  bne SET_MARKER

MARKER_UP
  jsr HIDE_MARKER
  ldx DL_SEL
  dex
  cpx #DL_STARTLINE-1
  bne MAUP_2
  ldx DL_LASTLIN
MAUP_2
  bne SET_MARKER

MARKER_DOWN
  jsr HIDE_MARKER
  ldx DL_SEL
  cpx DL_LASTLIN
  bcc MADO_2
MADO_0
  ldx #(DL_STARTLINE-1)
MADO_2
  inx

SET_MARKER
  stx DL_SEL
  jmp LIST_MARKER




; ========================================================================
; DISK LOADER - SELEKTIERTEN MENÜPUNKT AUSFÜHREN
; Sucht den gewählten Menü Eintrag im BASIC Text
; Interpretiert die Befehle im BASIC Text
; Datei Ladebefehle kommen in einen Buffer (DL_LDBUF) für den LOADER
; Diskbefehle werden sofort ausgeführt
; Folgebefehle werden interpretiert (RAM Konfig, IO Konfig, Start Modus)
; ========================================================================

;----MENU PUNKT GEWÄHLT!
BASPTR = $7a

MENU_SEL
  lda DL_LINCNT
  bne MESE_0
  jmp MENU_HANDLER

MESE_0
  lda #0
  sta BIP_CMD
  sta DL_CNTLDR
  jsr INV_ADDR

  lda #FEMOD_RAM                        ;RAM SELECT
  sta DL_IOBASE
  lda #0                                ;ALL RESOURCES
  sta DL_IOBASE +1

MESE_1
  lda DL_SEL
  sec
  sbc #DL_STARTLINE
  bcc MESE_EE

  clc
  adc DL_SLINIDX
  jsr TBL_PTR
  bcs MESE_EE

  lda #<(DL_LDBUF)
  ldy #>(DL_LDBUF)
  sta PT1
  sty PT1 +1

MESE_2
  jsr NEXTLINE
  beq MESE_E
  ldy #4
MESE_5
  lda (PT2),y
  beq MESE_E                            ;CODE ENDE
  cmp #34                               ;NEXT MENU ENTRY
  beq MESE_E

  cmp #$aa                              ;"+" - LOADER ANWEISUNG
  bne MESE_2

  tya
  sec
  adc PT2
  sta CHRPTR
  lda PT2 +1
  adc #0
  sta CHRPTR +1

MESE_2a
  jsr CHRGOT
  bne MESE_2b
MESE_2c
  tax
  beq MESE_2

  jsr CHRGET                            ;SKIP ":"
  beq MESE_2c
MESE_2b
  jsr MESE_50
  jmp MESE_2a

MESE_50
  cmp #34                               ;+"FILENAME"
  bne MESE_6
  jmp SEL_LOAD

MESE_6
  cmp #"@"                              ;+@"diskcmd"
  bne MESE_7
  jmp DO_DISKCMD

MESE_7
  jsr TOKENIZER
  bne MESE_8
  jmp NEXT_STATEMENT

MESE_8
  cpx #TOK_NOIO                         ;NOIO
  beq SEL_NOIO
  cpx #TOK_BLKP                         ;BLOCK WRITE PROTECT
  beq SEL_BLOCK1
  cpx #TOK_BLKD                         ;BLOCK DISABLE
  beq SEL_BLOCK2

  stx BIP_CMD
  ;cpx #TOK_RELO                         ;RELOAD
  ;beq SEL_RELOAD
  ;cpx #TOK_RUN                          ;RUN
  ;beq SEL_RUN
  cpx #TOK_SYS                          ;SYS
  beq SEL_SYS
  ;cpx #TOK_RES                          ;RESET
  ;beq SEL_RESET
MESE_EE
  rts



; ========================================================================
; DISK LOADER - SELEKTIERTEN MENÜPUNKT AUSFÜHREN
; Alle Zeilen mit Anweisungen sind bereits verarbeitet
; + Anweisungen auf den Stack
; + Dateien laden
; + Anweisungen vom Stack ausführen
; ========================================================================

BIP_CMD     = BIP +80                      ;COMMAND BYTE
BIP_IOBASE  = BIP +81                      ;BASE FOR IO2 REGISTER 1 AND 2
BIP_RUNADR  = BIP +83                      ;RUN ADDRESS: 0=RUN BASIC, 1=RESET, 2=invalid, n=SYS


MESE_E
  lda DL_CNTLDR
  beq LOCO_RELOAD

  ;LOADER CODE
  ;  lda #<DLOADSCREEN
  ;  ldy #>DLOADSCREEN
  ;  jsr STROUT
  lda #CLRHOME
  jsr CHROUT

  ldx BIP_CMD
  beq LOCO_RELOAD
  cpx #TOK_RELO                         ;RELOAD
  beq LOCO_RELOAD

  lda DL_IOBASE +1
  sta BIP_IOBASE +1
  lda DL_IOBASE
  sta BIP_IOBASE
  sta IO_FINAL
  jsr SetVicMemConfig
  ;jsr INIT_BASIC                        ; original color
  ;jsr SY_RAMTAS2                        ; calculate RAM size
  ;jsr SY_BASRAM                         ; BASIC RAM (e3a4)

  jsr SY_INITMSG                        ; INIT Message (e404)
  jsr CROUT


  lda #FEMOD_ROM
  sta IO_FINAL                          ; EEPROM!
  jsr LOADER                            ; LOAD FILES
  bcs LOCO_RELOAD

  ldx BIP_CMD
  cpx #TOK_RES                          ;RESET
  beq LOCO_RES
  cpx #TOK_RUN                          ;RUN
  beq LOCO_RUN
  cpx #TOK_SYS                          ;SYS
  beq LOCO_SYS

LOCO_RELOAD
  jsr COPYROM                           ;RESTORE CART-CODE AND SWITCH TO RAM
  ldx BIP_CMD
  cpx #TOK_RELO                         ;RELOAD??
  beq LORE_E
  jmp MENU_HANDLER

LORE_E
  rts


;------------
SEL_SYS
  jsr GETADR
  bcs SERU_5
INV_ADDR
  lda #0
  tax
  sta BIP_CMD
SERU_5
  stx BIP_RUNADR
  sta BIP_RUNADR +1
  rts


;------------
SEL_NOIO
  lda #$80                              ;RAM, NO-IO
  ora DL_IOBASE +1
  sta DL_IOBASE +1
  rts




;------------ BLOCK WRITE PROTECT
SEL_BLOCK1
  ldy #0
  beq SEL_BLOCK2a


;------------ BLOCK DISABLE
SEL_BLOCK2
  ldy #1
SEL_BLOCK2a
  jmp SEL_BLOCK_P


;------------
LOCO_RES
  lda #<MSG_RES
  ldy #>MSG_RES
  jsr STROUT

  lda BIP_IOBASE
  ldx BIP_IOBASE +1
  jmp RESET_SYSTEM

;------------
LOCO_RUN
  lda #<MSG_RUN
  ldy #>MSG_RUN
  jsr STROUT
  jmp RUNBASIC

;------------
LOCO_SYS
  lda #<MSG_SYS
  ldy #>MSG_SYS
  jsr STROUT
  lda #32
  jsr BSOUT
  ldx BIP_RUNADR
  lda BIP_RUNADR +1
  jsr HEXOUT

  ldx BIP_RUNADR
  ldy BIP_RUNADR +1

  jmp SYS_XY



; ==============================================================
; SUBS
; ==============================================================



NEXTLINE
  ldy #1
  lda (PT2),y
  beq NELI_E
  tax
  dey
  lda (PT2),y
  sta PT2
  stx PT2 +1
  txa                                   ;RESET Z
NELI_E
  rts


;----PRINT MARKER
LIST_MARKER
  lda DL_LINCNT
  bne LIMA_1
  rts

LIMA_1
  lda #YELLOW
  jsr CHROUT
  ldx DL_SEL
  ldy #0
  jsr SET_CURSOR
  lda #62                                 ;">"
  jsr PUTCHR
  lda #60                                 ;"<"
  ldy #$15
  jmp PUTCHR3

HIDE_MARKER
  ldx DL_SEL
  ldy #0
  jsr SET_CURSOR
  lda #32
  jsr PUTCHR
  ldy #$15
  lda #32
  jmp PUTCHR3






;----LIST PAGE
LIST_PAGE
  lda #0
  sta DL_LINCNT
  lda #DL_STARTLINE
  sta DL_CURLIN
  lda #DL_LINES
  sta DL_CNT

  lda DL_SLINIDX
  sta DL_CURIDX

LIPA_2
  ldx DL_CURLIN
  ldy #1
  jsr SET_CURSOR
  jsr $eab2                         ;zeiger in color RAM

  lda #WHITE
  jsr CHROUT

  lda DL_CURIDX
  jsr LIST_LINE
  inc DL_CURLIN
  inc DL_CURIDX
  dec DL_CNT
  bne LIPA_2

  lda DL_LINCNT
  clc
  adc #DL_STARTLINE -1
  sta DL_LASTLIN
  rts



;----LIST LINE. AC=TAB ENTRY
LIST_LINE
  jsr TBL_PTR
  bcs LICU_E

  inc DL_LINCNT
  ldy #5
LICU_1
  lda (PT2),y
  beq LICU_E
  cmp #34
  beq LICU_E
  ;jsr CHROUT
  jsr CONVCHR
  bcc LICU_5
LICU_3
  sty C_CHR
  jsr PUTCHR2
  lda C_COL
  cmp #$15
  beq LICU_EE
  inc C_COL
  ldy C_CHR
LICU_5
  iny
  bne LICU_1
LICU_E
  lda #32
  ldy $d3
LICU_E2
  sta (C_LINE),y
  iny
  cpy #$15
  bne LICU_E2
LICU_EE
  rts


;----OFFSET --> TAB POINTER
TBL_PTR
  cmp TBL_NAMES
  bcs TAOF_E

  ldy #>(TBL_NAMES+1)
  asl                       ; *2
  bcc TAOF_1
  iny
  clc
TAOF_1
  adc #<(TBL_NAMES+1)
  sta PT1
  bcc TAOF_2
  iny
TAOF_2
  sty PT1 +1

  ldy #1
  lda (PT1),y
  sta PT2 +1
  dey
  lda (PT1),y
  sta PT2

  clc
TAOF_E
  rts


;----BUILD NAME TABLE FROM BASIC TEXT
BLD_TABLE
  lda #0
  sta TBL_NAMES

  lda #<(TBL_NAMES+1)
  ldy #>(TBL_NAMES+1)
  sta PT2
  sty PT2 +1

  lda BASSTRT
  ldx BASSTRT +1

BUTA_2
  sta PT1
  stx PT1 +1

  ldy #1
  lda (PT1),y
  beq BUTA_E

  tax
  ldy #4
  lda (PT1),y
  cmp #34
  bne BUTA_5

; FOUND PROGRAM NAME
  ldy #0
  lda PT1
  sta (PT2),y
  lda PT1 +1
  iny
  sta (PT2),y

  inc PT2
  bne BUTA_3a
  inc PT2 +1
BUTA_3a
  inc PT2
  bne BUTA_3b
  inc PT2 +1
BUTA_3b
  inc TBL_NAMES

BUTA_5
  ldy #0
  lda (PT1),y
  jmp BUTA_2

BUTA_E
  rts


; ==============================================================
; MENU SELECT PARAM
; ==============================================================

SEL_LOAD
  ;LOADER PARAM       :: +"filename",B|P|C|@ [,$adress]
  ;                      B=BASIC Code,P=Program,C=Cartridge,@=DOS COMMAND
  ldy #LDBUF_FN
  ldx #16
SELO_2
  lda (CHRPTR),y
  beq SELO_5
  cmp #34                                 ; "
  beq SELO_5
  sta (PT1),y                             ; SAVE FILENAME
  iny
  dex
  bne SELO_2
SELO_5
  dey
  beq SELO_E
  tya
  pha
  txa 
  beq SELO_7a
  lda #0
SELO_7
  iny
  sta (PT1),y                             ; FILL FILENAME WITH 0
  dex
  bne SELO_7
SELO_7a
  tay
  pla
  sta (PT1),y                             ; SAVE FILENAME LENGTH
  sec
  adc CHRPTR
  sta CHRPTR
  bcc SELO_8
  inc CHRPTR +1
SELO_8
  jsr CHRGET
  jsr CHKCOM
  bcs SELO_8a
  cmp #"B"
  beq SELO_9
  cmp #"C"
  beq SELO_9
  ;cmp #"@"
  ;beq SELO_9
SELO_8a
  lda #"P"
SELO_9
  ldy #LDBUF_TYP
  sta (PT1),y                             ; PROGRAM TYPE
  jsr CHRGET
  jsr CHKCOM
  bcs SELO_9a
  jsr GETADR
  bcs SELO_9b
SELO_9a
  lda #0
  tax
SELO_9b
  ldy #LDBUF_LAD +1
  sta (PT1),y                             ; LOAD ADR HIGH
  dey
  txa
  sta (PT1),y                             ; LOAD ADR LOW

  inc DL_CNTLDR
  clc
  lda #LDBUF_END
  adc PT1
  sta PT1
  bcc SELO_E
  inc PT1 +1
SELO_E
  rts




; ==============================================================
; MENU FOOTER
; ==============================================================

MENUSCREEN
  dc.b HOME,YELLOW, CR, CR
;  dc.b 210,210,210,210,210,210,210,210,210,210,210
  dc.b 96,96,96,96,96,96,96,96,96,96,96
  dc.b 96,96,96,96,96,96,96,96,96,96,96
  dc.b CR, CR, CR, CR, CR, CR, CR, CR, CR
  dc.b CR, CR, CR, CR, CR, CR, CR, CR, CR
  dc.b 96,96,96,96,96,96,96,96,96,96,96
  dc.b 96,96,96,96,96,96,96,96,96,96,96, CR
;  dc.b 197,197,197,197,197,197,197,197,197,197,197,CR

;      "---- DISK LOADER -----"
  dc.b RVSON,"f1",RVSOFF,"/",RVSON,"f3",RVSOFF,":pGuP/dWN "
  dc.b RVSON,"f8",RVSOFF,":eXIT",CR
  dc.b RVSON,"f5",RVSOFF,"/",RVSON,"f7",RVSOFF,":fIRST-/lAST lINE"
  dc.b HOME,$00



; =====================================================================
; MENU LOADER
; Schaltet in ROM Modus und lädt 1 oder mehrere Dateien in den Speicher
; Lade Instruktionen stehen in der Tabelle DL_LDBUF
; =====================================================================

LOADER
  ;LOADER PARAM       :: "filename",B|P|C [,$adress]     B=BASIC Code,P=Program,C=Cartridge
  lda #<(DL_LDBUF)
  ldy #>(DL_LDBUF)
  sta PT2
  sty PT2 +1

LOAD_2
  ldy #LDBUF_LAD
  lda (PT2),y                             ; LOAD ADR LOW
  sta LOADPTR
  iny
  lda (PT2),y                             ; LOAD ADR HIGH
  sta LOADPTR +1
  beq LOAD_2B

  lda #$ff
LOAD_2B
  tay                                     ; SA
  iny
  lda #1
  ldx F_CURDEV                          ; device#
  jsr SETFNUM

  ldy #LDBUF_LEN
  lda (PT2),y                             ; FILENAME LEN
  ldy PT2 +1
  ldx PT2
  inx
  bne LOAD_2D
  iny
LOAD_2D
  jsr SETFNAM


  ;lda #WHITE
  ;jsr CHROUT
  ldy #LDBUF_TYP
  lda (PT2),y
  tax

  ;cmp #"@"
  ;bne LOAD_3

  ;lda #<MSG_DOS
  ;ldy #>MSG_DOS
  ;jmp LOAD_7
;LOAD_3


LOAD_3A
  cpx #"B"
  bne LOAD_3B

  lda #<MSG_LOADBASIC
  ldy #>MSG_LOADBASIC
  jsr PRINT_LOADING

  jsr LOAD_BASIC
  jmp LOAD_4

LOAD_3B
  cpx #"C"
  bne LOAD_3C

  lda LOADPTR +1
  bne LOAD_3B2
  lda #$a0                                ;DEFAULT CARTRIDGE ADDRESS
  sta LOADPTR +1
LOAD_3B2
  lda #<MSG_LOADCART
  ldy #>MSG_LOADCART
  jsr PRINT_LOADING

  ldy #2
  sty SY_SA
  jsr MY_IECLOAD
  jmp LOAD_4

LOAD_3C
  lda #<MSG_LOADPROG
  ldy #>MSG_LOADPROG
  jsr PRINT_LOADING
  jsr MY_IECLOAD
LOAD_4
  bcs LOAD_ERR
  ;clc
  lda #LDBUF_END
  adc PT2
  sta PT2
  bcc LOAD_10
  inc PT2 +1

LOAD_10
  dec DL_CNTLDR
  beq LOAD_E
  jmp LOAD_2

LOAD_E
  jsr PRINT_IO
  clc
  rts

LOAD_ERR
  lda #<MSG_LOADERR
  ldy #>MSG_LOADERR
  jsr STROUT
  jsr WAITSPACE
  sec
  rts



PRINT_LOADING
  jsr STROUT

  ;ldy #LDBUF_LAD +1
  ;lda (PT2),y                             ; LOAD ADR HIGH
  ;beq LOAD_6

  ;lda #<MSG_LOADAT
  ;ldy #>MSG_LOADAT
  ;jsr STROUT

  ;ldx LOADPTR
  ;lda LOADPTR +1
  ;jsr HEXOUT

LOAD_6
  lda #<MSG_LOADFN1
  ldy #>MSG_LOADFN1
LOAD_7
  jsr STROUT


  ldy #LDBUF_FN
LOAD_8
  lda (PT2),y                             ; LOAD ADR LOW
  beq LOAD_9
  jsr CHROUT
  iny
  bne LOAD_8

LOAD_9
  lda #<MSG_LOADFN2
  ldy #>MSG_LOADFN2
  jmp STROUT





; ==============================================================
; LOAD MENU DATA    "LOADER"
; ==============================================================

SETFNUM = $ffba
SETFNAM = $ffbd
LOAD    = $ffd5

BASCLR2 = $c659
BASCLR  = $c660
PGMLINK = $c533

LOAD_MENU
  ldx #<(MSG_LOADER)
  ldy #>(MSG_LOADER)
  lda #6
  jsr SETFNAM
  lda #1
  ldx F_CURDEV                          ; device#
  ldy #0
  jsr SETFNUM
  lda #0                  ;load
  ldx BASSTRT             ;Start lo#
  ldy BASSTRT +1          ;Start hi#
  jsr LOAD
  jmp BASLOAD_END

LOAD_BASIC
  lda #1
  ldx F_CURDEV                          ; device#
  ldy #0
  jsr SETFNUM
  ldx BASSTRT             ;Start lo#
  ldy BASSTRT +1          ;Start hi#
  stx LOADPTR
  sty LOADPTR +1
  jsr MY_IECLOAD
  jmp BASLOAD_END



SYS_IECOPEN = $f495
SYS_TALK    = $ee14
SYS_TALKSA  = $eece
SYS_LOAD2   = $f58a
SYS_LOAD2C  = $f5a3
SYS_SETADR  = $e4c1




; ==============================================================
; LOADER TEXT
; ==============================================================

MSG_SYS
  dc.b "SYS",0
MSG_RUN
  dc.b "RUN",0

MSG_LOADER
  dc.b "LOADER",0

MSG_LOADCART
  dc.b "LOAD CART",0
MSG_LOADBASIC
  dc.b "LOAD BASIC PROG",0
MSG_LOADPROG
  dc.b "LOAD FILE",0
MSG_LOADFN1
  dc.b CR, "  ",60,0
MSG_LOADFN2
  dc.b 62,CR,0
MSG_DOS
  dc.b "@ ",60,0
;  lda #60                                 ;"<"
;  lda #62                                 ;">"







; ==============================================================
; SET MEMORY CONFIG
; ==============================================================

MOVE_WEDGE_0500
  ldx #<MY_WEDGE_LO                     ; store the new dest address lo-byte
  ldy #>MY_WEDGE_LO                     ; store the new dest address hi-byte $516


MOVE_WEDGE
  sty mwcmd + 1                        ; store the new dest address hi-byte $516
  stx mwcmd                            ; store the new dest address lo-byte

  lda #<MY_WEDGE_START
  sta $5f                               ; low-byte start address $a000
  lda #>MY_WEDGE_START
  sta $60                               ; high-byte start address $a000

  lda #<MY_WEDGE_END
  sta $5a                               ; low-byte end address +1 $a???
  lda #>MY_WEDGE_END
  sta $5b                               ; high-byte end address +1 $a???

  lda #<(MY_WEDGE_END - MY_WEDGE_START)
  clc
  adc mwcmd                             ; add the new dest address $0500
  ;adc $74                               ; add the new dest address $0500
  sta $58                               ; low-byte new end address +1 $0501+fl len
  lda #>(MY_WEDGE_END - MY_WEDGE_START)
  adc mwcmd + 1                         ; add the new dest address $0500
  ;adc $75                               ; add the new dest address $0500
  sta $59                               ; high-byte new end address +1 $0501+fl len

  sei
  jsr MOVMEM                            ; execute move memory vic routine and return
  jsr MOWE_1
  cli
  rts

MOWE_1
  jmp (mwcmd)








; ==============================================================
; SET MEMORY CONFIG
; ==============================================================

;  lda #$9F                    ;0kb
;  lda #$9E                    ;3kb
;  lda #$9D                    ;8kb          %1001 1101
;  lda #$99                    ;16kb         %1001 1001
;  lda #$91                    ;24kb         %1001 0001
;  lda #$90                    ;24+3kb       %1001 0000
;  lda #$80                    ;ALL RAM      %1000 0000
SetVicMemConfig:
  tax
  and #$03
  cmp #$02
  beq SetVicAs3K
  cmp #$03
  beq SetVicAsUnexpanded
  txa
  and #$0c
  cmp #$0c
  beq SetVicAs8K
  cmp #$00
  beq SetVicAs24K

SetVicAs16K:                            ; set vic as 16k expanded
  lda #$10			        ; Screen memory page start $1000 (hi-byte)
  ldx #$12			        ; Start of memory $1200 (hi-byte)
  ldy #$60			        ; Top of memory $6000 (hi-byte)
  bne dir_unexpand

SetVicAsUnexpanded:                     ; set vic as unexpanded
  lda #$1e			        ; Screen memory page start $1e00 (hi-byte)
  ldx #$10			        ; Start of memory $1000 (hi-byte)
  ldy #$1e			        ; Top of memory $1e00 (hi-byte)
  bne dir_unexpand

SetVicAs3K:                             ; set vic as 3k expanded
  lda #$1e			        ; Screen memory page start $1e00 (hi-byte)
  ldx #$04                              ; Start of memory $0400 (hi-byte)
  ldy #$1e                              ; Top of memory $1e00 (hi-byte)
  bne dir_unexpand

SetVicAs8K:                             ; set vic as 8k expanded
  lda #$10			        ; Screen memory page start $1000 (hi-byte)
  ldx #$12			        ; Start of memory $1200 (hi-byte)
  ldy #$40			        ; Top of memory $4000 (hi-byte)
  bne dir_unexpand

SetVicAs24K:                            ; set vic as 24k expanded
  lda #$10			        ; Screen memory page start $1000 (hi-byte)
  ldx #$12			        ; Start of memory $1200 (hi-byte)
  ldy #$80			        ; Top of memory $6000 (hi-byte)

dir_unexpand:       ;@@@
  sta dir_screen_mem_page               ; Screen memory page start (hi-byte)
  lda dir_start_memory_hi
  stx dir_start_memory_hi               ; Start of memory (hi-byte)
  sty dir_top_memory_hi                 ; Top of memory (hi-byte)

  ;jsr UnexpandMoveMemory

  ;jsr SY_INITIO2                        ; Initialize I/O
  jmp INIT_BASIC



; ==============================================================
; The credits!
; ==============================================================

THECREDITS
  dc.b CLRHOME, YELLOW, "V3 06/2009", CR, CR
  dc.b RED, "CREATED BY:", CR, CR
  dc.b BLACK
  dc.b "LEIF BLOOMQUIST", CR
  dc.b "ANDERS PERSSON", CR
  dc.b "ANDERS CARLSSON", CR
  dc.b "CHRISTOPHER PREST", CR
  dc.b "BRIAN LYONS", CR
  dc.b "LEE DAVIDSON", CR
  dc.b "SCHLOWSKI", CR
  dc.b "VIPERSAN", CR
  dc.b "DANIEL KAHLIN", CR
  dc.b "JEFF DANIELS", CR
  dc.b "MICHAEL KLEIN", CR
  dc.b "DAVID A. HOOK", CR
  dc.b "TOMMY WINKLER", CR, CR
  dc.b PURPLE
  dc.b "WWW.SLEEPINGELEPHANT", CR
  dc.b "        .COM/DENIAL/", CR
  dc.b BLUE
  dc.b $00







;Pad to end to create valid cart image
  org $afff
  dc.b #$00


  ;jmp MY_WDGE_START

MY_WEDGE_START



; ==============================================================
; RELOCATOR
; ==============================================================

STACK           = $0100


SY_TIMOUTFLG = $ffa2
SY_GETSTATUS = $ffb7


MY_RELOCATOR
_relo = . +2
  jsr SY_GETSTATUS                      ;WEDGE ADDRESS TO STACK
_relo0000 = . +1
  lda _relo
  tsx
  lda STACK,x                           ;ADR HIGH
  tay
  dex
  lda STACK,x                           ;ADR LO
  sta PT1
  sty PT1 +1
;  sta PT3
;  sty PT3 +1                            ;BASE ADDRESS

  ldy #(_relo0000 - _relo)
  sec
  sbc (PT1),y
  sta PT2
  iny
  lda PT1 +1
  sbc (PT1),y
  sta PT2 +1
  ora PT2
  beq RELO_E                            ;RELOCATION NOT NESSECARY


RELO_0
  clc
  lda #>(RELO_TAB - _relo)
  adc PT1 +1                            ;RELO_TAB POINTER HI
  sta PT1 +1
  lda #<(RELO_TAB - _relo)
  ldx #1
RELO_2
  stx FLGCOM
RELO_3
  clc
  adc PT1
  sta PT1                               ;RELO_TAB POINTER LO
  bcc RELO_3a
  inc PT1 +1                            ;RELO_TAB POINTER HI
RELO_3a
  ldy #0
  lda (PT1),y
  bne RELO_3c

  tax
  iny
  lda (PT1),y
  bne RELO_3b

;-------------- 00.00 GET OFFSET
  iny
  lda (PT1),y
  beq RELO_E
  tax
  lda #3
  bne RELO_2

RELO_3b
  dey
  txa
RELO_3c
  clc
  adc PT2
  sta (PT1),y
  sta LOADPTR                           ;MODIFY ADDRESS LO
  iny
  lda (PT1),y
  adc PT2 +1
  sta (PT1),y
  sta LOADPTR +1                        ;MODIFY ADDRESS HI

  dey
  clc
  lda (LOADPTR),y
  adc PT2
  sta (LOADPTR),y                       ;RELINK ADDRESS LO
  ldy FLGCOM
  lda (LOADPTR),y
  adc PT2 +1
  sta (LOADPTR),y                       ;RELINK ADDRESS HI

  lda #2
  bne RELO_3

RELO_E
;_relo0003 = . +1
;  jmp MY_WEDGE_INIT



; ==============================================================
; MY WEDGE
; ==============================================================

PTR_ERROR_OUT   = $0300
PTR_INPUT_LOOP  = $0302
PTR_FRMELEM     = $030a
PTR_LOAD        = $0330
PTR_SAVE        = $0332

;-------------------- WEDGE INIT
MY_WEDGE_INIT
_relo5000 = . +1
  lda #<INPUT_LOOP
  ldx #>INPUT_LOOP
  sta PTR_INPUT_LOOP
  stx PTR_INPUT_LOOP +1
_relo5001 = . +1
  lda #<MY_LOAD
  ldx #>MY_LOAD
  sta PTR_LOAD
  stx PTR_LOAD +1
_relo5003 = . +1
  lda #<MY_SAVE
  ldx #>MY_SAVE
  sta PTR_SAVE
  stx PTR_SAVE +1
_relo5002 = . +1
  lda #<MY_FRMELEM
  ldx #>MY_FRMELEM
  sta PTR_FRMELEM
  stx PTR_FRMELEM +1
  lda #8
  sta F_CURDEV
  rts




; ==============================================================
; MY INPUT LOOP
; ==============================================================

INLO_1
_relo0001 = . +1
  jsr INLO_LOOP2

INPUT_LOOP
  jsr $c560                             ; INPUT LINE
  stx CHRPTR
  sty CHRPTR +1
  jsr CHRGET
  tax
  beq INPUT_LOOP
  ldx #$ff
  stx dir_basiclinenumber_hi            ; DIRECT MODE
  bcs INLO_1
  jmp $c49c                             ; INSERT LINE INTO BASICTEXT





DOLO_ERR
_relo0024 = . +1
  jsr PRINT_DISK_ERR
  sec
  rts




BASLOAD_END
  bcs DOLO_ERR
BASLOAD_END_2
  stx BASVAR
  sty BASVAR +1
  jsr PGMLINK
DOLO_E
  clc                                   ; LOAD OK
  rts



INLO_LOOP2
  cmp #"$"                              ; CATALOG?
  beq DO_CATALOG
  cmp #"@"                              ; DISK CMD?
  beq DO_DISKCMD
  cmp #"/"                              ; LOAD BASIC?
  beq DO_LOADBAS
  cmp #"%"                              ; LOAD BINARY?
  beq DO_LOADBIN
  cmp #">"                              ; VERIFY BINARY?
  beq DO_VERIFY
  ;cmp #95                               ; SAVE? (left arrow)
  ;beq DO_SAVE
  cmp #"#"                              ; DEVICE?
  beq DO_SETDEV
  cmp #","                              ; HEX CALC
  beq DO_HEXCALC

_relo0002 = . +1
  jsr TOKENIZER
  bne INLO_LOOP2b
INLO_LOOP2a
  pla
  pla
  jmp $c496                             ; EXECUTE LINE


  ;LIST DISK CATALOG ($)
DO_CATALOG
_relo0010 = . +1
  jsr GET_STRING
_relo0011 = . +1
  jmp PRINT_CATALOG


  ;SET / LIST DEVICE# FOR DISK COMMANDS (#)
DO_SETDEV
_relo0012 = . +1
  jmp SET_DEVICE


  ;SEND DISK COMMAND (@)
DO_DISKCMD
_relo0013 = . +1
  jsr GET_STRING
_relo0014 = . +1
  jmp DISK_CMD


  ;SHOW WORD VALUE IN DEC, HEX, BIN, ASC (,)
DO_HEXCALC
  jsr CHRGET
_relo0015 = . +1
  jsr FRMWORD                           ; GET WORD VALUE
_relo0016 = . +1
  jmp PRINT_VALUE



  ;LOAD BASIC OR ABSOLUTE (/)
DO_VERIFY
  ldy #$1                               ; SA=1
  tya
  bne DOLO_2

  ;LOAD BASIC OR ABSOLUTE (/)
DO_LOADBAS
  ldx BASSTRT
  lda BASSTRT +1
  stx LOADPTR
  sta LOADPTR +1
  ldy #$0                               ; SA=0
  beq DOLO_1

  ;LOAD BINARY OR CARTRIDGE (%)
DO_LOADBIN
  ldy #$1                               ; SA=1
DOLO_1
  lda #0                                ; LOAD
DOLO_2
  pha
  ldx F_CURDEV                          ; device#
  lda #$01                              ; lfn #01
  jsr SETLFS
_relo0020 = . +1
  jsr GET_LOADPAR
  pla
_relo0021 = . +1
  jsr MYLO_0
  bcs DOLO_ERR

  lda SY_VERIFY
  beq MYLO_1
  jmp $e17b                             ;verify error?

MYLO_1
  lda SY_SA                             ; SA=0
  bne DOLO_E

_relo0022 = . +1
  jsr BASLOAD_END_2
  jsr BASCLR2
_relo0023 = . +1
  jmp INPUT_LOOP



;------------ EXECUTE SOFT RESET
INLO_UNNEW
_relo0025 = . +1
  jmp DO_UNNEW



;------------ EXECUTE TOKEN
INLO_LOOP2b
  ;cpx #TOK_RUN
  ;beq INLO_LOOP2a
  ;cpx #TOK_SYS
  ;beq INLO_LOOP2a

  cpx #TOK_RES
  beq INLO_RESET
  ;cpx #TOK_RELO
  cpx #TOK_NOIO                         ;NOIO
  beq INLO_NOIO

  ldy #0
  cpx #TOK_BLKP                         ;BLOCK WRITE PROTECT
  beq INLO_SETIO
  iny
  cpx #TOK_BLKD                         ;BLOCK DISABLE
  beq INLO_SETIO

  cpx #TOK_OLD
  beq INLO_UNNEW
  cpx #TOK_OFF
  beq INLO_OFF
  cpx #TOK_KILL
  beq INLO_KILL

  lda #0
  sta CHRPTR                            ;RESET CHRPTR TO START OF BIP
  beq INLO_LOOP2a





;------------ EXECUTE SOFT RESET
INLO_RESET
_relo0026 = . +1
  jsr RESET_IO
  jmp SOFT_RESET



;------------ KILL FE3 (IO,BANKS,WEDGE)
INLO_KILL
_relo0030 = . +1
  jsr INLO_OFF
_relo0031 = . +1
  jsr INLO_NOIO3
  lda #128
  ldx #$9f
_relo0032 = . +1
  jmp RESET_SYSTEM




;------------ DISABLE WEDGE
INLO_OFF
_relo5010 = . +1
  lda #<WEDGEMESSAGE1b
  ldy #>WEDGEMESSAGE1b
_relo0033 = . +1
  jsr STROUT
_relo5011 = . +1
  lda #<WEDGEMESSAGE1c
  ldy #>WEDGEMESSAGE1c
_relo0034 = . +1
  jsr STROUT
  jsr $e45b                             ;INIT BASIC VECTORS
  jsr $ff8a                             ;INIT IO VECTORS
  jmp $c480                             ;STD. INPUT LOOP




;------------ SET NOIO
INLO_NOIO
  lda #$80                              ;RAM, NO-IO
INLO_NOIO2
  ora IO_FINAL +1
  sta IO_FINAL +1
INLO_NOIO3
_relo5012 = . +1
  lda #<MSG_NOIO
  ldy #>MSG_NOIO
_relo0035 = . +1
  jmp STROUT



;------------ SET BLK IO
INLO_SETIO
  lda IO_FINAL +1
  sta DL_IOBASE +1
  lda IO_FINAL
  sta DL_IOBASE

  jsr CHRGOT
  beq PRINT_IO

  lda DL_IOBASE,y
  and #$e0
  sta DL_IOBASE,y
_relo0042 = . +1
  jsr SEL_BLOCK_P

  lda DL_IOBASE +1
  sta IO_FINAL +1
  lda DL_IOBASE
  sta IO_FINAL

PRINT_IO
_relo5013 = . +1
  lda #<MSG_PRINTIO
  ldy #>MSG_PRINTIO
_relo0036 = . +1
  jsr STROUT
  ldx DL_IOBASE
  lda #0
_relo0037 = . +1
  jsr HEXOUT
  lda #"/"
_relo0040 = . +1
  jsr CHROUT
  ldx DL_IOBASE +1
  lda #0
_relo0038 = . +1
  jsr HEXOUT
_relo0039 = . +1
  jmp CROUT



;------------
SEL_BLOCK_P
  jsr CHRGOT
  bcs SEBL_E
SEBL_1
  and #7
  tax
  lda #1
  cpx #5
  bcc SEBL_2                            ; <5
  bne SEBL_8
  dex                                   ; 5 --> 4
SEBL_2
  dex
  bmi SEBL_6
  asl
  bne SEBL_2
SEBL_6
  and #$1f
  ora DL_IOBASE,y
  sta DL_IOBASE,y
SEBL_8
  jsr CHRGET
  bcc SEBL_1
_relo0041 = . +1
  jsr CHKCOM
  bcc SEL_BLOCK_P
SEBL_E
  rts





; ==============================================================
; UNNEW (OLD) BASIC PROGRAM
; ==============================================================


DO_UNNEW
  ldy #$01
  tya
  sta (BASSTRT),Y                       ; store a non zero in the MSB of the first link addr
  jsr PGMLINK                           ; relinker
  lda PT1                               ; set end of basic/start of variables to the address of the last '0' found + 2
  clc
  adc #$02
  sta BASVAR
  lda PT1 +1
  adc #$00
  sta BASVAR +1
  jsr BASCLR2                           ; Reset TXTPTR and Perform [clr]
  ;lda #<UnNewMessage    ; string start point lo-byte
  ;ldy #>UnNewMessage    ; string start point hi-byte
  ;jsr PRNSTR            ; print string in A/Y, 0 terminated

  jmp BASIC_WARM        ; BASIC Warm Restart [RUNSTOP-RESTORE]

;UnNewMessage:
;	.byte "PROGRAM RESTORED",0



; ==============================================================
; GET STRING PARAM
; ==============================================================


GET_STRING
  lda F_CURDEV                          ; device
  sta SY_DN                             ; prime address
  jsr CHRGET
  tay
  beq GEST_5
  ldy #0
  sty FLGCOM
  cmp #34
  bne GEST_3
  sta FLGCOM
_relo0050 = . +1
  jsr INC_CHRPTR
GEST_3
  lda (CHRPTR),y
  beq GEST_5
  cmp FLGCOM
  beq GEST_5
  iny
  bne GEST_3

GEST_5
  tya                                   ; STR LEN
  ldx CHRPTR
  ldy CHRPTR +1
  jsr SETFNAM

  tay
  lda (CHRPTR),y
  beq GEST_7
  iny
GEST_7
  tya

ADD_CHRPTR
  clc
  adc CHRPTR
  sta CHRPTR
  bcc ADCH_1
ADCH_0
  inc CHRPTR +1
ADCH_1
  rts

INC_CHRPTR
  inc CHRPTR
  beq ADCH_0
  rts



; ==============================================================
; GET LOAD PARAM
; ==============================================================

GET_LOADPAR
  lda BIP +1
  cmp #34
  beq GELO_2
  lda BIP +3
  cmp #34
  bne GELO_2
  inc CHRPTR
  inc CHRPTR
GELO_2
_relo0060 = . +1
  jsr GET_STRING
_relo0061 = . +1
  jsr FRMWORD2                          ; GET WORD VALUE
  bcs GELO_5

  ; SET LOAD ADDRESS
  ldx PT3
  lda PT3 +1
  stx LOADPTR
  sta LOADPTR +1

  ldx SY_SA                             ; SA
  beq GELO_5                            ; SA=0: LOAD AT

  ldx #2                                ; LOAD CARTRIDGE ON :: %"jj",adr
  stx SY_SA                             ; SA
GELO_5
  rts



; ==============================================================
; SET DEVICE#
; ==============================================================

SET_DEVICE
  jsr CHRGET
  beq PRINT_DEV

;_relo0070 = . +1

  jsr FRMBYTE
  cpx #4
  bcc SEDE_2
  cpx #13
  bcc SEDE_E
SEDE_2
  ldx #8
SEDE_E
  stx F_CURDEV

PRINT_DEV
_relo5070 = . +1
  lda #<MSG_DEVICE
  ldy #>MSG_DEVICE
_relo0071 = . +1
  jsr STROUT

  ldx F_CURDEV
  lda #0
  jsr PRNINT                            ;print integer in X/A

_relo0072 = . +1
  jmp CROUT




; ==============================================================
; SYS PROCS
; ==============================================================

;UNLISTEN = $ffae	                ; send UNLISTEN command
;LISTEN	 = $ffb1	                ; send LISTEN command
;LISTENSA = $ff93	                ; send SA for LISTEN command
;TALK     = $ffb4	                ; send TALK command
;UNTALK   = $ffab	                ; send UNTALK command
;TALKSA   = $ff96	                ; send SA for TALK command
;IECIN    = $ffa5	                ; get char from IEC
;IECOUT   = $ffa8	                ; send char to IEC

SETSTAT  = $fe6a	                ; set status
CHKSTOP  = $ffe1                        ; check stop key

LISTEN	 = JIF_LISTEN                   ; send LISTEN command
TALK     = JIF_TALK	                ; send TALK command
LISTENSA = JIF_LISTENSA                 ; send SA for LISTEN command
TALKSA   = JIF_TALKSA	                ; send SA for TALK command
UNLISTEN = JIF_UNLISTEN	                ; send UNLISTEN command
UNTALK   = JIF_UNTALK	                ; send UNTALK command
IECIN    = JIF_IECIN	                ; get char from IEC
IECOUT   = JIF_IECOUT	                ; send char to IEC



; ==============================================================
; MY LOAD
; ==============================================================

FRMNUM   = $cd8a	                ; GET NUMERIC VALUE
FRMBYTE  = $d79e	                ; GET BYTE VALUE TO X
CNVWORD  = $d7f7	                ; CONVERT TO WORD VALUE INTO Y/A; $14 (PT3)


  ; LOAD VECTOR                         :: "fnam",PA,SA[,loadadr]
MY_LOAD
  ldx SY_DN                             ; PA (device#)
  cpx #4
  bcs MYLO_0
  jmp $f549                             ; OLD LOAD PROC


;MY_IECVERIFY
;  lda #1
;  bne MYLO_0

MY_IECLOAD
  lda #0
MYLO_0
  sta SY_VERIFY
  lda #0
  sta SY_FN                             ; file# - flag for first byte

  lda #$f0                              ; channel
_relo0080 = . +1
  jsr DISK_LISTEN
_relo0081 = . +1
  jsr IECNAMOUT

  lda #$60
_relo0082 = . +1
  jsr DISK_TALK

  ldx SY_SA                             ; SA
  beq MYLO_00                           ; SA=0: LOAD AT $c3

  dex
  dex
  beq MYLO_02


MYLO_01                                 ; SA=1: LOAD AT FILE-ADR
_relo0083 = . +1
  jsr MY_IECIN
  bcs MYLO_ERR

  tax                                   ; load address lo
_relo0301 = . +1
  jsr IECIN                             ; load address hi
  clv
  bvc MYLO_2


MYLO_00                                 ; SA=0: LOAD AT $c3
_relo0084 = . +1
  jsr MY_IECIN
  bcs MYLO_ERR

_relo0300 = . +1
  jsr IECIN                             ; skip load address

MYLO_02                                 ; SA=2: LOAD CARTRIDGE AT $c3
_relo0085 = . +1
  jsr FRMWORD2                          ; GET WORD VALUE
  lda LOADPTR +1
  ldx LOADPTR
  bcs MYLO_2

  lda PT3 +1
  ldx PT3

MYLO_2
  sta LOADEND +1
  stx LOADEND

_relo0086 = . +1
  jsr PRINT_ATADR

_relo0087 = . +1
  jsr MY_IECIN
  bcc MYLO_6

MYLO_ERR
_relo0302 = . +1
  jsr UNTALK
_relo0088 = . +1
  jsr DISK_CLOSE
  jmp $f787


MYLO_5
_relo0089 = . +1
  jsr MY_IECIN2
MYLO_6
  ldy SY_VERIFY
  beq MYLO_7                            ; --> load

  ldy #0
  cmp (LOADEND),y
  beq MYLO_8

  lda #$10
  jsr SETSTAT
  .byte $2c
MYLO_7
  sta (LOADEND),y
MYLO_8
  inc LOADEND
  bne MYLO_7a
  inc LOADEND +1
MYLO_7a
  bit SY_STATUS
  bvc MYLO_5                            ; EOI?

MYLO_E
_relo0303 = . +1
  jsr UNTALK
_relo0090 = . +1
  jsr DISK_CLOSE

_relo0091 = . +1
  jsr PRINT_TOADR

  clc
  ldx LOADEND
  ldy LOADEND +1
  rts




  ; GET BYTE FROM IEC, CHECK STATUS
MY_IECIN2
_relo0304 = . +1
  jsr IECIN
  pha
  lda SY_STATUS
  lsr
  lsr
  bcc MYIE_4                            ; timeout --> no

  lda SY_FN                             ; file# - flag for first byte
  beq MYIE_4                            ; first byte --> error

  pla
  lda #$fd
  and SY_STATUS
  sta SY_STATUS
  jsr CHKSTOP
  bne MY_IECIN2
  sec
  rts

MY_IECIN
_relo0092 = . +1
  jsr MY_IECIN2
  pha
  lda #1
  sta SY_FN
MYIE_4
  pla
  rts



  ; PRINT LOAD AT ADDRESS
PRINT_ATADR
  ldx #LOADEND
PRINT_ATADR_2
_relo5090 = . +1
  lda #<MSG_LOADAT
  ldy #>MSG_LOADAT
PRAT_1
_relo0096 = . +1
  jsr STROUT
HEXOUT_ZP
  lda 1,x
  pha
  lda 0,x
  tax
  pla
_relo0095 = . +1
  jmp HEXOUT

  ; PRINT LOAD AT ADDRESS
PRINT_TOADR
  ldx #LOADEND
PRINT_TOADR_2
_relo5091 = . +1
  lda #<MSG_LOADTO
  ldy #>MSG_LOADTO
_relo0093 = . +1
  jsr PRAT_1
_relo0094 = . +1
  jmp CROUT



; ========================================================================
; MY SAVE                   ENDADDR   = ($AE/$AF)    STARTADDR = ($C1/$C2)
;
; SAVESTART = $c1
; LOADPTR   = $c3
; LOADSTART = $ac
; LOADEND   = $ae
; ========================================================================

  ; SAVE VECTOR                         :: "fnam",PA,SA[,fromadr,toaddr]
MY_SAVE
  ldx SY_DN                             ; PA (device#)
  cpx #4
  bcs MYSA_0
  jmp $f685                             ; OLD LOAD PROC


;MY_IECVERIFY
;  lda #1
;  bne MYLO_0

MY_IECSAVE
;  lda #0
MYSA_0
  lda #$f1                              ; channel
_relo0400 = . +1
  jsr DISK_LISTEN
_relo0401 = . +1
  jsr IECNAMOUT

  lda #$61
_relo0402 = . +1
  jsr DISK_LISTEN

  jsr $fbd2                             ; $C1/$C2 --> $ac/$ad

  lda LOADSTART
_relo0403 = . +1
  jsr IECOUT
  lda LOADSTART +1
_relo0404 = . +1
  jsr IECOUT

  ldx #LOADSTART
  jsr PRINT_ATADR_2

  ldy #0
MYSA_00
  jsr $fd11                             ;END ADDRESS?
  bcs MYSA_E0                           ;YES -->
  lda (LOADSTART),y
_relo0405 = . +1
  jsr IECOUT

  jsr CHKSTOP
  bne MYSA_02

_relo0406 = . +1
  jsr UNLISTEN
_relo0407 = . +1
  jsr DISK_CLOSE_SA
  jmp $f6ce


MYSA_02
  jsr $fd1b                             ;INCR ADDR
  bne MYSA_00

MYSA_E0
_relo0408 = . +1
  jsr UNLISTEN
_relo0409 = . +1
  jsr DISK_CLOSE_SA
_relo0410 = . +1
  ldx #LOADSTART
  jsr PRINT_TOADR_2
  clc
  rts




; ==============================================================
; DISK CMD
; ==============================================================

  ;DISK CMD PARAM       :: +@"cmd"
DISK_CMD
  ldx LEN_FNAM
  beq PRINT_DISK_STAT
  lda #$6f                              ; channel
_relo0100 = . +1
  jsr DISK_LISTEN

IECNAMOUT
  lda IECSTAT
  bmi DICM_ERR

  ldx LEN_FNAM
  beq DICM_ERR
  ldy #0
DICM_2
  lda (PTR_FNAM),y
_relo0305 = . +1
  jsr IECOUT
  iny
  dex
  bne DICM_2
DICM_ERR
_relo0306 = . +1
  jmp UNLISTEN


DISK_LISTEN
  pha
  lda #0
  sta IECSTAT
  beq DILI_2

DISK_LISTEN_2
  pha
DILI_2
  lda SY_DN                             ; device#
_relo0307 = . +1
  jsr LISTEN
  pla
_relo0308 = . +1
  jmp LISTENSA


DISK_TALK
  pha
  lda #0
  sta IECSTAT

  lda SY_DN                             ; device#
_relo0309 = . +1
  jsr TALK
  pla
_relo0310 = . +1
  jmp TALKSA


DISK_CLOSE_SA
  lda #$e1
  bne DICL_1

DISK_CLOSE
  lda #$e0
DICL_1
_relo0101 = . +1
  jsr DISK_LISTEN_2
_relo0311 = . +1
  jmp UNLISTEN


; PRINT DISK STATUS TO SCREEN
PRINT_DISK_STAT
_relo0102 = . +1
  jsr GET_DISK_STAT
PRINT_BIP
  ldy #0
PRDI_2
  lda BIP,y
  beq PRDI_7
  jsr BSOUT
  iny
  bne PRDI_2
PRDI_7
  tya
  beq PRDI_E
  ;lda #13
  ;jsr BSOUT
PRDI_E
  rts


; PRINT DISK STATUS TO SCREEN IF ERROR
PRINT_DISK_ERR
_relo0103 = . +1
  jsr GET_DISK_STAT
  bne PRINT_BIP
  rts



; LOAD DISK STAT TO BIP
GET_DISK_STAT
  lda #0
  sta IECSTAT
;  lda #8                                ; device#
;  jsr TALK
  lda #$6f                              ; channel
_relo0104 = . +1
  jsr DISK_TALK

  ldy #0
DIST_2
_relo0312 = . +1
  jsr IECIN
  sta BIP,y
  iny
  lda IECSTAT
  beq DIST_2

_relo0313 = . +1
  jsr UNTALK
  tya
  beq DIST_7
  lda #13
  cmp BIP,y
  bne DIST_7
  sta BIP,y
  iny
DIST_7
  lda #0
  sta BIP,y
  lda BIP
  cmp #"0"
  bne DIST_E
  eor BIP +1
  beq DIST_E
  cmp #1
DIST_E
  rts






; ==============================================================
; DISK CATALOG
; ==============================================================

  ;DISK CATALOG       :: +$"fil"
PRINT_CATALOG
  lda #$f0                              ; channel
_relo0110 = . +1
  jsr DISK_LISTEN
  lda #"$"
_relo0314 = . +1
  jsr IECOUT
_relo0111 = . +1
  jsr IECNAMOUT

  lda #$60
_relo0112 = . +1
  jsr DISK_TALK

;PRINT HEADLINE (DISKNAME)

  ldx #6
_relo0113 = . +1
  jsr PRCA_SKIP_X                       ; skip x bytes

;PRCA_1
_relo0114 = . +1
  jsr PRCA_SKIPSPC                      ; skip spaces

  cmp #18                               ; check for reverse on char (Disk Name, first row only)
  bne PRCA_EE

_relo0115 = . +1
  jsr CHROUT                            ; here on first row only (Disk Name)
_relo0315 = . +1
  jsr IECIN                             ; skip a char (")

_relo0116 = . +1
  jsr PRCA_QSTR1                        ; PRINT QUOTED STRING

  ldx #19
_relo0117 = . +1
  jsr PRCA_SPCOL                        ; print spaces up to column
_relo0118 = . +1
  jsr PRCA_SKIPSPC                      ; skip spaces

_relo0119 = . +1
  jsr CHROUT                            ; ID1
_relo0316 = . +1
  jsr IECIN
_relo0120 = . +1
  jsr CHROUT                            ; ID2

;PRINT STD. LINE (FILE)

PRCA_4
_relo0317 = . +1
  jsr IECIN
  tax
  bne PRCA_4

PRCA_5
  lda dir_current_key
  cmp #24                               ; check for RUN-STOP key
  beq PRCA_STOP

  lda dir_shift_ctrl_cbm_flag
  and #2                                ; filter commodore key (Bit 2)
  bne PRCA_5

_relo0135 = . +1
  jsr CROUT                             ; CR

  ldx #2
_relo0121 = . +1
  jsr PRCA_SKIP_X                       ; skip x bytes

  lda IECSTAT
  bne PRCA_E

_relo0318 = . +1
  jsr IECIN
  tax                                   ;LO
  ;sta PT3
_relo0319 = . +1
  jsr IECIN
  ;ldx PT3
  jsr PRNINT                            ;print integer in X/A

_relo0122 = . +1
  jsr PRCA_SKIPSPC
  cmp #34
  bne PRCA_8
  pha
  ldx #2
_relo0123 = . +1
  jsr PRCA_SPCOL                        ; print spaces up to column
  pla
_relo0124 = . +1
  jsr PRCA_QSTR1                        ; PRINT QUOTED STRING

  ldx #20
_relo0125 = . +1
  jsr PRCA_SPCOL                        ; print spaces up to column

_relo0126 = . +1
  jsr PRCA_SKIPSPC
_relo0127 = . +1
  jsr CHROUT                            ; FILETYP
  clv
  bvc PRCA_4



PRCA_8
  pha
_relo0128 = . +1
  jsr SPCOUT                            ; BLANK
  pla
PRCA_9
_relo0129 = . +1
  jsr CHROUT                            ;
_relo0320 = . +1
  jsr IECIN
  tax
  bne PRCA_9

PRCA_STOP
_relo0130 = . +1
  jsr CROUT                             ; CR
PRCA_E
PRCA_EE
_relo0321 = . +1
  jsr UNTALK
_relo0131 = . +1
  jmp DISK_CLOSE



; SKIP SPACE
PRCA_SKIPSPC
_relo0322 = . +1
  jsr IECIN
  cmp #32                               ;spaces
  beq PRCA_SKIPSPC
  rts

; SKIP X BYTES
PRCA_SKIP_X
_relo0323 = . +1
  jsr IECIN
  dex
  bne PRCA_SKIP_X
  rts

; PRINT QUOTED STRING
PRCA_QSTR1
_relo0132 = . +1
  jsr CHROUT                            ; else print character in A
PRCA_QSTR2
  ldy #17
PRCAQS_2
_relo0324 = . +1
  jsr IECIN
_relo0133 = . +1
  jsr CHROUT                            ; else print character in A
  cmp #34                               ; check for "quote" char
  beq PRCAQS_E
  dey
  bne PRCAQS_2
PRCAQS_E
  rts


PRCA_SP_1
_relo0134 = . +1
  jsr SPCOUT

; PRINT SPACE UP TO COL
PRCA_SPCOL
  cpx C_COL
  bcs PRCA_SP_1
  rts








; ==============================================================
; DISPLAY STRING    in AC/YR
; ==============================================================

STROUT
  sta PT1
  sty PT1 +1
  ldy #0
  ;sty 658                         ;Scroll Flag
  ;dey
STOU_1
  lda (PT1),y
  beq STOU_E
_relo0140 = . +1
  jsr CHROUT
  iny
  bne STOU_1
STOU_E
  rts


; ==============================================================
; DISPLAY STRING AT POS   in AC/YR
; ==============================================================

STR_AT
  sta PT1
  sty PT1 +1
  ldy #0
  lda (PT1),y
  tax
  iny
  lda (PT1),y
  tay
_relo0143 = . +1
  jsr SET_CURSOR
  ldy #2
  bne STOU_1


; ==============================================================
; DELETE LINE      XR=Row
; ==============================================================

DEL_LINE
_relo0144 = . +1
  jsr SET_CURSOR
  ldy #21
  lda #32
DELI_2
  sta (C_LINE),y
  dey
  bpl DELI_2
  rts


; ==============================================================
; SET CURSO POS          XR=Row, YR=Col
; ==============================================================

SET_CURSOR
  clc
  jmp CURSOR_POS


; ==============================================================
; DISPLAY CHAR
; ==============================================================


SPCOUT2
_relo0141 = . +1
  jsr SPCOUT
SPCOUT
  lda #32
  bne CHROUT

CROUT
  lda #13
  bne CHROUT

CHROUT2
_relo0142 = . +1
  jsr CHROUT
  txa
CHROUT
  pha
  sta $d7
  txa
  pha
  tya
  pha
  lda $d7
  bmi CHOU_7
  cmp #$20
  bcs CHOU_1
  jmp $e756

CHOU_1
  cmp #$60
  bcc CHOU_2
  and #$df
  bne CHOU_3
CHOU_2
  and #$3f
CHOU_3
  ldx $c7                           ;revers?
  beq CHOU_4
  ora #$80
CHOU_4
  ldx $0286                         ;Farbcode
  jsr $eaa1                         ;Zeichen ausgeben
  lda $d3
  cmp #$15
  beq CHOU_5
  inc $d3
CHOU_5
  pla
  tay
  pla
  tax
  pla
  rts

CHOU_7
  and #$7f
  cmp #$20
  bcs CHOU_8
  jmp $e82a
CHOU_8
  ora #$40
  bne CHOU_3

PUTCHR
  pha
  jsr $eab2                         ;zeiger in color RAM
  pla
PUTCHR2
  ldy C_COL
PUTCHR3
  sta (C_LINE),y
  lda $0286                         ;Farbcode
  sta (C_COLP),y
  rts



; ==============================================================
; CONVERT CHAR TO VRAM CODE       C=1:CTRL CHAR
; ==============================================================

CONVCHR
  STA C_CHR

  and #$7f
  cmp #$20
  bcc COCHO_9
  ldx C_CHR
  bpl COCHO_1
  ora #$40
  bne COCHO_3

COCHO_1
  cmp #$60
  bcc COCHO_2
  and #$df
  bne CHOU_3
COCHO_2
  and #$3f
COCHO_3
  ldx $c7                           ;revers?
  beq COCHO_4
  ora #$80
COCHO_4
  sec
COCHO_9
  rts


; ==============================================================
; EVALUATE NEXT FORMULA ELEMENT
; ==============================================================

MY_FRMELEM
  lda #0
  sta $0d
  jsr CHRGET
  cmp #"$"
  beq MYFR_HEX
  cmp #"%"
  beq MYFR_BIN

  jsr CHRGOT
  jmp $ce8d                             ; ORIGINAL PROC


MYFR_HEX
_relo0150 = . +1
  jsr GETHEX                            ; GET HEX NUMBER A=HI, X=LO, C=0:error
  bcc ERR_TYPMIS

AXFAC
  stx FAC +2
  sta FAC +1
AXFAC_1
  ldx #$90
  sec
  jmp $dc49


MYFR_BIN
  ldx #16
  lda #0
  sta FAC+1
  sta FAC+2

MYBI_1
  jsr CHRGET
  cmp #"1"
  beq MYBI_2
  cmp #"0"
  bne MYBI_4
  clc
MYBI_2
  rol FAC+2
  rol FAC+1
  dex
  bne MYBI_1
  jsr CHRGET
MYBI_3
_relo0151 = . +1
  jmp AXFAC_1

MYBI_4
  txa
  and #19
  beq MYBI_3

ERR_TYPMIS
  ldx #$16
  jmp $c437                             ; ERROR


; ==============================================================
; CONVERT VALUES BETWEEN HEX/BIN
; ==============================================================

GETADR                                    ; GET HEX NUMBER A=HI, X=LO, C=0:error
  jsr CHRGOT
  cmp #"$"                                ; HEX VALUE
  beq GETHEX
  clc
  rts


  ; GET WORD VALUE IN Y/A AND (PT3)
FRMWORD2
_relo0160 = . +1
  jsr CHKCOM
  bcs FRWO_3
FRMWORD
  jsr FRMNUM
  jsr CNVWORD
  clc
FRWO_3
  rts


CHKCOM
  jsr CHRGOT
  cmp #$2c                                ; ","
  sec
  bne CHCO_3
  jsr CHRGET
  clc
CHCO_3
  rts




GETHEX                                    ; GET HEX NUMBER A=HI, X=LO, C=0:error
  jsr CHRGET

HEX_0
_relo0170 = . +1
  jsr HEXBYTE
  bcc HEX_E
  pha
  jsr CHRGET
_relo0171 = . +1
  jsr HEXBYTE
  bcs HEX_2
  pla
  tax
  lda #0
  beq HEX_3

HEX_2
  tax
  jsr CHRGET
  pla
HEX_3
  sec
HEX_E
  rts

HEXBYTE
  jsr CHRGOT
_relo0172 = . +1
  jsr HEXCHAR
  bcc HEBY_E
_relo0173 = . +1
  jsr ASCBYTE
  asl
  asl
  asl
  asl
  sta FAC
  jsr CHRGET
_relo0174 = . +1
  jsr HEXCHAR
  bcc HEBY_E
_relo0175 = . +1
  jsr ASCBYTE
  ora FAC
  sec
HEBY_E
  rts

HEXCHAR
  bcc HECH_2
  cmp #65                                 ; "A"
  bcc HECH_E
  sbc #91
  sec
  sbc #165
HECH_E
  rts
HECH_2
  sec
  rts

ASCBYTE
  cmp #58
  php
  and #15
  plp
  bcc ASBY_E
  adc #8
ASBY_E
  rts



; ==============================================================
; PRINT WORD VALUE BETWEEN HEX/BIN
; ==============================================================
PRINT_VALUE
_relo0180 = . +1
  jsr SPCOUT
  ldx PT3
  lda PT3 +1
_relo0181 = . +1
  jsr HEXOUT

_relo0182 = . +1
  jsr SPCOUT2
  ldx PT3
  lda PT3 +1
  jsr PRNINT                            ;print integer in X/A

_relo0184 = . +1
  jsr SPCOUT2
  ldx PT3
  lda PT3 +1
_relo0185 = . +1
  jsr ASCOUT

_relo0186 = . +1
  jsr CROUT
_relo0187 = . +1
  jsr SPCOUT
  ldx PT3
  lda PT3 +1
_relo0188 = . +1
  jsr BINOUT
_relo0189 = . +1
  jmp CROUT



;------------ PRINT HEX VALUE IN  X/A
HEXOUT
  pha
  lda #"$"
  jsr BSOUT
  pla
  beq HEX0
_relo0200 = . +1
  jsr HEX2
HEX0
  txa
HEX2
  pha
  lsr
  lsr
  lsr
  lsr
_relo0201 = . +1
  jsr HEX1
  pla
  and #15
HEX1
  clc
  adc #246
  bcc HEX1_2
  adc #6
HEX1_2
  adc #58
  jmp BSOUT




;------------ PRINT BIN VALUE IN  X/A
BINOUT
  pha
  lda #"%"
  jsr BSOUT
  pla
  beq BIN0
_relo0211 = . +1
  jsr BIN2
BIN0
  txa
BIN2
  ldy #8
BIN2a
_relo0212 = . +1
  jsr BIN1
  dey
  bne BIN2a
  rts

BIN1
  asl
  pha
  lda #"0"
  bcc BIN1a
  lda #"1"
BIN1a
  jsr BSOUT
  pla
  rts




;------------ PRINT ASC VALUE IN  X/A
ASCOUT
  pha
  txa
  tay
  lda #34
_relo0220 = . +1
  jsr CHROUT
  pla
  beq ASC0
_relo0221 = . +1
  jsr ASC2
ASC0
  tya
ASC2
  ldx #0
  stx C_CTRL
  tax
  and #127
  cmp #32
  bcc ASC1_1

  lda #RVSOFF
  bne ASC1_2

ASC1_1
  txa
  clc
  adc #64
  tax
  lda #RVSON
ASC1_2
_relo0222 = . +1
  jmp CHROUT2




; ==============================================================
; TOKENIZER                   X=Token#, 0=no token found
; ==============================================================

TOKENIZER
  jsr CHRGOT
_relo5230 = . +1
  lda #<TOKEN
  ldx #>TOKEN
  sta PT3
  stx PT3 +1

  ldx #1
TOZE_1
  ldy #0
TOZE_2
  lda (PT3),y
  beq TOZE_10
  sec
  sbc (CHRPTR),y
  beq TOZE_3
  cmp #$80
  beq TOZE_10

  ;NEXT TOKEN
TOZE_8
  iny
  lda (PT3),y
  bne TOZE_8

  tya
  sec
  adc PT3
  sta PT3
  bcc TOZE_9
  inc PT3 +1
TOZE_9
  inx
  bne TOZE_1

TOZE_3
  iny
  bne TOZE_2

  ;TOKEN FOUND?
TOZE_10
  tya
  beq TOZE_11

  ;TOKEN FOUND!
_relo0230 = . +1
  jsr ADD_CHRPTR                        ;SET CHRPTR AFTER TOKEN
  txa
_relo0231 = . +1
  lda TOKEN_TAB -1,x
TOZE_11
  tax
TOZE_E
  rts

NEXT_STATEMENT
  jsr CHRGET
  bne NEXT_STATEMENT                    ;SEARCH NEXT STATEMENT
  rts







;-------- SWITCH CARTRIDGE AND RESET SYSTEM

VIC    = $9000
VIA1   = $9110
VIA2   = $9120

RESET_SYSTEM
  pha
  txa
  pha

  ldy #(__SET_IO_RESET_E - __SET_IO_RESET)
_relo5250 = . +1
  ldx #<__SET_IO_RESET
  lda #>__SET_IO_RESET
_relo0250 = . +1
  jsr COPY_PROC

_relo0251 = . +1
  jsr RESET_IO

  pla
  tax
  pla
  jmp BIP

;-------- COPY PROCEDURE TO BIP AND EXECUTE
COPY_PROC
  sta PT1 +1
  stx PT1
COPR_2
  lda (PT1),y
  sta BIP,y
  dey
  bpl COPR_2
  rts




;-------- RAM PROCEDURE TO SWITCH CARTRIDGE AND RESET
__SET_IO_RESET
  sta IO_FINAL
  stx IO_FINAL +1
  jmp SOFT_RESET
__SET_IO_RESET_E





RESET_IO
  sei
  lda #$00
  sta VIA1 +$02                         ; DDRA
  sta VIA1 +$03                         ; DDRB
  sta VIA2 +$02                         ; DDRA
  sta VIA2 +$03                         ; DDRB

  lda #$7f
  sta VIA1 +$0e                         ; IER: clear all bits
  sta VIA2 +$0e                         ; IER: clear all bits
  rts



; ==============================================================
; JIFFY PROCS
; ==============================================================

;--------------JIFFY LISTEN
JIF_TALK
  ORA #$40
  .byte $2c
JIF_LISTEN
  ORA #$20
  JSR $F160                             ;SET TIMER
lEE1C
  PHA
  BIT $94
  BPL l6E2B
  SEC
  ROR $A3
_relo0361 = . +1
  JSR lfc41                             ;NEW BYTE OUT
  LSR $94
  LSR $A3
l6E2B
  PLA
  STA $95

  ;JSR lF19A                            ;NEW DAV hi
  SEI
  LDA #$00
  STA $A3
  JSR $E4A0                             ;DAV hi

  CMP #$3F
  BNE l6E38
  JSR $EF84                             ;NDAC lo
l6E38
  LDA $911F
  ORA #$80
  STA $911F
lEE40
  JSR $EF8D                             ;PCR BIT 1 LÖSCHEN
  JSR $E4A0
  JSR $EF96
  ;jmp $ee49                            ;ORIG BYTE OUT

OLD_IECOUT
  SEI
  JSR $E4A0                             ;DAV lo
  JSR $E4B2                             ;NRFD hi
  LSR
  BCS l6EB4                             ;err DEV NOT PRES

  JSR $EF84                             ;NDAC lo
  BIT $A3
  BPL l6E66
l6E5A
  JSR $E4B2                             ;NRFD hi
  LSR
  BCC l6E5A
l6E60
  JSR $E4B2                             ;NRFD hi
  LSR
  BCS l6E60
l6E66
  JSR $E4B2                             ;NRFD hi
  LSR
  BCC l6E66
  JSR $EF8D                             ;PCR BIT 1 LÖSCHEN

  TXA
  PHA
  LDX #$08                              ;8 BIT

l6E73
  LDA $911F
  AND #$02
  BNE l6E7F
  PLA
  TAX
  JMP $EEB7                             ;ERR TIMEOUT

l6E7F
  JSR $E4A0                             ;DAV hi
  ROR $95
  BCS l6E89
  JSR $E4A9                             ;DAV lo
l6E89
  JSR $EF84                             ;NDAC lo
  LDA $912C
  AND #$DD
  ORA #$02
  PHP
  PHA
_relo0350 = . +1
  JSR lF96E
  PLA
  PLP
  DEX
  BNE l6E73

  PLA
  TAX
  jmp $EEA0
;  NOP
;lEEA5
;  LDA #$04
;  STA $9129
;l6EA5
;  LDA $912D
;  AND #$20
;  BNE l6EB7
;  JSR $E4B2
;  LSR
;  BCS l6EA5
;  CLI
;  RTS

l6EB4
  jmp $eeb4                             ;err DEV NOT PRES

l6EB7
  jmp $eeb7                             ;err TIME OUT


lF96E
  STA $912C
  BIT $911F
  BPL lF997
  CPX #$02
  BNE lF997
  LDA #$02
  LDX #$20
lF97E
  BIT $911F
  BEQ lF988
  DEX
  BNE lF97E
  BEQ lF995
lF988
  BIT $911F
  BEQ lF988
  LDA $95
  ROR
  ROR
  ORA #$40
  STA $A3
lF995
  LDX #$02
lF997
  rts





;--------------JIFFY BYTE IN
JIF_IECIN
lfbe0                                   ;NEW BYTE IN??
  sei
  bit $a3
  bvs l7be5
  LDA #$00
  JMP $EF1C                             ;ORIG BYTE IN

JIFFY_IN
l7be5
  LDA $911F
  AND #$03
  BEQ l7be5
  LDA #$80
  STA $9C
  TXA
  PHA
  PHA
  PLA
  PHA
  PLA
  LDA $912C
  AND #$DD
  STA $912C
  ORA #$20
  TAX
  BIT $9C
  BIT $9C
  BIT $9C
  LDA $911F
  ROR
  ROR
  NOP
  AND #$80
  ORA $911F
  ROL
  ROL
  STA $B3
  LDA $911F
  ROR
  ROR
  AND #$80
  NOP
  ORA $911F
  ROL
  ROL
  STA $C0
  LDA $911F
  STX $912C
  STA $9C
_relo0351 = . +1
  JSR lEC4E                             ;BYTE AUS 2 NIBBLES

  STA $A4
  PLA
  TAX
  LDA $9C
  ROR
  ROR
  BPL l7C54
  BCC lfC4f
  LDA #$42
  JMP $EEB9                             ;ERR STATUS, UNLISTEN
;--------------JIFFY BYTE IN


;--------------JIFFY BYTE OUT
JIF_IECOUT
  BIT $94
  BMI lEEED
  SEC
  ROR $94
  BNE lEEF2
lEEED
  PHA
_relo0352 = . +1
  JSR NEW_IECOUT
  PLA
lEEF2
  STA $95
  CLC
  RTS


NEW_IECOUT
lfc41                                   ;NEW BYTE OUT
  sei
  bit $a3
  bvs lfc59
  LDA $A3
  CMP #$A0
  BCS lfc59
_relo0353 = . +1
  JMP OLD_IECOUT
  ;JMP $EE49                             ;ORIG BYTE OUT

lfC4f
  LDA #$40
  JSR $FE6A                             ;SET STATUS
l7C54
  LDA $A4
l7C56
  CLI
  CLC
  RTS


JIFFY_OUT
lfc59                                   ;JIFFY BYTE OUT
  TXA
  PHA
  LDA $95
  LSR
  LSR
  LSR
  LSR
  TAX
_relo0354 = . +1
  LDA lFCCE,X
  PHA
  TXA
  LSR
  LSR
  TAX
_relo0355 = . +1
  LDA lFCCE,X
  STA $B3
  LDA $95
  AND #$0F
  TAX
  LDA #$02
l7C76
  BIT $911F
  BEQ l7C76

  LDA $912C
  AND #$DD
  STA $9C
  PHA
  PLA
  PHA
  PLA
  NOP
  NOP
  NOP
  STA $912C
  PLA
  ORA $9C
  NOP
  STA $912C
  LDA $B3
  ORA $9C
  ORA $9C
  STA $912C
_relo0356 = . +1
  LDA lFBBA,X
  ORA $9C
  NOP
  STA $912C
_relo0357 = . +1
  LDA lF39E,X
  ORA $9C
  NOP
  STA $912C
  NOP
  AND #$DD
  BIT $A3
  BMI l7CB7
  ORA #$02
l7CB7
  STA $912C
  PLA
  TAX
  NOP
  LDA $9C
  ORA #$02
  STA $912C
  LDA $911F
  AND #$02
  BEQ l7C56
  JMP $EEB7                             ; err TIME OUT
;--------------JIFFY BYTE OUT



;--------------BAUT EIN BYTE AUS 2 NIBBLES ZUSAMMEN
lEC4E
  LDA $B3
  AND #$0F
  STA $B3
  LDA $C0
  ASL
  ASL
  ASL
  ASL
  ORA $B3
  RTS
;--------------JIFFY BYTE IN



;--------------JIFFY UNTALK/UNLISTEN
JIF_UNTALK
lEEF6
  LDA $911F
  ORA #$80                              ;ATN ausgeben
  STA $911F
  JSR $EF8D
  LDA #$5F
  .byte $2c
JIF_UNLISTEN
  LDA #$3F
_relo0358 = . +1
  JSR lEE1C                             ;PART OF LISTEN
  JSR $EEC5
  TXA
  LDX #$0B
lEF0F
  DEX
  BNE lEF0F
  TAX
  JSR $EF84
  JMP $E4A0
;--------------JIFFY UNTALK/UNLISTEN



;--------------JIFFY TALK SA
JIF_TALKSA
  STA $95
_relo0359 = . +1
  JSR lEE40
  jmp $eed3
;--------------JIFFY TALK SA


;--------------JIFFY LISTEN SA
JIF_LISTENSA
  STA $95
_relo0360 = . +1
  JSR lEE40
  jmp $eec5
;--------------JIFFY LISTEN SA






;--------------JIFFY DATA TABLE
lFCCE
  .byte $00,$02,$20,$22,$00,$02,$20,$22,$00,$02,$20,$22,$00,$02,$20,$22

lFBBA
  .byte $00,$00,$20,$20,$00,$00,$20,$20,$02,$02,$22,$22,$02,$02,$22,$22

lF39E
  .byte $00,$20,$00,$20,$02,$22,$02,$22,$00,$20,$00,$20,$02,$22,$02,$22
;--------------JIFFY DATA TABLE





; ==============================================================
; LOADER TEXTE AND TOKEN TABLE
; ==============================================================

TOK_NOIO = 1
TOK_BLKP = TOK_NOIO +1
TOK_BLKD = TOK_NOIO +2
TOK_RES  = TOK_NOIO +3
TOK_RELO = TOK_NOIO +4
TOK_RUN  = TOK_NOIO +5
TOK_SYS  = TOK_NOIO +6
TOK_OLD  = TOK_NOIO +7
TOK_OFF  = TOK_NOIO +8
TOK_KILL = TOK_NOIO +9



TOKEN
  dc.b "NOIO",0,"BLKD",0,"BLKP",0,"BLK",0
MSG_RES
  dc.b "RESET",0
  dc.b "OFF",0
  dc.b "KILL",0
  dc.b "OLD",0
  dc.b "UNNEW",0
  dc.b "RE",$93,0                       ; RELOAD
  dc.b $8a,0                            ; RUN
  dc.b $9e,0                            ; SYS
  dc.b 0                                ; ::END

TOKEN_TAB
  dc.b TOK_NOIO,TOK_BLKD,TOK_BLKP,TOK_BLKP,TOK_RES,TOK_OFF,TOK_KILL,TOK_OLD,TOK_OLD
  dc.b TOK_RELO,TOK_RUN,TOK_SYS






; ==============================================================
; MESSAGE TEXTE
; ==============================================================


MSG_LOADERR
  dc.b "LOAD ERROR",13,0
MSG_LOADAT
  dc.b " FROM ",0
MSG_LOADTO
  dc.b " TO ",0

MSG_DEVICE
  dc.b "DEVICE#",0


MSG_PRINTIO
  dc.b "IO=",0
MSG_NOIO
  dc.b "IO DISABLED",13,0



WEDGEMESSAGE1b
  dc.b $11, RED, "FE3 WEDGE (", 0
WEDGEMESSAGE1c
  dc.b "OFF)",BLUE,13,0




; ==============================================================
; RELOCATOR TABLE
; ==============================================================

;  org $be00


RELO_TAB                                ;RELOC TABLE - 2 BYTE OFFSET LOW/HI
  dc.w _relo0000
  dc.w _relo0001,_relo0002;,_relo0003
  dc.w _relo0010,_relo0011,_relo0012,_relo0013,_relo0014,_relo0015,_relo0016
  dc.w _relo0020,_relo0021,_relo0022,_relo0023,_relo0024,_relo0025,_relo0026
  dc.w _relo0030,_relo0031,_relo0032,_relo0033,_relo0034,_relo0035,_relo0036,_relo0037,_relo0038,_relo0039
  dc.w _relo0040,_relo0041,_relo0042
  dc.w _relo0050
  dc.w _relo0060,_relo0061
  dc.w           _relo0071,_relo0072
  dc.w _relo0080,_relo0081,_relo0082,_relo0083,_relo0084,_relo0085,_relo0086,_relo0087,_relo0088,_relo0089
  dc.w _relo0090,_relo0091,_relo0092,_relo0093,_relo0094,_relo0095,_relo0096
  dc.w _relo0100,_relo0101,_relo0102,_relo0103,_relo0104
  dc.w _relo0110,_relo0111,_relo0112,_relo0113,_relo0114,_relo0115,_relo0116,_relo0117,_relo0118,_relo0119
  dc.w _relo0120,_relo0121,_relo0122,_relo0123,_relo0124,_relo0125,_relo0126,_relo0127,_relo0128,_relo0129
  dc.w _relo0130,_relo0131,_relo0132,_relo0133,_relo0134,_relo0135
  dc.w _relo0140,_relo0141,_relo0142,_relo0143,_relo0144
  dc.w _relo0150,_relo0151
  dc.w _relo0160
  dc.w _relo0170,_relo0171,_relo0172,_relo0173,_relo0174,_relo0175
  dc.w _relo0180,_relo0181,_relo0182,          _relo0184,_relo0185,_relo0186,_relo0187,_relo0188,_relo0189
  dc.w _relo0200,_relo0201
  dc.w _relo0211,_relo0212
  dc.w _relo0220,_relo0221,_relo0222
  dc.w _relo0230,_relo0231
  dc.w _relo0250,_relo0251
  dc.w _relo0300,_relo0301,_relo0302,_relo0303,_relo0304,_relo0305,_relo0306,_relo0307,_relo0308,_relo0309
  dc.w _relo0310,_relo0311,_relo0312,_relo0313,_relo0314,_relo0315,_relo0316,_relo0317,_relo0318,_relo0319
  dc.w _relo0320,_relo0321,_relo0322,_relo0323,_relo0324 ;,_relo0325,_relo0326,_relo0327,_relo0328,_relo0329
  dc.w _relo0350,_relo0351,_relo0352,_relo0353,_relo0354,_relo0355,_relo0356,_relo0357,_relo0358,_relo0359
  dc.w _relo0360,_relo0361
  dc.w _relo0400,_relo0401,_relo0402,_relo0403,_relo0404,_relo0405,_relo0406,_relo0407,_relo0408,_relo0409
  dc.w _relo0410;,_relo0411,_relo0412,_relo0413,_relo0414,_relo0415,_relo0416,_relo0417,_relo0418,_relo0419
  dc.w 0

  dc.b 2                                ;RELOC TABLE - 2 BYTE OFFSET LOW/HI
  dc.w _relo5000,_relo5001,_relo5002,_relo5003
  dc.w _relo5010,_relo5011,_relo5012,_relo5013
  dc.w _relo5070
  dc.w _relo5090,_relo5091
  dc.w _relo5230
  dc.w _relo5250
  dc.w 0
  dc.b 0


MY_WEDGE_END




  org $bfff
  dc.b #$00
