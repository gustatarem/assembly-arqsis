include emu8086.inc

ORG 100h
  MOV row, 0
  JMP getfirstnumber


;Procedimento responsavel por receber e validar um numero digitado pelo usuario
getfirstnumber:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'Digite um numero inteiro entre 000 e 999: ' 
  MOV AH, 01                
  INT 21h                 
  MOV BH, AL               
  INT 21h
  MOV BL, AL
  INT 21h
  MOV CH, AL
                 
  CMP BH, 30h              
  JB  iffails
  CMP BL, 30h              
  JB  iffails
  CMP CH, 30h              
  JB  iffails
  CMP BH, 40h              
  JAE  iffails
  CMP BL, 40h              
  JAE  iffails
  CMP CH, 40h              
  JAE  iffails              
  
  JMP storefirstnumber      

;Procedimento responsavel por guardar o valor do numero digitado em uma variavel firstnum
storefirstnumber:
  MOV AL, BH
  SUB AL, 30h
  MOV AH, 100
  MUL AH
  MOV firstnum, AX
  MOV AL, BL
  SUB AL, 30h
  MOV AH, 10               
  MUL AH                  
  ADD AL, CH
  SUB AL, 30h
  MOV AH, 0h               
  ADD firstnum, AX
  JMP getsecondnumber

;Procedimento responsavel por receber e validar um numero digitado pelo usuario  
getsecondnumber:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'Digite um numero inteiro entre 000 e 999: ' 
  MOV AH, 01                
  INT 21h                 
  MOV BH, AL               
  INT 21h
  MOV BL, AL
  INT 21h
  MOV CH, AL
                 
  CMP BH, 30h              
  JB  iffails
  CMP BL, 30h              
  JB  iffails
  CMP CH, 30h              
  JB  iffails
  CMP BH, 40h              
  JAE  iffails
  CMP BL, 40h              
  JAE  iffails
  CMP CH, 40h              
  JAE  iffails              
  
  JMP storesecondnumber      

;Procedimento responsavel por guardar o valor do numero digitado em uma variavel secondnum
storesecondnumber:
  MOV AL, BH
  SUB AL, 30h
  MOV AH, 100
  MUL AH
  MOV secondnum, AX
  MOV AL, BL
  SUB AL, 30h
  MOV AH, 10               
  MUL AH                  
  ADD AL, CH
  SUB AL, 30h
  MOV AH, 0h               
  ADD secondnum, AX
  JMP getoperator

;Procedimento responsavel por receber e validar um operador digitado pelo usuario (+, -, * ou /) 
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

;Procedimento responsavel por guardar o valor do operador digitado em uma variavel operator
storeoperator:              
  MOV operator, BL
  JMP calculatenumbers  

;Procedimento que informa o usuario caso ele tinha digitado um valor invalido  
iffails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O valor digitado eh invalido, reiniciando programa...'
  JMP getfirstnumber

;Procedimento que decide qual operacao aritmetica executar
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

;Procedimento que executa a multiplicacao 
multiply:
  MUL CX
  MOV result, AX
  JMP printresult

;Procedimento que executa a soma
sum:
  ADD AX, CX
  MOV result, AX
  JMP printresult

;Procedimento que executa a subtracao
subtract:
  CMP CX, AX
  JAE subtractfails
  SUB AX, CX
  MOV result, AX
  JMP printresult

;Procedimento que executa a divisao
divide:
  CMP CX, 0
  JE dividefails
  MOV CX, AX
  MOV AH, 0
  DIV CX
  MOV result, AX
  JMP printresult

;Procedimento que informa o usuario caso sua subtracao resulte em um valor negativo (nao permitido)  
subtractfails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'O resultado da subtracao nao pertence ao conjunto dos numeros naturais'
  JMP getfirstnumber

;Procedimento que informa o usuario caso sua divisao contenha um denominador com o valor zero
dividefails:
  ADD row, 1
  GOTOXY 0, row
  PRINT 'Nao eh possivel dividir um numero por 0'
  JMP getfirstnumber  

;Procedimento que orquestra a maneira com a qual o numero sera mostrado no console (considerando o numero de algarismos)
printresult:
  ADD row, 1  
  GOTOXY 0, row
  PRINT 'O resultado eh: '
  CMP result, 100
  JNAE print2numbers
  CMP result, 1000
  JNAE print3numbers
  CMP result, 10000
  JNAE print4numbers
  JMP print5numbers

;Procedimento que mostra, da direita pra esquerda, o quinto algarismo do numero
print5numbers:
  MOV AX, result
  MOV CX, 10000
  DIV CX
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  SUB DX, 30h    
  MOV AX, DX
  MOV CX, 10000
  MUL CX
  SUB result, AX
  JMP print4numbers

;Procedimento que mostra, da direita pra esquerda, o quarto algarismo do numero
print4numbers:
  MOV AX, result
  MOV CX, 1000
  DIV CX
  MOV DX, AX
  ADD DX, 30h
  MOV AH, 02
  INT 21h
  SUB DX, 30h    
  MOV AX, DX
  MOV CX, 1000
  MUL CX
  SUB result, AX
  JMP print3numbers

;Procedimento que mostra, da direita pra esquerda, o terceiro algarismo do numero  
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

;Procedimento que mostra, da direita pra esquerda, o segundo e o primeiro algarismo do numero
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


;Variaveis utilizadas
row DB 0            ;Variavel de controle para amostragem no console
firstnum DW 0       ;Variavel que armazena o primeiro numero digitado
secondnum DW 0      ;Variavel que armazena o segundo numero digitado
operator DB 0       ;Variavel que armazena o operador digitado
result DW 0         ;Variavel que armazena o resultado