# Flutter Intermedio: Diseños profesionales y animaciones

Del curso de Fernando Herrera: https://cursos.devtalles.com/courses/flutter-Intermedio

## Backgrounds - Custom Painter

Solo he creado un nuevo proyecto llamado `design_app`

### Temas puntuales de la sección

En esta sección tocaremos los siguientes temas:

- CustomPainter
- Paint
- LineTo
- ¿Cómo coloreamos una figura?
- Diferentes fondos de aplicaciones
- QuadraticBezierTo
- Dimensiones donde podemos pintar
- Canvas

### Header cuadrado

En la carpeta `lib` creo una carpeta `src`.

En la carpeta `src` creo dos carpetas, una llamada `pages` y otra llamada `widgets`.

En la carpeta `widgets` creo un archivo llamado `headers.dart`. Aquí se crearán todas las clases necesarias de cada uno de los diseños.

Creo la clase `HeaderCuadrado`.

En la carpeta `pages` creo un archivo llamado `headers_page.dart`. Este archivo llamará a las distintas clases de `headers.dart`.

### Header circular

Añadimos una clase `HeaderBordesRedondeados` a `headers.dart` que llamamos desde `headers_page.dart`.

### Presentación sobre el customPainter

El CustomPainter necesita dos métodos, uno llamado `paint()` y otro llamado `shouldRepaint()` que siempre vamos a hacer que devuelva true porque nuestros diseños son muy sencillos y no demandan mucho del procesador ni de la memoria. Si el diseño fuera muy complejo, `shouldRepaint()` debería de devolver false.

El método `void paint(Canvas canvas, Size size)` se sobreescribe. El canvas es el lienzo donde se puede diseñar (la pantalla) y el Size es el tamaño que tiene ese Canvas, la dimensión de la pantalla que tengamos.

El CustomPainter nos da también un pequeño lápiz que podemos mover y dibujar lo que queramos, usando coordenadas.

La esquina superior izquierda es la `(0, 0)`. La esquina inferior izquierda es `(0, size.height)`.

La esquina superior derecha es la `(size.width, 0)`. La esquina inferior derecha es `(size.width, size.height)`.

Si estamos en la posición centro-derecha, las coordenadas serían `(size.width, size.height * 0.5)`.

### Header diagonal

Añadimos las clases `HeaderDiagonal` y `_HeaderDiagonalPainter` a `headers.dart` que llamamos desde `headers_page.dart`.

### Header triángulo

Añadimos las clases `HeaderTriangular` y `_HeaderTriangularPainter` a `headers.dart` que llamamos desde `headers_page.dart`.

### Header pico

Añadimos las clases `HeaderPico` y `_HeaderPicoPainter` a `headers.dart` que llamamos desde `headers_page.dart`.

### Header curvo

Añadimos las clases `HeaderCurvo` y `_HeaderCurvoPainter` a `headers.dart` que llamamos desde `headers_page.dart`.

### Header waves

Añadimos las clases `HeaderWave` y `_HeaderWavePainter` a `headers.dart` que llamamos desde `headers_page.dart`.

### CustomPainter con gradiente

Añadimos las clases `HeaderWaveGradient` y `_HeaderWaveGradientPainter` a `headers.dart` que llamamos desde `headers_page.dart`.
