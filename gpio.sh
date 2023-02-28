#!/bin/bash

echo "Script ejecutandose"
Ngpio=$1
mod=$2
gpio=/sys/class/gpio/gpio
control=0
pines=(30 31 48 4 13 3 49 117 125 111 110 20 60 40 51 5 12 2 15 14 123 112 7 38 34 66 69 45 23 47 27 22 62 36 32 86 87 10 9 8 78 76 74 72 70 39 35 67 68 44 26 46 65 63 37 33 61 88 89 11 81 80 79 77 75 73 71)
controlPines=0

function gpioUnexport
{
	echo 24 >> /sys/class/gpio/unexport
	echo "gpioUnexport succesfull"
}

function gpioExport
{
	echo 24 >> /sys/class/gpio/export
	echo "gpioExport succesfull"
}

function gpioDirection
{
	if [ $mod == "out" ]; then
		echo out >> $gpio$Ngpio/direction
		echo "Gpio No. $Ngpio -> OUT"
	elif [ $mod == "in" ]; then 
		echo in >> $gpio$Ngpio/direction
		echo "Gpio No. $Ngpio -> IN"
	fi 
}

function gpioValue
{	if [ $mod == "on" ]; then 
		echo 1 >> $gpio$Ngpio/value
		echo "Gpio No. $Ngpio = ON"
	elif [ $mod == "off" ]; then 
		echo 0 >> $gpio$Ngpio/value
		echo "Gpio No. $Ngpio = OFF"
	elif [ $mod == "read" ]; then
		lectura=$(cat /sys/class/gpio/gpio$Ngpio/value)
		echo "Lectura del Gpio No. $Ngpio = $lectura"
	fi
}

if [ $# != 2 ]; then
	echo "Error en el numero de argumentos"
	echo "Ingresa ./gpio.sh 0 help para mas informacion"
	control=1
	exit 2
fi

if [[ $mod != "help" && $control==0 ]]; then
	#Verificar que el pin sea correcto
	for t in ${pines[@]}; do
		if [ $Ngpio == ${pines[$i]} ]; then
			controlPines=1
		fi
	done
	if [ $controlPines == 1 ]; then 
		#Reconocer el modo introducido
		if [[ $mod == "on" || $mod == "off" ]]; then
			#Conocer si el pin esta declarado como salida
			dato=$(cat /sys/class/gpio/gpio$Ngpio/direction)
			if [ $dato == "out" ]; then
				gpioValue
				exit 0
			#El pin no es salida
			else
				echo "El pin no ha sido asignado como salida, ingrese ./gpio.sh $Ngpio out"
				echo "Luego ingrese ./gpio.sh $Ngpio $mod"
				exit 2
			fi
		#Cambiar pin a out o in 
		elif [[ $mod == "out" || $mod == "in" ]]; then
			gpioDirection
			exit 0
		#Lectura del pin
		elif [ $mod == "read" ]; then
			dato=$(cat /sys/class/gpio/gpio$Ngpio/direction)
			#El pin si es entrada
			if [ $dato == "in" ]; then
				gpioValue
				exit 0
			else
				echo "El pin no ha sido asignado como entrada, ingrese ./gpio.sh $Ngpio in"
				echo "Luego ingrese ./gpio.sh $Ngpio $mod"
				exit 2
			fi
		fi
	else
		echo "No se encuentra el pin indicado, verifique que el numero ingresado sea el correcto"
		exit 2
	fi
fi

#Comando de ayuda 
if [[ $mod == "help" && $control==0 ]]; then
	if [ $Ngpio == 0 ]; then	
		echo "--------------------------------------------------------------------------------"		
		echo "Autor: Jonatan Ali Medina Molina"
		echo "TecNM Campus Morelia"
		echo "Maestria en Ciencias en Ing. Electronica"
		echo "--------------------------------------------------------------------------------"
		echo ""
		echo "Se requieren de 2 argumentos a la entrada"
		echo "Los comandos son: "                                                                                                                                                       
		echo "./gpio.sh x in          Coloca el pin x en modo input"                                                                                                           
		echo "./gpio.sh x out			Coloca el pin x en modo output"
		echo "./gpio.sh x on			Coloca el pin x en HIGH (Requiere que se haya colocado como OUTPUT previamente"
		echo "./gpio.sh x off			Coloca el pin x en LOW (Requiere que se haya colocado como OUTPUT previamente"		
		echo "./gpio.sh x read     Coloca el trigger en modo heartbeat del led indicado"                                                                                               
		echo "./gpio.sh 0 help      Ayuda con comandos"                                                                                                                                
		echo ""
		echo "NOTA: En la x se indica el numero del pin a modificar."                                                                                                              
		echo "Los pines validos son:"
		echo "${pines[@]}"
		exit 0
	else
		echo "No se reconoce el comando, intenta con ./gpio.sh 0 help"
	fi
fi

