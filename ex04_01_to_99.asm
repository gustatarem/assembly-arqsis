include 'emu8086.inc'

ORG 100h

MOV row, 0
GOTOXY 0, row
MOV BH, 30h
MOV BL, 31h
MOV CX, 99h

start:
  MOV AH, 02h
  MOV DL, BH
  INT 21h
  JMP print
  
print:
  MOV DL, BL
  INT 21h
  CMP BL, 39h
  JE ifx0
  JMP sum 
  
ifx0:
  ADD row, 1
  CMP BH, 39h
  JE ending
  ADD BH, 1
  MOV BL, 30h
  GOTOXY 0, row
  JMP start

sum:
  ADD BL, 1,
  PRINT ', '
  LOOP start
  
ending:
  PRINT '.'
  RET
          
data:
  row DB 0          
