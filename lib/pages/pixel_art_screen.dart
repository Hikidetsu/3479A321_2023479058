import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:lab2/pages/config.dart'; 
import 'package:lab2/providers/configurationData.dart'; 
import 'dart:ui' as ui;
import 'dart:io';


class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key, required this.title});
  final String title;


  @override
  _PixelArtScreenState createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  bool _showNumber = true;
  Logger logger = Logger();
  late int _sizeGrid;
  Color _selectedColor = Colors.black;

  final List<Color> _listColors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.pink,
  ];

  late List<Color> _cellColors;

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<AppData>().size;

    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent, 
    );
    logger.d("PixelArtScreen initialized. Grid size set to: $_sizeGrid");
  }

Future<void> _savePixelArt() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, _sizeGrid * 20.0, _sizeGrid * 20.0));
  for (int row = 0; row < _sizeGrid; row++) {
    for (int col = 0; col < _sizeGrid; col++) {
      final color = _cellColors[row * _sizeGrid + col];
      final paint = Paint()..color = color;
      final rect = Rect.fromLTWH(col * 20.0, row * 20.0, 20.0, 20.0);
      canvas.drawRect(rect, paint);
    }
  }

  final picture = recorder.endRecording();
  final image = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);

  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final imageBytes = byteData!.buffer.asUint8List();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/pixel_art_${DateTime.now().millisecondsSinceEpoch}.png';

  final file = File(filePath);
  await file.writeAsBytes(imageBytes);

  logger.d("pixel art saved to: $filePath");
  

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('pixel art saved to: $filePath')),
  );
}








@override
Widget build(BuildContext context) {
  final provider = context.watch<AppData>();
  _sizeGrid = provider.size;

  if (_cellColors.length != _sizeGrid * _sizeGrid) {
    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent,
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Config()),
            );
          },
        ),
        IconButton(
          icon: Icon(_showNumber ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _showNumber = !_showNumber;
            });
          },
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('$_sizeGrid x $_sizeGrid'),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter title',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        logger.d('Title entered: $value');
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _savePixelArt();
                    logger.d('Button pressed');
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _sizeGrid,
              ),
              itemCount: _sizeGrid * _sizeGrid,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _cellColors[index] = _selectedColor;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    color: _cellColors[index],
                    child: Center(
                      child: _showNumber
                          ? Text(
                              '$index',
                              style: TextStyle(
                                fontSize: 8,
                                color: _cellColors[index] == Colors.black
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey[200],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _listColors.map((color) {
                  final bool isSelected = color == _selectedColor;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.all(isSelected ? 12 : 8),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      width: isSelected ? 40 : 30,
                      height: isSelected ? 40 : 30,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}