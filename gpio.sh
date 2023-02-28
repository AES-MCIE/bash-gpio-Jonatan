#!/bin/bash

echo "Script ejecutandose"
Ngpio=$1
mod=$2
gpio=/sys/class/gpio/gpio
control=0
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
{	if [ $on == 1 ]; then 
		echo 1 >> $gpio$Ngpio/value
		echo "Gpio No. $Ngpio = ON"
	elif [ $on == 0 ]; then 
		echo 0 >> $gpio$Ngpio/value
		echo "Gpio No. $Ngpio = OFF"
	fi
}

if [ $# != 2 ]; then
	echo "Error en el numero de argumentos"
	echo "Ingresa ./gpio.sh 0 help 0 para mas informacion"
	control=1
	exit 2
fi

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
		echo "./gpio.sh x help 0     Ayuda con comandos"                                                                                                                                
		echo ""
		echo "NOTA: En la x se indica el numero del pin a modificar."                                                                                                              
		echo "En el caso del comando help, se puede colocar cualquier numero en la x, eso no influye en el comando"
		echo "Cuando se coloca un pin"
		exit 0
	else
		echo "No se reconoce el comando, intenta con ./gpio.sh 0 help"
	fi
fi
