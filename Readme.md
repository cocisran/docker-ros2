# Contenedor para ros2 v1

Este contenedor despliega un imagen que contiene ros2, sobre ubuntu 22. 

## Para el despliegue

### 1. Instalar docker en la rasperry 
TODO

### 2. Construir la imagen a partir del docker file

Clona este repositorio, y muevete al directorio donde lo guardaste. 

Desde la raiz del repositorio ejecuta:

```Bash
docker build --build-arg SUDO_PSW=<contraseña para sudo> -t ros-humble-image .
```
La contraseña la define el usuario, y se usara para acceder a ros2

### 3. Desplegar imagen

Una vez construida la imagen para desplegarla de manera interactiva:

```
docker run -p 11311:11311 -it ros-humble-image
```

Esto hace que la imagen desplegada publique en el puerto  11311 y se mapee al puerto 11311 del local host.

TODO red de contendores