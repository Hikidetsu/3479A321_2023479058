import 'package:flutter/material.dart';
import 'package:lab2/pages/config.dart';
import 'package:lab2/providers/configurationData.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key, required this.title});

  final String title;

  @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  late int _sizeGrid;
  var logger = Logger();




  void _onStateChanged() {
    logger.d(" Función extra llamada desde setState");
  }


  void initState() {
    super.initState();
      _sizeGrid = context.read<AppData>().size;
    logger.d("valor inicial del size es_ $_sizeGrid");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("dependencias");
  }

  @override
  void setState(VoidCallback fn) {
    logger.d("cambio de estado");
    _onStateChanged(); 
    super.setState(fn);
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("actualiza widget");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d("widget desactivado");
  }

  @override
  void dispose() {
    logger.d("widget eliminado de forma permanente");
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d("rearmandose (modo debug hot reload)");
  }

@override
Widget build(BuildContext context) {

  final currentSize = context.watch<AppData>().size;

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Config(),
              ),
            );
          },
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '--',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              child: Center(
                child: Text(
                  'Tamaño de grid actual: $currentSize',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}