import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavScreen extends StatelessWidget {
  FavScreen({Key? key}) : super(key: key);

  final controller = Get.put(ComicController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Obx((){

          if(controller.favList.isEmpty){
            return
              Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,width: 100,
                      child: Image.asset("assets/images/Mask group.png"),),
                    SizedBox(height: 20),
                    Text("Mark Your favorite comics",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Get.isDarkMode? Colors.white :Colors.grey,
                          fontSize: 18
                      ),),

                  ],
                ) ,);
          }else{
            return
              ListView.separated(
                  itemBuilder: (context,index){
                    return buildFavItem(image: controller.favList[index].image.imageUrl,
                        title: controller.favList[index].name,

                        id: controller.favList[index].id);

                  },
                  separatorBuilder: (context,index){
                    return const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    );

                  },
                  itemCount: controller.favList.length) ;
          }

        })



    );
  }

  Widget buildFavItem({
    required String image,
    required String title,
    required int id,
  }){

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 100,

        child: Row(
          children: [
            SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(image,
                      fit: BoxFit.cover,)),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text(title,
                    style: TextStyle(overflow: TextOverflow.ellipsis,color: Get.isDarkMode ?Colors.white:Colors.black,
                        fontWeight: FontWeight.bold,fontSize: 16 ),),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
            const Spacer(),

            IconButton(onPressed: (){
              controller.manageFav(id);
            },
                icon: Icon(Icons.bookmark,color: Colors.red.shade700, size: 30,))
          ],
        ),
      ),
    );
  }
}