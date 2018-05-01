# Final Expansion Documentation - technology and programming

Original German by Diddl

Translated by Vic20-Ian

Edited by ops



The Final Expansion contains 512KB SRAM and 512KB Flash memory. In order to
access the expanded memory one has to enable it sequentially. This is due to
the constraints of the address range of the 6502 processor which can only see
64KB at any time. On the Vic-20 the free address space is constrained to
4 x 8KB + 3KB (See memory map):


Registers:

The Final Expansion has 2 registers in order to configure it through software.
The registers are accessed like memory addresses and can be read from (PEEKed)
and written too (POKEed). The registers have 8 bits as for other memory
addresses. After a Hard Reset or after switching on the Vic20, both registers
contain Zero.

Register 1 ($9c02):

With Register 1 the MODE of the Final Expansion can be selected. The Register
is located at address 39938 ($9c02). Values are written to the register with
POKE 39938,x. Values are read from the Register with PEEK(39938).

The highest 3 bits (Bit 5,6 and 7) control the usage mode of the Final
Expansion. The lowest 5 bits (Bit 0,1,2,3 and 4) provide additional information
the selected mode of use. It is possible to build a value for the register
using AND and OR logic and then poke the resulting number to the Register.
(Register 1: MMMIIIII).

M - Mode of Use
I - Additional Information

Register 2 ($9c03):

With Register 2 the RESOURCES of Final Expansion can be enabled or disabled.
The Register is located at 39939 ($9c03). Values are written to the register
with POKE 39939,Y. Values are read from the Register with PEEK(39939).

The Vic-20 has 5 free address ranges (memory blocks). The Final expansion can
make these 5 blocks available independently. This means the Final Expansion
memory can be made available in one or more blocks to the Vic-20 (Banking)

The lower 5 bits (Bit 0,1,2,3 and 4) of Register 2 control the visibility of
the 5 memory blocks in the Vic-20. A 0 switches the relevant block on and a 1
swiches it off. The configuration of individual blocks is needed to enable
compatibility with other expansion modules.

The highest bit (Bit 7) of Register 2 controls the visibility of the Registers
themselves. A 0 makes the Registers visible, a 1 hides the Registers
(Deactivates the Registers)

ATTENTION: if the Registers are deactivated then it is no longer possible for
the software to alter the memory configuration. Only after a Reset will the
Register become visible again.

Disabling these Registers is used to prevent new software from altering the
configuration of the Final Expansion without intention. With this facility the
compatibility of the Final Expansion with any conceivable software is ensured.

Bit 0 ... Visibility of the Vic-20 memory block 0 (Blk0 - $0400-$0FFF)
Bit 1 ... Visibility of the Vic-20 memory block 1 (Blk1 - $2000-$3FFF)
Bit 2 ... Visibility of the Vic-20 memory block 2 (Blk2 - $4000-$5FFF)
Bit 3 ... Visibility of the Vic-20 memory block 3 (Blk3 - $6000-$7FFF)
Bit 4 ... Visibility of the Vic-20 memory block 05 (Blk5 - $A000-$BFFF)
Bit 5 ... 1: invert A13
Bit 6 ... 1: invert A14
Bit 7 ... Visibility of IO-3 (Register 1 und 2)

Banking:

In order to access the full memory of the Final Expansion, the memory must be
switched on in stages. In order to achieve this, a number of modes are
available for use in order to cover every requirement.

Final Expansion Modes of use:

•START MODE (000zzzzz):

After a reset with the red button or after initial power on, all the bits in
the register are set to zero, in this way the FE is always in START MODE after
a reset With POKE 39938,0 the START MODE can be activated from software.

Write operations to the FE memory go to RAM in Bank 1.

The 0 Block of the Vic 20 (3k expansion) is disabled.

The START MODE of Final Expansion is provided for maximum compatibility with
other modules. In order to avoid possible incompatibility with other expansion
modules, The Final Expansion controls only Block 5
(Memory range $A000 - $BFFF). Block 5 must be active, otherwise the firmware of
the Final Expansion itself cannot be automatically started.

Because the Final Expansion in START MODE only uses block 5, one can simply
deactivate the FE by disconnecting the BLK5 circuit path. (e.g. with a switch).
N.B. This would require a modification to the Final Expansion or the Vic-20
expansion port.

The registers are deactiviated in START MODE, the Lockbit serves as a control
for this. The lockbit functions only in START MODE in order to avoid
incompatibility with other modules that may use the same addresses as Final
Expansion for registers.

