# Introduction 
There are different ways and tools to access BeagleBone's GPIO hardware from programs, but `sysfs` is a simple one that is supported by the **Linux kernel** and makes the devices visible in the file system so we can work from the command line without needing to write any code. For simple applications you can use it with the `sysfs` way, either interactively or by putting the commands in shell scripts.

`Sysfs` is a pseudo filesystem provided by the **Linux kernel** that makes information about various kernel subsystems, hardware devices, and device drivers available in user space through virtual files. GPIO devices appear as part of sysfs.

# RaspberryPi 4 (RBPi4)

**Note: This code and commands have been tested directly on a RaspberryPi4. The GPIO process for the RBPi4 is quiete different fro, the BeagleBone Boards, please considers the instructions for RBPi4 or BBB.**

## Basic considerations

![](./rbpi4.png)

## First steps

The system has some `sysfs` GPIO drivers already loaded, you can search for them at `/sys/class/gpio/`:
```
ls /sys/class/gpio
export  gpiochip0  gpiochip504  unexport
```
We'll look at how to use this interface next. Note that the device names starting with "gpiochip" are the GPIO controllers and we won't directly use them.

Next, the basic steps to use a GPIO pin from the `sysfs` interface are:

1. Export the pin.
2. Set the pin direction (input or output).
3. If an output pin, set the level to low or high.
4. If an input pin, read the pin's level (low or high).
5. When the gpio is not used anymore, unexport the pin.

Thus, to make available the GPIO24 as an output and write a logic 1, we should do:

Export the GPIO24 by
```
echo 24 >> /sys/class/gpio/export
```
then, the `gpio24` linksys file is abilable at
```
ls /sys/class/gpio/
export  gpio24  gpiochip0  gpiochip504  unexport
```
you can go now and observe inside the `gpio24` folder a series of configuration files
```
ls /sys/class/gpio/gpio24/
active_low  device  direction  edge  power  subsystem  uevent  value
```
the ones that we require for now are the `direction` and `value`, then, to make the GPIO24 an output write a logic 1 (3V):
```
echo out >> /sys/class/gpio/gpio24/direction
echo 1 >> /sys/class/gpio/gpio24/value
```

# BeagleBone Black

## Basic considerations

![](./bbb.png)


# Control de GPIOs de BeagleBone Black
Este script sirve para controlar los GPIOs, pudiendo cambiarlos a entrada o salida, y leyendo o escribiendo en un pin especifico. Lo anterior se realiza ejecutando el comando
`./gpio.sh` y colocando como argumentos No. de pin, entrada/salida y encender/apagar/leer. 

**IMPORTANTE**

Para poder ejecutar el script se debe estar en la carpeta donde esta almacenado el archivo y este debe de tener
permisos de ejecucion. 

Los permisos de ejecucion se pueden visualizar con el comando: 
```
ls -l
```
El archivo `gpio.sh` debe de tener los permisos `-rwxr-xr-x`.
En caso de que no se visualice la `x`, que es el permiso de ejecucion, se le puede agregar con el siguiente
comando: 
```
sudo chmod +x gpio.sh
```
Todo lo anterior es considerando que se encuentra en la carpeta donde esta almacenado el archivo. 

# Modo de uso
Para cambiar un GPIO se debe ejecutar el comando `gpio.sh` y pasar tres argumentos: No. pin o `0`; `in`, `out`
o `help`; y `on`, `off`, `read` o `0`.

Entonces, ejecuanto el comando `./gpio.sh 60 out on` coloca el pin 60 como salida y en estado alto. 

Los comandos disponibles son: 

Comando de ayuda.
```
./gpio.sh 0 help 0
```

Pin x como salida y en alto. 
```
./gpio.sh x out on
```

Pin x como salida y en bajo. 
```
./gpio.sh x out off
```

Pin x como entrada y lectura. 
```
./gpio.sh x in read
```

**En la x se debe colocar el pin que se desea modificar, a continuacion se muestran los pines disponibles**

**PINES DISPONIBLES**: 30, 31, 48, 4, 13, 3, 49, 117, 125, 111, 110, 20, 60, 40, 51, 5, 12, 2, 15, 14, 123, 112, 7, 38, 34, 66,
69, 45, 23, 47, 27, 22, 62, 36, 32, 86, 87, 10, 9, 8, 78, 76, 74, 72, 70, 39, 35, 67, 68, 44, 26, 46, 65, 63, 37,
33, 61, 88, 89, 11, 81, 80, 79, 77, 75, 73, 71.
 
