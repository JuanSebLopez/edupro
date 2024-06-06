# edupro

-- Descripcion Aplicación --

## Getting Started

Para comenzar con este proyecto, siga estos pasos:

1. **Instalar Flutter**: Si aún no lo has hecho, [instalar Flutter](https://flutter.dev/docs/get-started/install) de la página web oficial.

2. **Clona el Proyecto**: Descargue o clone este repositorio y ábralo en su IDE preferido, preferiblemente Visual Studio Code.

3. **Instalar Dependenciass**: Abra una terminal dentro del directorio de su proyecto y ejecute el siguiente comando para instalar todas las dependencias:
    ```flutter pub get```

4. **Instalar Firebase CLI**: Si no ha instalado Firebase CLI [instalar Firebase CLI](https://firebase.google.com/docs/cli?hl=en#windows-npm), ejecute el siguiente comando para instalar firebase-tools en su dispositivo:
    ```npm install -g firebase-tools```

5. **Iniciar Sesión Firebase**: En la misma terminal ejecute el siguiente comando para iniciar sesión con su cuenta de Google vinculada al proyecto:
    ```firebase login```

6. **Activar FlutterFire CLI**: Abra la terminal del directorio de su proyecto y ejecute el siguiente comando para inicialiar FlutterFire CLI en el proyecto:
    ```dart pub global activate flutterfire_cli```

7. **Configuar FlutterFire**: En la terminal del directorio ejecute el siguiente comando para configurar FlutterFire (Seleccione el proyecto actual):
    ```flutterfire configure```

8. **Selecciona Plataformas**: Después de ejecutar ```flutterfire configure``` aparecerán opciones para las plataformas que desee la aplicación, selecciona android e ios principalmente (Si necesita usar una plataforma distinta hacerlo desde otra rama).

9. **Configurar Gradle**: Luego, deberá aceptar ambas configuraciones de Firebase para Gradle.

10. **Ejecuta la Aplicación**: Finalmente ejecute el siguiente comando para correr la aplicación:
    ```flutter run```
