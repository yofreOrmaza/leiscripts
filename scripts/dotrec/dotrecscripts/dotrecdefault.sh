#!/bin/bash

clear

echo "Lista de Monitores"

xrandr | grep " connected"

echo

# pactl list short sources
mic=
pcAudio=
videoFormat=mkv

resolucionDeMonitor=
framerateDeGrabacion=
coordenadasDeGrabacion=
read -p "Nombre de Archivo de Grabación: " nombreDeArchivoDeGrabacion
nombreDeArchivoFinal=${nombreDeArchivoDeGrabacion:-salida} # Esta variable de "Final" se crea con el objetivo de que si el valor del nombre de grabación solicitado al usuario es vacio, pues para no causar errores se le asigna un valor por defecto

ffmpeg \
  -f x11grab -video_size $resolucionDeMonitor -framerate $framerateDeGrabacion -i :0.0+$coordenadasDeGrabacion \
  -f pulse -i $mic \
  -f pulse -i $pcAudio \
  -filter_complex amix=inputs=2 \
  "$HOME/$nombreDeArchivoFinal.$videoFormat"
