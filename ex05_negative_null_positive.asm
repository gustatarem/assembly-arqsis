include emu8086.inc

ORG 100h

MOV row, 0
GOTOXY 0, row
PRINT 'Digite um numero qualquer: '

start:
  ADD row, 1
  MOV AH, 01
  
input:
  INT 21h
  MOV BH, AL
  CMP BH, 2Dh
  JNE continue
  MOV DH, BH
  JMP input
  
continue:
  INT 21h
  MOV BL, AL
  CMP BH, 30h
  JB iffails
  CMP BH, 39h
  JA iffails
  CMP BL, 30h
  JB iffails
  CMP BL, 39h
  JA iffails
  JMP checknegative

iffails:
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, digite novamente: '
  JMP start
  
checknegative:  
  GOTOXY 0, row
  CMP DH, 2Dh
  JNE checknull
  CMP BH, 30h
  JE checknegative00
  PRINT 'O numero digitado eh negativo.'
  JMP ending

checknegative00:
  CMP BL, 30h
  JE negativezero
  PRINT 'O numero digitado eh negativo.'
  JMP ending

negativezero:
  PRINT '-00 eh um numero inexistente.'
  JMP ending

checknull:
  CMP BH, 30h
  JNE positive
  CMP BL, 30h
  JNE positive
  PRINT 'O numero digitado eh nulo.'
  JMP ending
  
positive:
  PRINT 'O numero digitado eh positivo.'
  
ending:
  RET

data:
  row DB 0
