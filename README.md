## Prod

Es importante que en cada paso si tienes VSC o AS abierto es posible que se requiera reiniciar el IDE para que se efectuen los cambios, como algunos comandos del paso 7.

1. Descargar Java JDK 17 y agregarlo al path del sistema (carpeta bin) y una nueva variable llamada ```JAVA_HOME``` que apunte a la carpeta "C:...\Java\jdk-17".
2. Descargar Android Studio, y añadir el plugin de Android toolchain para las licencias (Ejecuta en consola el comando ```flutter doctor``` y te mostrara lo que falta para ejecutar flutter, el que no es necesario es el Visual Studio - develop windows apps).
3. (Opcional) Activar la virtualizacion desde la BIOs (si no esta activada) para poder agregar un emulador de android  con Andorid Studio en la pestaña de configuracion de Virtual Device Manager (VDC), tamaño Pixel XL.
4. Abierto el repo, ejecuta flutter pub get para las dependencias

5. Revisa que en la ca<https://www.youtube.com/watch?v=nqAIz7Pkbp0&t=680s>ngs.gradle, build.gradle y local.properties

6. Cambiar el nombre del package en la terminal del repo con la libreria change_app_package_name asi:
```flutter pub run change_app_package_name:main com.unicesar.edupro```

7. Ver este tutorial  para tener FlutterFire CLI (Completo, al final del video aclara una cosa) <https://www.youtube.com/watch?v=nqAIz7Pkbp0&t=680s>.
