include emu8086.inc

ORG 100h

  MOV row, 0    
  JMP getnumber


getnumber:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'Digite um numero inteiro entre 00 e 99: ' 
  MOV AH, 01                
  INT 21h                 
  MOV BH, AL               
  INT 21h
  MOV BL, AL               
  CMP BH, 30h              
  JB  iffails              
  JMP storenumber      

storenumber:
  MOV AL, BH
  SUB AL, 30h
  MOV AH, 10               
  MUL AH                  
  ADD AL, BL
  SUB AL, 30h               
  MOV number, AL
  JMP printresult

    
iffails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, digite novamente: '
  JMP getnumber
    
printresult:
  MOV AL, number
  MOV AH, 0
  MOV CX, 3
  DIV CL
  MOV rest, AH
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O numero '
  MOV AL, number
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  MOV DH, 0
  MOV AL, number
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DL, AH
  ADD DL, 30h
  MOV AH, 02
  INT 21h 
  CMP rest, 0
  JE  ifmultiple
  JMP ifnotmultiple

ifmultiple:
  PRINT ' eh multiplo de 3'
  JMP end 
    
ifnotmultiple:
  PRINT ' nao eh multiplo de 3'   
  JMP end
    
end:  
  RET     
  
data:
  row DB 0
  number DB 0
  rest DB 0 