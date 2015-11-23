printString macro string
   mov ah,9h
   lea dx,[string]
   int 21h
endm

saveString macro cadena
    mov bx,offset cadena
    mov dx,bx
    mov ah,0ah
    int 21h

    mov bx,offset cadena
    mov al,[bx+1];al=stringLenght
    add al,01;al=stringEnd+1
    xor ah,ah
    mov si,ax
    mov byte [bx+si],0
endm

validar macro
   cmp [buffer],41h
   jl keepChar
   cmp [buffer],7ah
   jg keepChar

   mov al,05ah
   mov cx,6
repp:
   inc al
   cmp [buffer],al
   je keepChar 
   loop repp
endm

printDone macro
   call cls
   mov cx,9
etret:
  mov bh,0
  mov bl,84h
  push cx
  mov cx,80
  mov al,0
  mov ah,09h
  int 10h
  pop cx
  mov ah,2h
  mov dl,0Ah
  int 21h
  loop etret

  mov ah,2h
  xor dh,dh
  xor dl,dl
  int 10h

  printString done

  mov ah,2h
  mov dl,0Ah
  int 21h  
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.model small
.stack [32]
.data
   sourceFile db 30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   destFile db 30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   
   done db 0Ah,' **      ** ********   ******  **      **   *******',0Ah,  '/**     /**/**/////   **////**/**     /**  **/////**',0Ah,'/**     /**/**       **    // /**     /** **     //**',0Ah,'/**********/******* /**       /**********/**      /**',0Ah,'/**//////**/**////  /**       /**//////**/**      /**',0Ah,'/**     /**/**      //**    **/**     /**//**     **',0Ah, '/**     /**/******** //****** /**     /** //*******',0Ah,  '//      // ////////   //////  //      //   ///////$'
   menu db 'ESTE PROGRAMA CIFRA O DESCIFRA UN ARCHIVO',0Ah,'SEGUN SE SELECCIONE',0Ah,0Ah,'<c> CIFRADO',0Ah,'<d> DESCIFRADO',0Ah,0Ah,'$'
   askSource db 'ESCRIBE EL NOMBRE DEL ARCHIVO FUENTE:',0Ah,'{el nombre no debe ser largo}',0Ah,'$'
   askDest db 'ESCRIBE EL NOMBRE DEL ARCHIVO DESTINO:',0Ah,'{el nombre no debe ser largo}',0Ah,'{si el archivo ya existe puede sobreescribirse}',0Ah,'$'
   errr db 'ERROR!!!!!$'
   noChoice db 0Ah,'NO EXISTE ESA OPCION. INTENTE DE NUEVO',0Ah,'$'
   closing db 0Ah,'LIMITE DE ERRORES. EL PROGRAMA SE CERRARA',0Ah,'$'
   buffer db ' $';
   OpenErrorMSG db 'Error al abrir archivos$'
   rfmsg db 'No se puede leer el archivo$'
   cfmsg db 'Error al cerrar archivos$'
   wfmsg db 'No se pudo escribir en el archivo$'
   sourceHandle dw ?
   destHandle dw ?
   choice db ?

.code
inicio:
   mov ax,@data
   mov ds,ax

   call cls
   printString menu
   call getChoice
   call cls
   printString askSource
   saveString sourceFile
   call cls
   printString askDest
   saveString destFile
   call createDestFile
   call cls
   call openFiles
   jc fin
   call readAndCode
   call closeFile
   printDONE
fin:
   mov ah,4ch
   int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls proc
    mov ax,0003h
    int 10h
    ret
cls endp

getChoice proc
   xor bl,bl
lup:
   mov ah,08h
   int 21h

   cmp al,63h
   je fine
   cmp al,43h
   je fine
   cmp al,64h
   je fine
   cmp al,44h
   je fine

   inc bl
   cmp bl,4
   je noFine

   printString noChoice
   jmp lup

fine:
   mov choice,al
   ret
noFine:
   printString closing
   jmp fin
getChoice endp


createDestFile proc
    mov cx,0
    mov ah,3ch
    lea dx,destFile
    add dx,2
    int 21h
    jc er
    mov destHandle,ax
rit:
    ret
er:
   printString errr
   jmp rit
createDestFile endp

openFiles proc
   xor ax,ax
   lea dx,sourceFile
   add dx,2
   mov ah,3dh
   int 21h
   jc openError0
   mov sourceHandle,ax

   mov al,11000010b
   lea dx,destFile
   add dx,2
   mov ah,3dh
   int 21h
   jc openError0
   mov destHandle,ax

huhu:
   ret
openError0:
   lea dx,OpenErrorMSG
   mov ah,9
   int 21h
   jmp huhu          
openFiles endp
;------------------------
readAndCode proc
lee:
   mov ah,3fh
   mov bx,sourceHandle
   lea dx,buffer
   mov cx,1
   int 21h
   jc errorRead
   cmp ax,0
   jz eoff

   validar

   mov bl,choice

   cmp bl,063h
   je cifrado
   cmp bl,43h
   je cifrado

   cmp bl,064h
   je descifrado
   cmp bl,044h
   je descifrado

   printString errr

   jmp fin

keepChar:
imprimir:

   call escribir
   jmp lee
eoff:
   ret
cifrado:
   call cesar
   jmp keepChar
descifrado:
   call cesarInv
   jmp keepChar
errorRead:
   lea dx,rfmsg
   mov ah,9
   int 21h
   jmp eoff
readAndCode endp
;__________________________________
cesar proc
   mov dl,[buffer]
   mov dh,57h
   mov cx,4
et1:
   inc dh
   cmp dl,dh
   je fix1
   xor dh,20h
   cmp dl,dh
   je fix1
   loop et1
reg1:
   add dl,3
   mov buffer,dl
   ret
fix1:
   sub dl,26
   jmp reg1
endp
;_____________________________
cesarInv proc
   mov dl,[buffer]
   mov dh,44h
   mov cx,4
etI:
   dec dh
   cmp dl,dh
   je fixI
   xor dh,20h
   cmp dl,dh
   je fixI
   loop etI
regI:
   sub dl,3
   mov buffer,dl
   ret
fixI:
   add dl,26
   jmp regI
endp
;________________________________
escribir proc
   mov ah,40h
   mov bx,destHandle
   lea dx,buffer
   mov cx,1
   int 21h
   jc errorWrite
final:
   ret
errorWrite:
   printString wfmsg
   jmp final
escribir endp
;_______________________________
closeFile proc
   mov ah,3eh
   mov bx,sourceHandle
   int 21h
   jc errorClose

   mov ah,3eh
   mov bx,destHandle
   int 21h
   jc errorClose

   ret
errorClose:
   lea dx,cfmsg
   mov ah,9
   int 21h
   ret
closeFile endp
end inicio
