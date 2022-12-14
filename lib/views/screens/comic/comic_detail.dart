import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

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
        appBar: AppBar(leading: IconButton(onPressed: Get.back,icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),),title: Text(comicModel.name, style: const TextStyle(color: Colors.black),),backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed:() async{
          await controller.addComicToFireStore(comicModel);
        }, icon: controller.isFav(
            comicModel.id)?const Icon(Icons.bookmark_outlined,color: Colors.red,): const Icon(Icons.bookmark_add_outlined,color: Colors.black,))
      ],),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 0.85.h,left: 5.1.w,right: 5.1.w),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Image.network(comicModel.image.imageUrl,width: 83.96.w,),
                   SizedBox(height: 1.17.h),
                  TextUtils(text: comicModel.name, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                   SizedBox(height: 1.52.h),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                    Column(children: [
                      Row( children:  [
                        Icon(Icons.note_alt_outlined,color:Colors.red.shade700),
                        SizedBox(width: 0.35.h,),
                        TextUtils(text: "Publisher", color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 10.sp)
                      ],),
                      const SizedBox(height: 5,),
                      TextUtils(text: comicModel.name, color: Colors.grey.shade700, fontWeight: FontWeight.w700, fontSize: 10.sp),

                      // SizedBox(width:43,child: Text(comicModel.publisher.publishName,style: TextStyle(overflow:TextOverflow.visible,color: Colors.grey.shade700,fontSize: 12,fontWeight: FontWeight.w700),))

                    ],),
                    const VerticalDivider(thickness: 2,color: Colors.black,),
                    Column(children: [
                      Row( children:  [
                        Icon(Icons.calendar_today,color: Colors.red.shade700,),
                        SizedBox(width: 0.35.h,),
                        TextUtils(text: "Issue Year", color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 10.sp)
                      ],),
                       SizedBox(height: 0.35.h,),
                      TextUtils(text: comicModel.year, color: Colors.grey.shade700, fontWeight: FontWeight.w700, fontSize: 10.sp)
                    ],),

                  ],),
                   SizedBox(height: 1.17.h),
                  // Html(data:comicModel.description),

                  //because the text in the api is written in HTML it displayed like that
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
                      fontSize: 10.sp,
                      height: 0.2.h,
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