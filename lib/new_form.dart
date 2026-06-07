import 'package:flutter/material.dart';

class NewForm extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewForm> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Form")),
      body: Column(
        children: [
          Text('Counter: \$counter'),
          ElevatedButton(onPressed: increment, child: Text("Tambah")),
        ],
      ),
    );
  }
}
