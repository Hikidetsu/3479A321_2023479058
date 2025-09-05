import 'package:flutter/material.dart';
import 'list_art.dart'; //importamos la pantalla anterior para poder hacer uso de las listas que creamos



class ListCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creaciones'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Lista de creaciones disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Expanded( //para que la lista ocupe todo el espacio disponible
            child: ListView.builder( //creamos una lista para poder ver los elementos de forma ordenada
              itemCount: elementos.length, //utilizamos la variable que creamos en la lista de la pantalla de list_art.dart
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(elementos[index]),//mostramos los elementos de la lista
                  trailing: const Icon(Icons.image),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(elementos[index]),
                          ),
                          body: Center(
                            child: Image.asset(imagenes[index]),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); //creamos un boton para volver a la pantalla principal
                },
                child: const Text('Volver'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
