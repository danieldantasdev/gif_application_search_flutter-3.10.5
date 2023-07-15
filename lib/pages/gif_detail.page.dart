import 'package:flutter/material.dart';
import 'package:gif/models/gif.model.dart';

class GifDetailPage extends StatelessWidget {
  const GifDetailPage({super.key, required this.gif});

  final Data gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gif.title as String,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gif.images!.fixedHeight!.url as String),
      ),
    );
  }
}
