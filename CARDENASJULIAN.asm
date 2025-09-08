# Programa para encontrar el numero menor entre 3-5 numeros


.data
    # Mensajes para el usuario final
    msg_cantidad: .asciiz "Ingrese cuantos numeros desea comparar  entre y 3-5: "
    msg_numero: .asciiz "Ingrese numero: "
    msg_menor: .asciiz "El numero menor es: "
    msg_error: .asciiz "Error: Debe ingresar un numero valido entre 3 y 5\n"
    msg_salto: .asciiz "\n"
    
    # Variables
    cantidad: .word 0       # variable para almacenar la cantidad de numeros
    numeros: .word 0, 0, 0, 0, 0  # Array para almacenar los numeros de hasta maximo 5
    menor: .word 0          # variable para almacenar el numero menor

.text
.globl main

main:
    # Mostrar mensaje para pedir cantidad
    li $v0, 4
    la $a0, msg_cantidad
    syscall
    
    # Leer cantidad de numeros
    li $v0, 5
    syscall
    sw $v0, cantidad
    
    # Validar que el numero que ingreso el usuario final este entre 3 y 5
    lw $t0, cantidad
    blt $t0, 3, error_cantidad
    bgt $t0, 5, error_cantidad
    
    # Inicializar contador y puntero
    li $t1, 0          # Contador de numeros leidos
    la $t2, numeros    # Puntero al array de numeros
    
leer_numeros:
    # Mostrar mensaje para pedir numero
    li $v0, 4
    la $a0, msg_numero
    syscall
    
    # Leer el numero
    li $v0, 5
    syscall
    
    # Guardar numero en el array
    sw $v0, 0($t2)
    addi $t2, $t2, 4   # Siguiente posicion en el array
    
    addi $t1, $t1, 1   # Incrementar contador
    lw $t0, cantidad
    blt $t1, $t0, leer_numeros
    
    # Encontrar el numero menor
    li $t1, 0          # Contador
    la $t2, numeros    # Puntero al array
    lw $t3, 0($t2)     # Primer numero como menor inicial
    sw $t3, menor
    
buscar_menor:
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    lw $t0, cantidad
    bge $t1, $t0, mostrar_resultado
    
    lw $t4, 0($t2)
    lw $t3, menor
    bge $t4, $t3, buscar_menor
    sw $t4, menor
    j buscar_menor
    
mostrar_resultado:
    # Mostrar mensaje del resultado
    li $v0, 4
    la $a0, msg_menor
    syscall
    
    # Mostrar numero menor
    li $v0, 1
    lw $a0, menor
    syscall
    
    # Mostrar salto de linea
    li $v0, 4
    la $a0, msg_salto
    syscall
    
    # Salir del programa
    j salir
    
error_cantidad:
    # Mostrar mensaje de error si el usuario final no pone un numero entre 3 y 5
    li $v0, 4
    la $a0, msg_error
    syscall
    
salir:
    # Salir del programa
    li $v0, 10
    syscall
