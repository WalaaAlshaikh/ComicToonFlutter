import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/logic/controllers/video_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:comic_toon_flutter/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';
import '../../screens/comic/comic_detail.dart';


class VideoItem extends StatelessWidget {
  VideoItem({Key? key}) : super(key: key);
  final controller =Get.find<VideoController>();
  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      if(controller.isLoading.value){
        return const Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        );
      } else{
        return Expanded(
          child:
          GridView.builder(
            itemCount:  controller.videoList.length ,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 1.8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                maxCrossAxisExtent: 400
            ),
            itemBuilder: (context,index) {

                return buildCard(image: controller.videoList[index].image.imageUrl,
                    name:  controller.videoList[index].name,
                    videoModel: controller.videoList[index],
                    youtubeId: controller.videoList[index].youtubeId,
                    onTap: (){
                      // Get.to(()=> ComicDetails(comicModel:controller.comicList[index] ,));

                    });


            },),
        );
      }

    }
    );
  }

  Widget buildCard(
      { required String image,
        required String name,
        required String youtubeId,
        required Videos videoModel ,
        required Function() onTap}
      ){

    return  Padding(padding: EdgeInsets.all(7),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                  )
                ]

            ) ,
            child: Column(
              children: [

                Container(
                  width: double.infinity,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Image.network(image,
                    fit:BoxFit.fill ,) ,

                ),
                Padding(
                  padding:  EdgeInsets.only(left: 5 ,right: 5, top: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(alignment: Alignment.center,
                        child: Text(" $name",
                          style: TextStyle(
                            color: Get.isDarkMode ?Colors.black :Colors.white,
                            fontWeight: FontWeight.bold,fontSize: 13,
                          ),textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),

          ),
        )

    );
  }
}
