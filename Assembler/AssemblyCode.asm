# all numbers in hex format
# we always start by reset signal
#if you don't handle hazards add 3 NOPs
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
in R2        #add 19 in R2
NOP
NOP
SHL R2,2     #R2=64  , C--> 0, N -->0 , Z -->0
NOP
NOP
SHR R2,3     #R2=0C  , C -->1, N-->0 , Z-->0
NOP
NOP
IADD R2,FFFF #R2= 0001000B (C,N,Z= 0)
NOP
NOP
LDM R1, 1
ADD R1,R2    #R2= 00010028 (C,N,Z= 0)