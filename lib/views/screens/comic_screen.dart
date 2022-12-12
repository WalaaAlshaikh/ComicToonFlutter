// import 'dart:convert';
//
// import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../models/comic_model.dart';
//
//
// class ComicScreen extends StatefulWidget {
//    ComicScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ComicScreen> createState() => _ComicScreenState();
// }
//
// class _ComicScreenState extends State<ComicScreen> {
//
//   List<Comic> _comics = <Comic>[];
//
//   Future<List<Comic>> fetchComic() async {
//     var url =
//         "http://comicvine.gamespot.com/api/volumes/?api_key=9c6a8bae62f936621bc6e2b0e4302011673b3122&format=json";
//     var response = await http.get(Uri.parse(url));
//     var comics = <Comic>[];
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> map = json.decode(response.body);
//       List<dynamic> data = map["results"];
//       print(data[1]["image"]["icon_url"]);
//
//       for (var comicJson in data) {
//         comics.add(Comic.fromJson(comicJson));
//       }
//     }
//     return comics;
//   }
//
//   @override
//   void initState() {
//     fetchComic().then((value) {
//       setState(() {
//         _comics.addAll(value);
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//         appBar: AppBar(
//           title: Text("Comic List View"),
//         ),
//         body: ListView.builder(
//           itemBuilder: (context, index) {
//             return Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: <Widget>[
//                     Image.network(_comics[index].image.imageUrl),
//
//                     Text(_comics[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),),
//                     Text(_comics[index].description)
//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: _comics.length,
//         ));
//   }
//
//
// }
