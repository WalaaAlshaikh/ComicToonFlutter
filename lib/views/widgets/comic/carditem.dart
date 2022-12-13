import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';
import '../../screens/comic/comic_detail.dart';


class CardItem extends StatelessWidget {
   CardItem({Key? key}) : super(key: key);
final controller =Get.find<ComicController>();
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
          child:controller.searchList.isEmpty && controller.searchController.text.isNotEmpty ?
          Image.asset("assets/images/search_empry_light.png")
              :
          GridView.builder(
            itemCount: controller.searchList.isEmpty? controller.comicList.length : controller.searchList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.9,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                maxCrossAxisExtent: 200
            ),
            itemBuilder: (context,index) {
              if(controller.comicList.isNotEmpty){
                return buildCard(image: controller.comicList[index].image.imageUrl,
                    name:  controller.comicList[index].name,
                    id: controller.comicList[index].description,
                    comicModel: controller.comicList[index],
                    year: controller.comicList[index].year,
                    publisher: controller.comicList[index].publisher.publishName,
                    onTap: (){
                      Get.to(ComicDetails(comicModel:controller.comicList[index] ,));

                    });
              } else{
                return buildCard(image: controller.searchList[index].image.imageUrl,
                    name:  controller.searchList[index].name,
                    id: controller.searchList[index].description,
                    year: controller.searchList[index].year,
                    comicModel: controller.searchList[index],
                    publisher: controller.searchList[index].publisher.publishName,
                    onTap: (){
                      Get.to(ComicDetails(comicModel:controller.searchList[index] ,));

                    });
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
        required String year,
        required String publisher,
        required Comic comicModel ,
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
                  padding:  EdgeInsets.only(left: 5 ,right: 5, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(alignment: Alignment.center,
                        child: Text(" $name",
                          style: TextStyle(
                              color: Get.isDarkMode ?Colors.black :Colors.white,
                              fontWeight: FontWeight.bold,fontSize: 12,
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
