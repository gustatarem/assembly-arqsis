include 'emu8086.inc'

.model small
org 100h

.code

PRINTS MACRO message 
  MOV AH, 09h
  LEA DX, message
  INT 21h
ENDM                 

start:
  PRINTS message1         
  MOV CX, 10          
  MOV BX,offset array  
  MOV AH, 01   

input:
  PUTC 10              
  PUTC 13
  INT 21h              
  MOV AH, 00
  CMP AL, 30h
  JB  iffails      
  SUB AL, 30h         
  MUL decimal           
  MOV [BX], AL          
  MOV AH, 01         
  INT 21h
  CMP AL, 30h
  JB  iffails              
  SUB AL, 30h          
  ADD [BX], AL          
  INC BX               
  LOOP input     
  JMP initcounter2ndloop
  
iffails:
  PUTC 10              
  PUTC 13
  PRINTS message5
  JMP start             

initcounter2ndloop:
  MOV CX, 10      
  DEC CX

printcounter:      
  MOV BX, CX           
  MOV SI, 00

nextindex:          
  INC SI
  DEC BX
  LOOP printcounter     
  PRINTS message2
  
resetcounter: 
  MOV CX, 10           
  MOV BX, offset array                 

print: 
  PUTC 10
  PUTC 13
  MOV AX, [BX]        
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  ADD AL, 30h
  MOV DL, AL          
  MOV AH, 02h
  INT 21h
  MOV AX, [BX]       
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  MOV DL, AH
  ADD DL, 30h          
  MOV AH, 02h
  INT 21h
  INC BX            
  LOOP print        
  JMP resetafterprint
  
initcounter3rdloop:
  MOV CX, 10      
  DEC CX

comparisoncounter:      
  MOV BX, CX           
  MOV SI, 00
  
compare:           
  MOV AL,array[SI]    
  MOV DL,array[SI+1]   
  CMP AL, DL
  JBE nextindextocompare       
  MOV array[SI], DL     
  MOV array[SI+1], AL
  
nextindextocompare:          
  INC SI
  DEC BX
  JNZ compare
  LOOP comparisoncounter
  
resetcomparisoncounter: 
  MOV CX, 10           
  MOV BX, offset array  

lower:
  PRINTS message3
  MOV BX, offset array
  PUTC 10
  PUTC 13
  MOV AX, [BX]       
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  ADD AL, 30h
  MOV DL, al        
  MOV AH, 02h
  INT 21h
  MOV AX, [BX]        
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  MOV DL, AH
  ADD DL, 30h                          
  MOV AH, 02h
  INT 21h
  JMP resetafterlower

higher:
  PRINTS message4
  MOV BX, offset array
  ADD BX, 9          
  PUTC 10
  PUTC 13
  MOV AX, [BX]         
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  ADD AL, 30h
  MOV DL, AL          
  MOV AH, 02h
  INT 21h
  MOV AX, [BX]        
  MOV AH, 00h
  XOR DX, DX
  DIV decimal
  MOV DL, AH
  ADD DL, 30h                             
  MOV AH, 02h
  INT 21h

ending:
  RET

resetafterprint:
  MOV AX, 00h
  MOV BX, 00h
  MOV DX, 00h
  JMP initcounter3rdloop 

resetafterlower:
  MOV AX, 00h
  MOV BX, 00h
  MOV DX, 00h
  JMP higher

; --------------------------------------------------------------

.data

array DB 00,00,00,00,00,00,00,00,00,00
decimal DB 10
message1 DB 10,13,'Digite dez numeros inteiros entre 00 e 99: $'
message2 DB 0dh,0ah,'Lista digitada: $'
message3 DB 10,13, 'Menor numero: $'
message4 DB 10,13, 'Maior numero: $'
message5 DB 10,13, 'O valor digitado eh invalido, digite novamente: $'

