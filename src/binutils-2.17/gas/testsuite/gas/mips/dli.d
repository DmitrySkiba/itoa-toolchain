#objdump: -dr --prefix-addresses
#name: MIPS dli

# Test the dli macro.

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <[^>]*> li	a0,0
0+0004 <[^>]*> li	a0,1
0+0008 <[^>]*> li	a0,-1
0+000c <[^>]*> li	a0,0x8000
0+0010 <[^>]*> li	a0,-32768
0+0014 <[^>]*> lui	a0,0x1
0+0018 <[^>]*> lui	a0,0x1
0+001c <[^>]*> ori	a0,a0,0xa5a5
0+0020 <[^>]*> li	a0,0x8000
0+0024 <[^>]*> dsll	a0,a0,0x10
0+0028 <[^>]*> ori	a0,a0,0x1234
0+002c <[^>]*> lui	a0,0xffff
0+0030 <[^>]*> dsrl32	a0,a0,0x0
0+0034 <[^>]*> lui	a0,0xffff
0+0038 <[^>]*> dsrl32	a0,a0,0x0
0+003c <[^>]*> li	a0,-1
0+0040 <[^>]*> li	a0,-1
0+0044 <[^>]*> dsrl	a0,a0,0xc
0+0048 <[^>]*> lui	a0,0x8000
0+004c <[^>]*> ori	a0,a0,0x1234
0+0050 <[^>]*> li	a0,-32768
0+0054 <[^>]*> dsll	a0,a0,0x10
0+0058 <[^>]*> ori	a0,a0,0x1234
0+005c <[^>]*> dsll	a0,a0,0x10
0+0060 <[^>]*> ori	a0,a0,0x5678
0+0064 <[^>]*> lui	a0,0x8000
0+0068 <[^>]*> ori	a0,a0,0x1234
0+006c <[^>]*> dsll	a0,a0,0x10
0+0070 <[^>]*> ori	a0,a0,0x5678
0+0074 <[^>]*> dsll	a0,a0,0x10
0+0078 <[^>]*> li	a0,-30875
0+007c <[^>]*> lui	a0,0xffff
0+0080 <[^>]*> ori	a0,a0,0x4321
0+0084 <[^>]*> li	a0,-16
0+0088 <[^>]*> li	a0,-256
0+008c <[^>]*> li	a0,-4096
0+0090 <[^>]*> lui	a0,0xffff
0+0094 <[^>]*> lui	a0,0xfff0
0+0098 <[^>]*> lui	a0,0xff00
0+009c <[^>]*> lui	a0,0xf000
0+00a0 <[^>]*> li	a0,-1
0+00a4 <[^>]*> dsll32	a0,a0,0x0
0+00a8 <[^>]*> li	a0,-16
0+00ac <[^>]*> dsll32	a0,a0,0x0
0+00b0 <[^>]*> li	a0,-256
0+00b4 <[^>]*> dsll32	a0,a0,0x0
0+00b8 <[^>]*> li	a0,-4096
0+00bc <[^>]*> dsll32	a0,a0,0x0
0+00c0 <[^>]*> li	a0,0xffff
0+00c4 <[^>]*> dsll32	a0,a0,0x10
0+00c8 <[^>]*> li	a0,0xfff0
0+00cc <[^>]*> dsll32	a0,a0,0x10
0+00d0 <[^>]*> li	a0,0xff00
0+00d4 <[^>]*> dsll32	a0,a0,0x10
0+00d8 <[^>]*> li	a0,0xf000
0+00dc <[^>]*> dsll32	a0,a0,0x10
0+00e0 <[^>]*> li	a0,-1
0+00e4 <[^>]*> dsrl	a0,a0,0x4
0+00e8 <[^>]*> li	a0,-1
0+00ec <[^>]*> dsrl	a0,a0,0x8
0+00f0 <[^>]*> li	a0,-1
0+00f4 <[^>]*> dsrl	a0,a0,0xc
0+00f8 <[^>]*> li	a0,-1
0+00fc <[^>]*> dsrl	a0,a0,0x10
0+0100 <[^>]*> li	a0,-1
0+0104 <[^>]*> dsrl	a0,a0,0x14
0+0108 <[^>]*> li	a0,-1
0+010c <[^>]*> dsrl	a0,a0,0x18
0+0110 <[^>]*> li	a0,-1
0+0114 <[^>]*> dsrl	a0,a0,0x1c
0+0118 <[^>]*> lui	a0,0xffff
0+011c <[^>]*> dsrl32	a0,a0,0x0
0+0120 <[^>]*> lui	a0,0xfff
0+0124 <[^>]*> ori	a0,a0,0xffff
0+0128 <[^>]*> lui	a0,0xff
0+012c <[^>]*> ori	a0,a0,0xffff
0+0130 <[^>]*> lui	a0,0xf
0+0134 <[^>]*> ori	a0,a0,0xffff
0+0138 <[^>]*> li	a0,0xffff
0+013c <[^>]*> li	a0,4095
0+0140 <[^>]*> li	a0,255
0+0144 <[^>]*> li	a0,15
0+0148 <[^>]*> lui	a0,0x3
0+014c <[^>]*> ori	a0,a0,0xfffc
0+0150 <[^>]*> li	a0,0xffff
0+0154 <[^>]*> dsll	a0,a0,0x1e
0+0158 <[^>]*> li	a0,0xffff
0+015c <[^>]*> dsll32	a0,a0,0x2
0+0160 <[^>]*> li	a0,0xffff
0+0164 <[^>]*> dsll32	a0,a0,0x6
0+0168 <[^>]*> li	a0,-1
0+016c <[^>]*> dsll32	a0,a0,0x0
0+0170 <[^>]*> dsrl	a0,a0,0xa
0+0174 <[^>]*> li	a0,-1
0+0178 <[^>]*> dsll	a0,a0,0x1c
0+017c <[^>]*> dsrl	a0,a0,0xa
0+0180 <[^>]*> li	a0,-1
0+0184 <[^>]*> dsll	a0,a0,0x18
0+0188 <[^>]*> dsrl	a0,a0,0xa
0+018c <[^>]*> lui	a0,0x3f
0+0190 <[^>]*> ori	a0,a0,0xfc03
0+0194 <[^>]*> dsll	a0,a0,0x10
0+0198 <[^>]*> ori	a0,a0,0xffff
0+019c <[^>]*> dsll	a0,a0,0x10
0+01a0 <[^>]*> ori	a0,a0,0xc000
	...
