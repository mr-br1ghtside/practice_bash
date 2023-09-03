#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Titulo
tput civis
echo -e "${yellowColour}-- CALCULO DE CAUDALES --${endColour}\n"
sleep 1

echo -e "${redColour} GRUPO 1 ${endColour}"
sleep 2
echo -e "${blueColour}Utilizando el metodo aritmetico${endColour}"
tput cnorm

#
echo -e "${yellowColour}1. PROCEDIMIENTO DE CALCULOS${endColour}"
sleep 2

echo -e "${blueColour}\t\n1.1 Calculo de poblacion${endColour}"

echo -e "${grayColour}\n Ingrese la poblacion incial: ${endColour}"
read pob_inicial


echo -e "${grayColour}\n Ingrese la tasa de crecimiento: ${endColour}"
read tasa_grow

echo -e "${grayColour}\n Ingrese la T: ${endColour}"
read te

echo -e "${greenColour}\n Calculando.......${endColour}"
sleep 0

pob_final=$(($pob_inicial * (1 + ($tasa_grow * $te)) | bc))

echo -e "${grayColour}\nLa poblacion final es:${endColour}${redColour} $pob_final${endColour}"
sleep 0


echo -e "\n---------------------------------------------------------------------"

echo -e "${blueColour}1.2 Calculo de caudal promedio domestico${endColour}"
sleep 0

echo -e "\n${grayColour}Ingrese dotacion: ${endColour}"
read dota

echo -e "\n${grayColour}Ingrese poblacion inicial: ${endColour}"
read pob_inicial

echo -e "${greenColour}\n Calculando.......${endColour}"
sleep 0

cauprom_dom=$(echo "scale=3; ($pob_inicial * $dota) / 86400" | bc)
echo -e "\n${grayColour}Qpd =${endColour}${redColour} $cauprom_dom${endColour}${grayColour} l/s${endColour}"
sleep 3


echo -e "\n---------------------------------------------------------------------"
sleep 1

echo -e "${blueColour}1.3 Calculo de caudal promedio no domestico${endColour}"
sleep 2

echo "Ingrese la cantidad de infraestructura no domestica:"
read cantidad_caudal

suma_caudal=0

for ((i=1; i<=$cantidad_caudal; i++))
do
    echo -e "Ingrese el Qpromedio de la infraestructura $i:\n"
    read caudal
    suma_caudal=$(echo "$suma_caudal + $caudal" | bc)
done

echo "La suma promedio de los $cantidad_caudal caudales es: $suma_caudal"

echo -e "\n---------------------------------------------------------------------"


echo -e "${blueColour}1.4 Calculo de caudal promedio total${endColour}"
sleep 2

echo -e "${greenColour}\n Realizando calculos con los datos anteriores.......${endColour}"
sleep 3

#cauprom_total=$(($cauprom_dom + $cauprom_nodom | bc))
cauprom_total=$(echo "scale=5; $cauprom_dom+$suma_caudal" | bc)
echo -e "Qt = $cauprom_total l/s"


echo -e "\n---------------------------------------------------------------------"

echo -e "${blueColour}1.5 Calculo de caudal promedio total de perdidas${endColour}"
sleep 2

echo -e "\n${grayColour}Ingrese el caudal de perdidas: ${endColour}"
read cau_lost

echo -e "${greenColour}\n Calculando.......${endColour}"
sleep 3

qptp=$(echo "scale=5; $cauprom_total+$cau_lost" | bc)
#cauprom_total=$(echo "scale=5; $cauprom_dom+$suma_caudal" | bc)

echo -e "\nQptp == $qptp l/s"
sleep 2

echo -e "\n---------------------------------------------------------------------"

echo -e "${blueColour}1.6 Calculo de caudal maximo diario${endColour}"
sleep 2

echo -e "\n${grayColour}Ingrese el coeficiente de variacion diario (k1): ${endColour}"
read k1

echo -e "${greenColour}\n Calculando.......${endColour}"
sleep 3

qmd=$(echo "$k1 * $qptp" | bc)

echo -e "qmd == $qmd l/s"


# caudal maximo horario
echo -e "\n---------------------------------------------------------------------"

echo -e "${blueColour}1.6 Calculo de caudal maximo horario${endColour}"
sleep 3

echo -e "\n${grayColour}Ingrese el coeficiente de variacion horario (k2): ${endColour}"
read k2

echo -e "${greenColour}\n Calculando.......${endColour}"
sleep 3

qmh=$(echo "$k2 * $qptp" | bc)
echo -e "Qmh === $qmh l/s"


echo -e "\n---------------------------------------------------------------------"

echo -e "Para realizar tu proyeccion de caudales, repetir el procedimiento segun los años de tu periodo de diseño.\n"







