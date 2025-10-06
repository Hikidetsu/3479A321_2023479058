import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre...'),
      ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Informacion del desarrollador del proyecto:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ), 
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:  () {
              Navigator.pop(context);
            },
            child: const Text('Volver'),
            
          ),
        ],
      ),
    )
    );
  }
}