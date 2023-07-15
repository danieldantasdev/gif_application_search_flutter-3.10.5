import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../utils/utils.dart';

class GifService {
  final HttpUtil _httpUtil = HttpUtil();

  Future<Gif> getSearch(String? search, int? offset) async {
    http.Response response;

    if (search == null) {
      response = await http.get(
        Uri.parse(
            "${_httpUtil.baseUrl}/trending?api_key=WV3kFtmsxHMzKBKkbxziAH4TpWoWOkN2&limit=25&offset=0&rating=g&bundle=messaging_non_clips"),
      );
    } else {
      response = await http.get(
        Uri.parse(
            "${_httpUtil.baseUrl}/search?api_key=WV3kFtmsxHMzKBKkbxziAH4TpWoWOkN2&q=$search&limit=25&offset=$offset&rating=g&lang=en&bundle=messaging_non_clips"),
      );
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Gif gif = Gif.fromJson(data);
      return gif;
    } else {
      throw Exception('Failed to fetch coin data');
    }
  }
}
