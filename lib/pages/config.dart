import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/configurationData.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> sizes = [16, 18, 20, 22, 24];
    final Map<String, Color> colorOptions = {
      'Rojo': Colors.red,
      'Verde': Colors.green,
      'Azul': Colors.blue,
      'Rosa': Colors.pinkAccent,
      'Amarillo': Colors.yellow,
    };

    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tamaño del Pixel Art:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: appData.size, 
              items: sizes
                  .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text(size.toString()),
                      ))
                  .toList(),
              onChanged: (value) async{
                if (value != null) {
                  await context.read<AppData>().setSize(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('el Tamaño se ha guardado correctamente')),
                  );
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Paleta de colores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Color>(
            value: colorOptions.values.contains(appData.selectedColor)
                ? appData.selectedColor
                : colorOptions.values.first, 
            items: colorOptions.entries
                .map((entry) => DropdownMenuItem(
                      value: entry.value,
                      child: Text(entry.key),
                    ))
                .toList(),
            onChanged: (color) async {
              if (color != null) {
                await context.read<AppData>().setColor(color);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('el Color se ha guardado correctamente')),
                );
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
