import 'dart:convert';

import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:comic_toon_flutter/models/video_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/my_string.dart';

class ComicServices {
  static Future<List<Comic>> getComic() async {
    var res = await http.get(Uri.parse("$baseUrl/volumes/?api_key=9c6a8bae62f936621bc6e2b0e4302011673b3122&format=json"));
    var comics = <Comic>[];

    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["results"];
      print(res.statusCode);
      print(data[1]["image"]["icon_url"]);
      for (var comicJson in data) {
        comics.add(Comic.fromJson(comicJson));
      }
      //from the model
      return  comics;

    }else{
      return throw Exception("Failed to load data");
    }
  }

  static Future<List<Videos>> getVideo() async {
    var res = await http.get(Uri.parse("$baseUrl/videos/?api_key=9c6a8bae62f936621bc6e2b0e4302011673b3122&format=json"));
    var comics = <Videos>[];

    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["results"];
      print(res.statusCode);
      print(data[1]["image"]["small_url"]);
      for (var videoJson in data) {
        comics.add(Videos.fromJson(videoJson));
      }
      //from the model
      return  comics;

    }else{
      return throw Exception("Failed to load data");
    }
  }
}