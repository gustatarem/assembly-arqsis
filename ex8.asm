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
  MOV AH, 0h               
  MOV firstnum, AX
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
  MOV AH, 0h               
  MOV secondnum, AX
  JMP getoperator
  
getoperator:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'Digite o operador (+, -, * ou /): ' 
  MOV AH, 01                
  INT 21h
  MOV BL, AL 
  CMP BL, 2Ah               
  JE  storeoperator;                  
  CMP BL, 2Bh               
  JE  storeoperator;                  
  CMP BL, 2Dh               
  JE  storeoperator;                  
  CMP BL, 2Fh               
  JE  storeoperator;  
  JMP iffails;

storeoperator:              
  MOV operator, BL
  JMP calculatenumbers  
  
iffails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, reiniciando programa...'
  JMP getfirstnumber

calculatenumbers:
  MOV AX, firstnum
  MOV CX, secondnum
  CMP operator, 2Ah               
  JE  multiply;                  
  CMP operator, 2Bh               
  JE  sum;                  
  CMP operator, 2Dh               
  JE  subtract;                  
  CMP operator, 2Fh               
  JE  divide;
  
multiply:
  MUL CX
  MOV result, AX
  JMP printresult

sum:
  ADD AX, CX
  MOV result, AX
  JMP printresult

subtract:
  SUB AX, CX
  MOV result, AX
  JMP printresult

divide:
  MOV CX, AX
  MOV AH, 0
  DIV CX
  MOV result, AX
  JMP printresult  

printresult:
  ADD row, 1  
  GOTOXY 0, row
  PRINT 'O resultado eh: '
  CMP result, 100
  JNAE print2numbers
  JMP print3numbers
  
print3numbers:
  MOV AX, result
  MOV CX, 100
  DIV CX
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  SUB DX, 30h    
  MOV AX, DX
  MOV CL, 100
  MUL CL
  SUB result, AX
  JMP print2numbers

print2numbers:
  MOV AX, result
  MOV CL, 10
  DIV CL
  MOV AH, 0
  MOV DL, AL
  ADD DL, 30h
  MOV AH, 02
  INT 21h
  MOV AX, result
  MOV CL, 10
  DIV CL
  MOV DL, AH
  ADD DL, 30h
  MOV AH, 02
  INT 21h        
  
  RET 


row DB 0
firstnum DW 0
secondnum DW 0
operator DB 0
result DW 0
varax DW 0