include emu8086.inc

ORG 100h
  MOV row, 0
  GOTOXY 0, row
  PRINT 'Digite um numero inteiro entre 00 e 99: '
    
start: 
  ADD row, 1
  MOV AH, 01
  INT 21h
  MOV BH, AL
  INT 21h
  MOV BL, AL
  CMP BH, 30h
  JB  iffails
  JMP ifok 
  
iffails:
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, digite novamente: '
  JMP start

ifok:
  CMP BH, 39H
  JA  iffails
  CMP BL, 30h
  JB  iffails
  CMP BL, 39H
  JA  iffails  
  GOTOXY 0, row
  PRINT 'O antecessor ao numero digitado eh: '
  MOV AH, 02
  MOV CX, BX
  CMP BL, 30h
  JNE diffx0
  CMP BH, 30h
  JNE diff0x
  MOV CH, 2Dh
  MOV CL, 31h
  JMP prints 
  
diff0x:
  SUB CH, 1
  MOV CL,39h    
  JMP prints

diffx0:
  SUB CL, 1

prints: 
  ADD row, 1
  MOV DL, CH
  INT 21h
  MOV DL, CL
  INT 21h
  GOTOXY 0, row
  PRINT 'O sucessor ao numero digitado eh: '
  MOV CX, BX
  CMP BL, 39h
  JNE notx9
  CMP BH, 39h
  JNE not9x
  MOV CH, 30h
  MOV CL, 30h
  MOV DL, 31h
  INT 21h
  JMP printnum

not9x:  
  ADD CH, 1
  MOV CL,30h    
  JMP printnum
  
notx9:   
  ADD CL, 1

printnum: 
  ADD row, 1 
  MOV DL, CH
  INT 21h
  MOV DL, CL
  INT 21h
  GOTOXY 0, row
  PRINT 'O numero digitado foi: '
  MOV DL, BH
  INT 21h
  MOV DL, BL
  INT 21h
        
RET 

data:
  row DB 0