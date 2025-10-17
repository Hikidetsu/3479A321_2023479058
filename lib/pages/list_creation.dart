import 'package:flutter/material.dart';
import 'dart:io';
import 'list_art.dart';
import 'package:share_plus/share_plus.dart';

class ListCreation extends StatefulWidget {
  const ListCreation({super.key});

  @override
  State<ListCreation> createState() => _ListCreationScreenState();
}

class _ListCreationScreenState extends State<ListCreation> {
  late Future<ListArt> _artProviderFuture;

  @override
  void initState() {
    super.initState();
    _artProviderFuture = _loadArtData();
  }

  Future<ListArt> _loadArtData() async {
    final provider = ListArt();
    await provider.loadCreations();
    return provider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Creaciones'),
      ),
      body: FutureBuilder<ListArt>(
        future: _artProviderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las imagenes.'));
          }
          if (!snapshot.hasData || snapshot.data!.imagenes.isEmpty) {
            return const Center(child: Text('No hay ninguna imagen guardada.'));
          }

          final artProvider = snapshot.data!;
          return ListView.builder(
            itemCount: artProvider.imagenes.length,
            itemBuilder: (context, index) {
              final title = artProvider.elementos[index];
              final imageFile = artProvider.imagenes[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.file(
                    imageFile,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(title),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailScreen(
                          imageFile: imageFile,
                          title: title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class ImageDetailScreen extends StatelessWidget {
  final File imageFile;
  final String title;

  const ImageDetailScreen({
    super.key,
    required this.imageFile,
    required this.title,
  });

  Future<void> _shareImage() async {
    try {
      final xFile = XFile(imageFile.path);
      await Share.shareXFiles(
        [xFile],
        text: 'Mira mi nueva creacion de pixel art :D',
      );
    } catch (e) {
      print('Error al compartir la imagen: $e');
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir imagen',
            onPressed: _shareImage,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.file(
            imageFile,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

