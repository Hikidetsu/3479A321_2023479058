import 'package:flutter/material.dart';

//el objetivo de esta pantalla es guardar las listas que vamos a mostrar en la pantalla de creacion
//lista con los elementos que queremos mostrar
final List<String> elementos = [
    "Creacion 1",
    "Creacion 2",
    "Creacion 3",
  ];

//lista con las imagenes que queremos mostrar
final List<String> imagenes = [
    "assets/Pixel-Art-Hot-Pepper-2-1.webp",
    "assets/Pixel-Art-Pizza-2.webp",
    "assets/Pixel-Art-Watermelon-3.webp",
  ];



class ListArtScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixel Art List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Lista de pixel art disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}