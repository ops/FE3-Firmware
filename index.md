# Firmware releases for VIC-20 Final Expansion 3 (FE3)

For more information about FE3 see
[FE3 WIKI](http://sleepingelephant.com/denial/wiki/index.php?title=Final_Expansion)

## Release v0.28 (2020-08-18)
- Added support for AMIC A29040B flash chip.

Download [fe3firmware-v0.28.zip](releases/fe3firmware-v0.28.zip).

## Release v0.27 (2019-11-05)

- Added a relink call after loading of a BASIC program. This is hopefully
  the final fix on this area.

Download [fe3firmware-v0.27.zip](releases/fe3firmware-v0.27.zip).

## Release v0.26 (2019-10-05)

- Removed relinking after load. Some BASIC programs failed to run correctly.

Download [fe3firmware-v0.26.zip](releases/fe3firmware-v0.26.zip).

## Release v0.25 (2019-02-25)

- Correctly display menu items which are longer than 20 chars
- Added support for large loader files in "Flash Program"

Download [fe3firmware-v0.25.zip](releases/fe3firmware-v0.25.zip).

## Release v0.24 (2018-06-15)

- Added support for new flash Vendor and Device IDs.

Download [fe3firmware-v0.24.zip](releases/fe3firmware-v0.24.zip).

## Release v0.23 (2018-05-11)

- Restored version R022D Basic-Relinker call related code. Users seem to
  have problems with it.

- This version is identical to version R022D except three version string
  related bytes. Source code has been cleaned up a bit and committed to
  GitHub.

Download [fe3firmware-v0.23.zip](releases/fe3firmware-v0.23.zip).
