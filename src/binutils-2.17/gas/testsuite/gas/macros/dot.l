.*: Assembler messages:
.*:[1-9][0-9]*: Warning: attempt to redefine pseudo-op .\.macro. ignored
.*:27: Error: unknown pseudo-op: .\.xyz.
.*:28: Error: .*
#...
[ 	]*[1-9][0-9]*[ 	]+m 4, 2
[ 	]*[1-9][0-9]*[ 	]+> \.data
[ 	]*[1-9][0-9]*[ 	]+> labelA:labelB:labelC:labelD:x\.y\.z 4\+2
[ 	]*[1-9][0-9]*[ 	]+>> \.align 4
[ 	]*[1-9][0-9]*[ 	]+\?+[ 	]+0606[ 	]+>> \.byte 4\+2,4\+2
[ 	]*[1-9][0-9]*[ 	]+\?+[ 	]+0000[ 	]+> \.skip 2
[ 	]*[1-9][0-9]*[ 	]+> labelZ:labelY:labelX:labelW:\.xyz 4-2
[ 	]*[1-9][0-9]*[ 	]+>> \.align 8
[ 	]*[1-9][0-9]*[ 	]+\?+[ 	]+0202[ 	]+>> \.byte 4-2,4-2
[ 	]*[1-9][0-9]*[ 	]+\?+[ 	]+0000 ?0000[ 	]+> \.skip 4\*2
[ 	]*[1-9][0-9]*[ 	]+0000 ?0000[ 	]*
[ 	]*[1-9][0-9]*[ 	]+> label9:label8:label7:label6:
[ 	]*[1-9][0-9]*[ 	]+
[ 	]*[1-9][0-9]*[ 	]+\.purgem \.xyz, x\.y\.z
[ 	]*[1-9][0-9]*[ 	]+\.xyz 0
[ 	]*[1-9][0-9]*[ 	]+(\?+[0 	]+)?x\.y\.z 0
#pass