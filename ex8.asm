include emu8086.inc

ORG 100h
  MOV row, 0
  JMP getfirstnumber
    
getfirstnumber:
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
  JMP storefirstnumber      

storefirstnumber:
  MOV AL, BH
  SUB AL, 30h
  MOV AH, 10               
  MUL AH                  
  ADD AL, BL
  SUB AL, 30h               
  MOV firstnum, AL
  JMP getsecondnumber
  
getsecondnumber:
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
  JMP storesecondnumber    

storesecondnumber:
  MOV AL, BH
  SUB AL, 30h
  MOV AH, 10               
  MUL AH                   
  ADD AL, BL
  SUB AL, 30h               
  MOV secondnum, AL
  JMP getoperator
  
  
getsecondnumber:
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
  JMP storesecondnumber  

  
iffails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, reiniciando programa...'
  JMP getfirstnumber

calculatenumbers:
  MOV AL, firstnum
  MOV AH, secondnum
  ADD AL, AH
  MOV sum, AL
  JMP printsum

printsum:
  ADD row, 1  
  GOTOXY 0, row
  PRINT 'A soma eh: '
  CMP sum, 100
  JNAE print2numbers
  MOV AL, sum
  MOV AH, 0h
  MOV CH, 100
  DIV CH
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  
  SUB sum, 100
  MOV AL, sum
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h 
  
  MOV AL, sum
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DL, AH
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  
  RET

print2numbers:
  MOV AL, sum
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  MOV AL, sum
  MOV AH, 0h
  MOV CH, 10
  DIV CH
  MOV DL, AH
  ADD DX, 30h
  MOV AH, 02
  INT 21h        
  
  RET 


row DB 0
firstnum DB 0
secondnum DB 0
sum DB 0