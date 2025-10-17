
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListArt {
  List<String> elementos = [];
  List<File> imagenes = [];

  Future<void> loadCreations() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final items = directory.listSync();

      final pixelArtFiles = items
          .where((item) => item.path.endsWith('.png') && item.path.contains('pixel_art_'))
          .map((item) => File(item.path))
          .toList();

      elementos.clear();
      imagenes.clear();

      for (var file in pixelArtFiles) {
        elementos.add(file.path.split('/').last);
        imagenes.add(file);
      }
    } catch (e) {
      print("Error al cargar las creaciones: $e");
    }
  }
}