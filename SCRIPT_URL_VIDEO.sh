
#!/bin/bash

# Autor:                Jose Gonzalo Maza Bolaños

#Este codigo esta programado exactamente para que el usuario ingrese la URL de youtube

# Comenzamos creando una funcion en caso el usuario no tenga las herramientas instaladas
Comprobamos() {
    if ! command -v yt-dlp &> /dev/null; then
        echo "yt-dlp no está instalado. Instalando..."
            wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp 
            chmod +x /usr/local/bin/yt-dlp
    fi
    if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg no está instalado. Instalando..."
        sudo apt install ffmpeg
    fi
}

# Comprobar y instalar herramientas necesarias.
Comprobamos "yt-dlp"
Comprobamos "ffmpeg"

# Utilizamos el "read" para pedir al usuario la URL de YouTube y lo guardamos en una variable.
read -p "Introduce la URL de YouTube: " youtube_url


# Aqui procederemos a solicitar los datos del formato disponible del video.
echo "Comenzamos con la descarga del video de youtube"
yt-dlp -f "bv+ba/b" -o "video" $youtube_url
nombre_video="video"
# Pedir al usuario que elija el formato del video
yt-dlp -F $youtube_url

read -p "Elige el formato del video (código del formato): " video_format

#       --- AQUI EXTRAEMOS EL AUDIO Y EL VIDEO POR SEPARADO ---

# Extraer el audio del video y guardarlo como MP3
echo "Extrayendo audio del video..."
ffmpeg -i video.webm -vn audio.mp3
# Crear una versión del video sin audio en un formato comprimido
echo "Creando versión del video sin audio..."
ffmpeg -i video.webm -an video_sin_audio.mp4

#       --- AHORA SOLICITAMOS INFORMACIÓN ---

# Mostrar información del audio y del video
echo "Información del audio:"
ffmpeg -i audio.mp3
echo "Información del video sin audio:"
ffmpeg -i video_sin_audio.mp4
# Procederemos a ejecutar un mensaje de satisfación.
echo "Proceso completado."