# Aseprite Scripts
A collection of scripts for [Aseprite](https://aseprite.org)

Table of contents:
- [Export to C](#export-to-c)

## Export to C
![](screenshots/Export%20to%20C.png)

Flattens the currently visible Sprite and exports the frames into a C header file for use with Arduino and other embedded hardware.

Makes use of the PROGMEM variable modifier to ensure the sprites are stored in the flash program memory.

Used to create the sprites of my [LIM project](https://github.com/mvaladas/LIM) running on an NodeMCUv2.

### Example export
This is an example export for the Rain Sprite

```cpp
#include <stdint.h>
#include <avr/pgmspace.h>

// Define Sprite structure
#ifndef _H_SPRITESTRUCT
#define _H_SPRITESTRUCT

struct Sprite
{
    const uint16_t frameCount;
    const uint16_t width;
    const uint16_t height;
    const uint32_t *frameduration;
    const uint32_t *frames;
};

#endif


/* Data exported for Rain*/
static const uint32_t PROGMEM rain_frameduration[5] = {75, 75, 75, 75, 75};

static const uint32_t PROGMEM rain_data[5][64] = {
{
0x00000000, 0x00000000, 0x00000000, 0xFFBCBCBC, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000,
0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0x00000000,
0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0xFF19C3FB,
0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000
},
{
0x00000000, 0x00000000, 0x00000000, 0xFFBCBCBC, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000,
0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0x00000000,
0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0xFF19C3FB,
0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000
},
{
0x00000000, 0x00000000, 0x00000000, 0xFFBCBCBC, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000,
0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0x00000000,
0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0xFF19C3FB,
0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000
},
{
0x00000000, 0x00000000, 0x00000000, 0xFFBCBCBC, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000,
0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0x00000000,
0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0xFF19C3FB
},
{
0x00000000, 0x00000000, 0x00000000, 0xFFBCBCBC, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0xFFBCBCBC, 0x00000000,
0x00000000, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC, 0x00000000,
0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFE3F4FE, 0xFFBCBCBC,
0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFF19C3FB, 0x00000000, 0x00000000, 0x00000000,
0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000
}
};
Sprite Rain = {
    5, // Frames
    8, // Width
    8, // Height
    &(rain_frameduration[0]), // Frames duration
    &(rain_data[0][0]) // Frames Data
};

```