The lockbit can be cleared via a POKE to Block 5. A PEEK resets the lockbit
again. This way programs in Block 5 cannot write to an FE register as long as
the FE is in START MODE.

In START MODE only block 5 is controlled.
Read operations are from the Flash at address $6000 (Flash Block 3, highest
block of the first 32k bank - Bank 0). Write operations always go to SRAM. This
way the whole firmware can be simply copied to SRAM. Write operations to
Block 5 go to SRAM address $E000 (SRAM Block 7, highest block of the second 32k
bank - Bank 1). If the SRAM 1 mode is switched to, the SRAM Block 7 lies
exactly in Block 5 of the Vic-20.

•SUPER ROM MODE (010zzzzz):

With Poke 39938,64 the flash memory of the Final Expansion is enabled.

Read operations come from the ROM (Flash) i.e. from the selected Bank.

Write operations go to the RAM in Bank 1.

The Block 0 of the Vic-20 (3k expansion) is enabled.

The 512KB of the Flash are divided into 16 pages of 32KB, any one of which can
be selected for access. These 32KB are further divided into 8KB pieces and are
assigned to the addresses $2000 (Blk 1), $4000 (Blk 2), $6000 (Blk 3) and $A000
(Blk 5).

The additional information in the Register (zzzzz) select the relevant 32KB
block of the Flash memory,
In 512KB there are 16 x 32KB pages. The additional register values can
therefore take the values 0 to 15. Readers will notice that the additional
register information can hold 5 bits or 32 values.
Correct, the Final Expansion can also address 1MB chips. However,
these are not available to buy in DIL packages, therefore this cannot be used.

• RAM 1 MODE (100zzzzz):

With POKE 39938,128 the SRAM of the Final Expansion is activated.

Read operations are always from RAM Bank 1.

Write operations go to RAM Bank 1 or optionallt to Bank 2.

The Block 0 of the Vic-20 (3K Expansion) is switched on. The Bit 0 of Register
1 controls the write protection. There is up to 35KB of SRAM available to
configure (4 x 8KB + 3KB) at the addresses $0400 (Blk 0), $2000 (Blk 1),
$4000 (Blk 2), $6000 (Blk 3) and $A000 (Blk 5). The 3KB expansion (Vic-20
Blk 0) comes from Bank 0 (The first 32KB in SRAM) of the SRAM. The four 8KB
blocks in the Vic-20 (Blk 1 - Blk 5) come from Bank 1 (The second 32KB in SRAM)
of the SRAM. This way all the addressable space in the Vic-20 is filled with
RAM and therefore the maximum expansion with memory is achieved.

