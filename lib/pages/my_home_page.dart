import 'package:flutter/material.dart';
import 'package:lab2/pages/list_art.dart';
import 'package:lab2/pages/list_creation.dart';
import 'package:lab2/pages/about.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onChangeColor,
    required this.newColor,
  });

  final String title;
  final VoidCallback onChangeColor;
  final Color newColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _goToCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListCreation()),
    );
  }

  void _goToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About()),
    );
  }

  void _goToArt(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListArtScreen()),
    );

  }

  List<Widget> _buildFooterButtons() {
    return [
      ElevatedButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
      ElevatedButton(
        onPressed: _decrementCounter,
        child: const Icon(Icons.remove),
      ),
      ElevatedButton(
        onPressed: _resetCounter,
        child: const Icon(Icons.refresh),
      ),
      ElevatedButton(
        onPressed: widget.onChangeColor,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.newColor,
        ),
        child: const Icon(Icons.color_lens),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            
            icon: const Icon(Icons.message, color: Colors.yellow, size: 50),
            onPressed: _goToAbout,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Card(
              elevation: 9,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row( /*
                      children: [
                        Image.asset('assets/Pixel-Art-Hot-Pepper-2-1.webp',
                            width: 200, height: 200, fit: BoxFit.cover),
                        const SizedBox(width: 12),
                        Image.asset('assets/Pixel-Art-Pizza-2.webp',
                            width: 200, height: 200, fit: BoxFit.cover),
                        const SizedBox(width: 12),
                        Image.asset('assets/Pixel-Art-Watermelon-3.webp',
                            width: 200, height: 200, fit: BoxFit.cover),
                      ],*/
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _goToCreation,
                        icon: const Icon(Icons.add),
                        label: const Text("Crear"),
                      ),
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.share),
                        label: const Text("Compartir"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: _buildFooterButtons(),
    );
  }
}
