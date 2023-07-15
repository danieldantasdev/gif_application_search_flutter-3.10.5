import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gif/models/gif.model.dart';
import 'package:gif/pages/gif_detail.page.dart';
import 'package:transparent_image/transparent_image.dart';

import '../services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GifService _gifService = GifService();

  String _search = "";
  int _limit = 50;
  int _offset = 25;

  Widget _isLoading() {
    return Container(
      width: 200.0,
      height: 200.0,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 5.0,
      ),
    );
  }

  Future<void> _onLongPressed(AsyncSnapshot asyncSnapshot, int index) async {
    await FlutterShare.share(
      title: 'gif',
      linkUrl: asyncSnapshot.data.data[index].images.fixedHeight.url as String,
      chooserTitle: 'gif',
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _gifService.getSearch(_search, _offset, _limit);
    });
  }

  Widget _onCreatedGifTable(
      BuildContext buildContext, AsyncSnapshot asyncSnapshot) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.00),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        // itemCount: asyncSnapshot.data.data.length,
        itemCount: _getCount(asyncSnapshot.data),
        itemBuilder: (context, index) {
          if (_search!.isEmpty || index < asyncSnapshot.data.data.length) {
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: asyncSnapshot.data.data[index].images.fixedHeight.url,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GifDetailPage(gif: asyncSnapshot.data.data[index]),
                  ),
                );
              },
              onLongPress: () {
                _onLongPressed(asyncSnapshot, index);
              },
            );
          } else {
            return Container(
                child: GestureDetector(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    "Carregar mais...",
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ],
              ),
              onTap: () {
                setState(
                  () {
                    _offset != null ? _offset = (_offset! + 19)! : 0;
                    // _limit = asyncSnapshot.data.data.length;
                  },
                );
              },
            ));
          }
        },
      ),
    );
  }

  int? _getCount(Gif gif) {
    if (_search!.isEmpty) {
      return gif.data?.length;
    } else {
      return (gif.data!.length + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Pesquise aqui:",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _gifService.getSearch(_search, _offset, _limit),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      {
                        return _isLoading();
                      }
                    case ConnectionState.waiting:
                      {
                        return _isLoading();
                      }
                    case ConnectionState.active:
                      {
                        return _isLoading();
                      }
                    case ConnectionState.done:
                      {
                        return _onCreatedGifTable(context, snapshot);
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
