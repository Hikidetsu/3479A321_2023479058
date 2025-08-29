import 'package:flutter/material.dart';


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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel Art sobre una grilla personalizable'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset('assets/Pixel-Art-Hot-Pepper-2-1.webp', width: 400, height: 400, fit:BoxFit.cover),
                  Image.asset('assets/Pixel-Art-Pizza-2.webp', width: 400, height: 400, fit:BoxFit.cover),
                  Image.asset('assets/Pixel-Art-Watermelon-3.webp',width: 400, height: 400, fit:BoxFit.cover),
                ],  
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.art_track),
      ),
      persistentFooterButtons: _buildFooterButtons(),
    );
  }
}

