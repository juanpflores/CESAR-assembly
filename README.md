# CESAR-assembly
CESAR es un programa creado en ensamblador para procesadores x8086 con el objetivo de cifrar cualquier tipo de documento utilizando cifrado CESAR.

##Introducción
El Cifrado Cesár, que lleva su nombre en honor a Julio César, es un tipo de cifrado que se utilizaba para documentos militares durante su gobierno. Se le atribuye haber sido la primera persona en utilizar esta codificación aunque no el primero en cifrar sus mensajes. 

Este cifrado también forma parte de otros cifrados los cuales son más complicados de decifrar como los son el cifrado Vigenerè y el istema ROT13.

Para poder codificar un mensaje. Lo único que se debe de hacer es tomar un mensaje y a cada una de las lestras del mensaje se le colocan la letra que se encuentre seis letras hacia adelante. 

Por ejemplo:

    Texto original:   ABCDEFGHIJKLMNÑOPQRSTUVWXYZ
    Texto codificado: GHIJKLMNÑOPQRSTUVWXYZABCDEF

Por otro lado para poder descodificar el mensaje lo que se hace es tomar cada letra del mensaje cifrado y mover seis lugares hacia la izquierda lo que nos devolverá el mensaje origianl. 

Por ejemplo:

    Texto codificado :  GHIJKLMNÑOPQRSTUVWXYZABCDEF
    Texto original:     ABCDEFGHIJKLMNÑOPQRSTUVWXYZ

###Vulnerabilidades
El cifrado César es un tipo de cifrado muy sencillo de resolver. La manera más común de romper este tipo de cifrado es probando cada uno de los desplazamiento posibles. Como el alfabeto español tiene 25 caracteres se pueden hacer varias pruebas para conocer el numero de desplazamientos que haga mas sentido al momento de decifrar el mensaje con tan solo cinco letras del mensaje. 

De esta manera no lleva mucho timepo decodificar el cifrado y obtener el mensaje.

##Objetivos
- Aplicar los concocimientos aprendidos en las materia de Estrcutura y Programación de computadoras durante el semestre 2016-1.
- Objetivo 2

##Desarrollo
Agregar texto sobre desarrollo.

### Algortimo


### Diagrama de Flujo



### Compilación
Para compilar el codigo .asm primero es necesario tener [DOSbox](http://www.dosbox.com/) y tener el archivo en la carpeta root del programa.

Primero debemos ensamblar el código utilizando "Turbo Assembler":

	c:\> TASM CESAR.ASM

Este ensamblaje nos dará un archivo .OBJ el cual debemos de  Después, usamos "Turbo Linker (TLINK)" para generar un archivo ejecutable .EXE que podamos correr en DOSBOX.

	c:\> TLINK CESAR.OBJ

Por último, corremos el ejecutable en DOSbox y podemos cifrar y decifrar los archivos que buscamos.
    
    c:\> CESAR.EXE


##Conclusiones
Add personal conclusions


##Equipo
- Flores cortés Juan Pablo 
- Martinez Naredo Noé       

##Referencias 
- Singh, Simon; "Cesar"; *The Black Chamber* ; <http://www.simonsingh.net/The_Black_Chamber/caesar.html>
