include emu8086.inc

ORG 100h

  MOV row, 0    
  GOTOXY 0, row
  PRINT 'Entre um numero entre 00 e 99: '
    
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
  SUB BL, 30h
  MOV AL, BL
  MOV AH, 0
  MOV CX, 2
  DIV CL
  MOV CX, AX
  GOTOXY 0, row
  PRINT 'O numero '
  MOV AH, 02h
  MOV DL, BH
  INT 21h
  ADD BL, 30h
  MOV DL, BL
  INT 21h
  CMP CH, 0
  JE  ifpar
  JMP ifimpar

ifpar:
  PRINT ' eh par'
  JMP end 
    
ifimpar:
  PRINT ' eh impar'   
    
end:  
  RET     
  
data:
  row DB 0 