import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';


class Screen extends StatelessWidget {
   Screen({Key? key}) : super(key: key);
final controller =Get.put(ComicController());
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
            itemCount: controller.comicList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.8,
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 6,
                maxCrossAxisExtent: 200
            ),
            itemBuilder: (context,index) {
              if(controller.comicList.isNotEmpty){
                return buildCard(image: controller.comicList[index].image.imageUrl,
                    name:  controller.comicList[index].name,
                    id: controller.comicList[index].description,
                    comicModel: controller.comicList[index],
                    onTap: (){

                    });
              } else{
                return Container();
              }

            },),
        );
      }

    }
    );
  }

  Widget buildCard(
      { required String image,
        required String name,
        required String id,
        required Comic comicModel ,
        required Function() onTap}
      ){

    return  Padding(padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
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
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Image.network(image,
                    fit:BoxFit.cover ,) ,

                ),
                Padding(
                  padding:  EdgeInsets.only(left: 15.0 ,right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(" $name",
                        style: TextStyle(
                            color: Get.isDarkMode ?Colors.black :Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      Container(
                        height:20 ,
                        width: 45,
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(padding: EdgeInsets.only(left: 3,right: 2),
                          child:Row(
                            children: [
                              // CustomText(
                              //     text: "$na",
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 13,
                              //     color: Colors.white),
                              // Icon(Icons.star,size: 13,color: Colors.white,)

                            ],
                          ) ,),
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
