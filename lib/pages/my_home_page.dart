import 'package:flutter/material.dart';
import 'package:lab2/pages/list_art.dart';
import 'package:lab2/pages/list_creation.dart';
import 'package:lab2/pages/about.dart';
import 'package:lab2/pages/pixel_art_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageDetailScreen extends StatelessWidget {
  final File imageFile;
  final String title;

  const ImageDetailScreen({
    super.key,
    required this.imageFile,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.file(imageFile, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

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
      MaterialPageRoute(
        builder: (context) => const PixelArtScreen(title: 'Pixel Art Screen'),
      ),
    );
  }

  void _goToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About()),
    );
  }

  void _goToArt() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListCreation()),
    );
  }

  Future<File?> getLatestCreation() async {
    try {
      final provider = ListArt();
      await provider.loadCreations();

      if (provider.imagenes.isEmpty) {
        return null;
      }
      return provider.imagenes.last;
    } catch (e) {
      print("Error al obtener la última creación: $e");
      return null;
    }
  }

  Future<void> _openLatestCreation() async {
    final latestFile = await getLatestCreation();

    if (latestFile == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No hay creaciones guardadas.")),
      );
      return;
    }

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          imageFile: latestFile,
          title: "Última creación",
        ),
      ),
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
                        onPressed: _openLatestCreation, 
                        icon: const Icon(Icons.history),
                        label: const Text("Última creación"),
                      ),
                      ElevatedButton.icon(
                        onPressed: _goToArt,
                        icon: const Icon(Icons.list),
                        label: const Text("Lista de creaciones"),
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
