import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';

import '../../../routes.dart';

class ComicDetails extends StatelessWidget {
  final Comic comicModel;
   ComicDetails({required this.comicModel, Key? key})
      : super(key: key);
   final controller =Get.find<ComicController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: Get.back,icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),title: Text(comicModel.name, style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed:() async{
          await controller.addComicToFireStore(comicModel);

        }, icon: controller.isFav(
            comicModel.id)?Icon(Icons.bookmark_outlined,color: Colors.red,): Icon(Icons.bookmark_add_outlined,color: Colors.black,))
      ],),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 20,right: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Image.network(comicModel.image.imageUrl,width: 330,),
                  const SizedBox(height: 10),
                  TextUtils(text: comicModel.name, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                    Column(children: [
                      Row( children: const [
                        Icon(Icons.note_alt_outlined),
                        SizedBox(width: 3,),
                        TextUtils(text: "Publisher", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)
                      ],),
                      const SizedBox(height: 5,),
                      TextUtils(text: comicModel.publisher.publishName, color: Colors.grey.shade700, fontWeight: FontWeight.w700, fontSize: 14)
                    ],),
                    const VerticalDivider(thickness: 2,color: Colors.black,),
                    Column(children: [
                      Row( children: const [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 3,),
                        TextUtils(text: "Issue Year", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)
                      ],),
                      const SizedBox(height: 5,),
                      TextUtils(text: comicModel.year, color: Colors.grey.shade700, fontWeight: FontWeight.w700, fontSize: 14)
                    ],)

                  ],),
                  const SizedBox(height: 10),
                  Html(data:comicModel.description),
                  ReadMoreText(
                    comicModel.description,
                    trimLines: 3,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Read More ",
                    trimExpandedText: " Read Less ",
                    lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.red.shade700 : Colors.red.shade700,
                    ),
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.red.shade700 : Colors.red.shade700,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      height: 2,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}