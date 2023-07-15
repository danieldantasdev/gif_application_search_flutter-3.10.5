import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gif/models/gif.model.dart';

class GifDetailPage extends StatelessWidget {
  const GifDetailPage({super.key, required this.gif});

  final Data gif;

  Future<void> _onPressed() async {
    await FlutterShare.share(
      title: 'gif',
      linkUrl: gif.images!.fixedHeight!.url as String,
      chooserTitle: 'gif',
    );

    // await FlutterShare.shareFile(
    //   title: 'Example share',
    //   text: 'Example share text',
    //   filePath: gif.images!.fixedHeight!.url as String,
    // );
  }

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
        actions: [
          IconButton(
            onPressed: _onPressed,
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ],
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
