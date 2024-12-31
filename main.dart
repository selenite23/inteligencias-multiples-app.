import 'package:flutter/material.dart';

void main() {
  runApp(InteligenciasApp());
}

class InteligenciasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'VanillaRavioli'),
      home: PantallaBienvenida(),
    );
  }
}

class PantallaBienvenida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFBE8E7), Color(0xFFF6D1F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/fox_with_glasses.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Hola, ¿cómo estás?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '¿Sabías que existen diferentes tipos de inteligencias? '
                  'Descubre cuál es la tuya con este divertido cuestionario.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaCuestionario()),
                  );
                },
                child: Text('¡Descubre tus inteligencias!'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFAA76C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PantallaCuestionario extends StatefulWidget {
  @override
  _PantallaCuestionarioState createState() => _PantallaCuestionarioState();
}

class _PantallaCuestionarioState extends State<PantallaCuestionario> {
  final List<Map<String, Object>> preguntas = [
    {'pregunta': 'Me encanta leer libros, revistas o artículos.', 'tipo': 'lingüística'},
    {'pregunta': 'Disfruto resolver problemas matemáticos o científicos.', 'tipo': 'lógico-matemática'},
  ];

  int preguntaActual = 0;
  Map<String, int> puntajes = {};

  void responder(int valor) {
    final tipo = preguntas[preguntaActual]['tipo'] as String;
    puntajes[tipo] = (puntajes[tipo] ?? 0) + valor;

    if (preguntaActual < preguntas.length - 1) {
      setState(() {
        preguntaActual++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PantallaResultados(puntajes: puntajes)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuestionario'),
        backgroundColor: Color(0xFFAA76C9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pregunta ${preguntaActual + 1}/${preguntas.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              preguntas[preguntaActual]['pregunta'] as String,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ...List.generate(5, (index) {
              return ElevatedButton(
                onPressed: () => responder(index + 1),
                child: Text('${index + 1}'),
                style: ElevatedButton.styleFrom(primary: Color(0xFFAA76C9)),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class PantallaResultados extends StatelessWidget {
  final Map<String, int> puntajes;

  PantallaResultados({required this.puntajes});

  @override
  Widget build(BuildContext context) {
    final resultadosOrdenados = puntajes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        backgroundColor: Color(0xFFAA76C9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tus inteligencias predominantes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Primera: ${resultadosOrdenados[0].key}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Segunda: ${resultadosOrdenados[1].key}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Menos destacada: ${resultadosOrdenados.last.key}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver al inicio'),
              style: ElevatedButton.styleFrom(primary: Color(0xFFAA76C9)),
            ),
          ],
        ),
      ),
    );
  }
}
