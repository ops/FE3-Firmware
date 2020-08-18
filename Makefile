#
# Makefile for FE3-Firmware and utils
#

include version.inc

AS = dasm
ASFLAGS = -f3

ifdef verbose
	ASFLAGS += -v$(verbose)
endif

# Disable fe3flash.prg VENDOR/DEVICE check.
# Needed for initial flashing of unsupported flash.
ifdef no_vendor_check
	ASFLAGS += -DNO_VENDOR_CHECK
endif

all: fe3firmware fe3diag.prg fe3flash.prg

fe3firmware: fe3firmware.asm version.inc
	$(AS) $< $(ASFLAGS) -o$@

fe3diag.prg: fe3diag.asm
	$(AS) $< $(ASFLAGS) -o$@

fe3flash.prg: fe3flash.asm
	$(AS) $< $(ASFLAGS) -o$@

package:
	zip fe3firmware-$(shell echo v$(FW_VERSION) | tr -d \").zip \
		NEWS \
		fe3firmware \
		fe3diag.prg \
		fe3flash.prg
clean:
	$(RM) fe3firmware
	$(RM) fe3diag.prg
	$(RM) fe3flash.prg
	$(RM) *~
	$(RM) *.zip