The additional information bits in Register 1 (zzzzz) control the write access
to the RAM blocks. Bit 4 controls Blk 5, Bit 3 Controls Blk 3, Bit 2 Controls
Blk 2, Bit 1 Controls Blk 1 and Bit 0 Controls Blk 0. If the Bit is set to 0
then the RAM Block 0 can only be read not written. (1: write protection = on???
Off??? The bits for Blocks 1 to 5 control the target for the write operation.
If the bit is not set (0) then the write operation is to Bank 1 of the RAM. If
the Bit is set to (1) then the write operation is to Bank 2 of the RAM.

Changing the target for the write operation functions as a kind of write
protection. A write protection is needed in order to emulate a ROM cartridge.
First one writes the ROM content to RAM and then one protects it from being
overwritten.

Why do we need this? Some game cartridges overwrite themselves (intentionally),
so that they won't run in RAM.

•RAM 2 MODE (110zzzzz):

With POKE 39938,192 RAM Mode 2 of the Final Expansion is activated.

Read operations come from the RAM Bank 1 or optionally from Bank 2.

Write operations are always to RAM Bank 1.

The Block 0 of the Vic-20 (3K Expansion) is switched on. The Bit 0 of Register
1 controls the write protection. There is up to 35KB of SRAM available to
configure (4 x 8KB + 3KB) at the addresses $0400 (Blk 0), $2000 (Blk 1), $4000
(Blk 2), $6000 (Blk 3) and $A000 (Blk 5).

The 3KB expansion (Vic-20 Blk 0) comes from Bank 0 (The first 32KB in SRAM) of
the SRAM.

The four 8KB blocks in the Vic-20 (Blk 1 - Blk 5) come from Bank 1 (The second
32KB in SRAM) of the SRAM. This way all the addressable space in the Vic-20 is
filled with RAM and therefore the maximum expansion with memory is achieved.

The additional information bits in Register 1 (zzzzz) control the write access
to the RAM blocks. Bit 4 controls Blk 5, Bit 3 Controls Blk 3, Bit 2 Controls
Blk 2, Bit 1 Controls Blk 1 and Bit 0 Controls Blk 0.

If the Bit is set to 0 then the RAM Block 0 can only be read not written.

The bits for Blocks 1 to 5 control the write operation. If the bit is not set
(0) then it reads from Bank 1 of the RAM. If the Bit is set to (1) then it
reads from Bank 2 of the RAM. In this way you have 64KB available (instead of
32KB). This way the RAM in Bank 2 can not be overwritten. The Ram in Bank 2
functions with write protection (like ROM). Through this you can leave a
program running without losing access to the RAM, one has a sort of RAM under
a ROM, like in the C64.

Why do we need this? : one could for example program a machine code monitor to
run in Bank 2 and display the contents of the whole of Bank 1.

This monitor would need almost no memory for itself.

•SUPER RAM MODE (101zzzzz):

With Poke 39938,160 the SUPER RAM MODE of Final Expansion is activated.
Read operations come from the RAM from the selected Bank.

Write operations go to the RAM in the selected Bank.

Block 0 of the Vic-20 (3K Expansion) is switched on.

There are 32KB of SRAM enabled (4 x 8KB) at the addresses $2000 (Block 1),
$4000 (Block 2), $6000 (Block 3) and $A000 (Block 5).

The usage of SUPER RAM is similar to a Flash read mode, except that RAM
instead of EEPROM is used so that access to the full 512KB is possible.

The additional information in the Register (zzzzz) selects the 32KB Block of
the SRAM.

In 512KB one has 16 x 32KB Blocks. The additional information can take the
values 0 to 15.

What can you do with an 8 Bit computer like the Vic-20 with half a megabyte of
RAM?

Who knows what innovative uses resourceful developers will find, one could for
example easily save 3 full disks in there ...

•RAM / ROM MODE (011zzzzz):

With Poke 39938,96 the RAM/ROM mode of the Final Expansion is enabled.

Read operations come from the RAM Bank 1 or optionallt from the ROM Bank 0.

Write operations go always to the RAM, either in the Bank 1 (RAM Mode) or in
the Bank 2 (ROM Mode).

The Block 0 of the Vic-20 (3K Expansion) is switched on.

The Bit 0 of Register 1 controls the write protection.

There is up to 35KB of SRAM available to configure (4 x 8KB + 3KB) at the
addresses $0400 (Blk 0), $2000 (Blk 1), $4000 (Blk 2), $6000 (Blk 3) and $A000
(Blk 5).

The 3KB expansion (Vic-20 Blk 0) comes from Bank 0 (The first 32KB in SRAM) of
the SRAM.

The four 8KB blocks in the Vic-20 (Blk 1 - Blk 5) come from Bank 1 (The second
32KB in SRAM) of the SRAM.

This way all the addressable space in the Vic-20 is filled with RAM and
therefore the maximum expansion with memory is achieved.

The additional information in Register 1 (zzzzz) controls the selection of the
Vic-20 Blocks. Bit 4 controls Blk 5, Bit 3 Controls Blk 3, Bit 2 Controls
Blk 2, Bit 1 Controls Blk 1 and Bit 0 Controls Blk 0. If the Bit is set to 0
then the RAM Block 0 can only be read not written.

The Bits of the Blocks 1 to 5 control the access mode. If the Bit is not set
(0) then access is to the RAM Bank 1. If the Bit is set (1) then read access
is to the Bank 0 of the ROM (Flash) and write access is to the RAM Bank 1.

In this way there is access to a mix of RAM and ROM. In ROM mode the RAM in
Bank 2 can be written to. This way one can simply copy ROM code into into the
RAM Bank.

Why do we need this?: The firmware can activate the ROM BLock where the code
has just been added. Simultaneously one can access the remaining RAM.

•Flash Write Mode (001zzzzz):

With Poke 39938,32 the FLash Mode of the Final Expansion is activated.

Read access comes from the enabled Bank.

Write access goes to the ROM (Flash) in the selected Bank.

The Block 0 of the Vic-20 (3k Expansion) is enabled.

In this mode it is possible to examine and erase the Flash memory. In order to
do this the special command sequence must be followed as prepared by the
manufacturer of the Flash memory (See AM29F040 Data Sheet).

The Banking follows the same methos as Super ROM mode.

The FE Firmware Flasher (fe3flash) uses this method.
