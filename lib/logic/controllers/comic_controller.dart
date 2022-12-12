import 'dart:convert';

import 'package:comic_toon_flutter/service/network/comic_service.dart';
import 'package:get/get.dart';

import '../../models/comic_model.dart';
import 'package:http/http.dart' as http;
class ComicController extends GetxController{


  var isLoading=true.obs;

  @override
  void onInit() async {
    getComics();

    super.onInit();
  }


  var comicList= <Comic> [].obs;

  // Future<List<Comic>> fetchComic() async {
  //   var url =
  //       "http://comicvine.gamespot.com/api/volumes/?api_key=9c6a8bae62f936621bc6e2b0e4302011673b3122&format=json";
  //   var response = await http.get(Uri.parse(url));
  //   var comics = <Comic>[];
  //
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> map = json.decode(response.body);
  //     List<dynamic> data = map["results"];
  //     print(data[1]["image"]["icon_url"]);
  //
  //     for (var comicJson in data) {
  //       comics.add(Comic.fromJson(comicJson));
  //     }
  //   }
  //   return comics;
  // }

  void getComics() async{

    var comics= await ComicServices.getProduct();
    try{
      isLoading(true);
      if(comics.isNotEmpty){
        comicList.addAll(comics);
      }
//finally means after it finish what should it do
    }
    finally{
      isLoading(false);
    }
  }



}



