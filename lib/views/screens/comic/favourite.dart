import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_toon_flutter/logic/controllers/auth_controllers.dart';
import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FavScreen extends StatelessWidget {
  FavScreen({Key? key}) : super(key: key);

  final controller = Get.put(ComicController());
  final authController = Get.find<AuthController>();
  final TextEditingController reviewController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value)
          .collection("favourite")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          controller.favList.value = snapshot.data!.docs
              .map((e) => Favourite(
                  name: e["name"],
                  description: e["description"],
                  image: e['imageUrl'] ,
                  id: e["id"],
                  year: e["year"],
                  publisher: e["publisher"]))
              .toList();

          if(controller.favList.isNotEmpty){
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return buildFavItem(
                    image: snapshot.data?.docs[index]['imageUrl'] ?? "",
                    title: snapshot.data?.docs[index]['name'] ?? "",
                    id: snapshot.data?.docs[index]['id'] ?? "",
                issue: snapshot.data?.docs[index]['last_issue']?? "",
                review: snapshot.data?.docs[index]['review']?? "",

                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                  thickness: 1,
                );
              },
            );
          }else{
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 11.7.h,width: 25.44.w,
                    child: Image.asset("assets/images/Mask group.png"),),
                   SizedBox(height: 2.34.h),
                  Text("Please,Add your favourite products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode? Colors.white :Colors.black54,
                        fontSize: 15.sp
                    ),),

                ],
              ) ,);
          }

        } else if (snapshot.hasError) {
          const Text('No data available right now');
        }
        return Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 11.7.h,width: 25.44.w,
                child: Image.asset("assets/images/Mask group.png"),),
               SizedBox(height: 2.34.h),
              Text("Mark your favourite comics",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode? Colors.white :Colors.black54,
                    fontSize: 14.sp
                ),),

            ],
          ) ,);
      },
    ));
  }

  Widget buildFavItem({
    required String image,
    required String title,
    required int id,
    required String issue,
    required String review,
  }) {
    return Padding(
      padding:  EdgeInsets.all(1.17.h),
      child: SizedBox(
        width: double.infinity,
        height: 11.9.h,
        child: Row(
          children: [
            SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
             SizedBox(
              width: 3.82.w
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5.sp),
                  ),
                  SizedBox(height: 0.9.h,),
                  Text(
                    "$issue issues",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.5.sp),
                  ),
                   SizedBox(
                    height: 1.17.h,
                  ),
              GetBuilder<ComicController>(
                builder: (_) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          title: '',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller:reviewController,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: review.isNotEmpty? review : "Enter your review",
                                    hintMaxLines: 1,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green, width: 4.0))),
                              ),
                               SizedBox(
                                height:  3.52.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (reviewController
                                    .text.isNotEmpty) {
                                 controller.updateData(id, reviewController);
                                 clearText();
                                    Get.back();
                                  } else {
                                    Get.snackbar("","Enter your review");
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                child: Text(
                                  'ADD REVIEW',
                                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                ),

                              )
                            ],
                          ),
                          radius: 10.0);

                    },
                    splashColor: Colors.black,
                    borderRadius: BorderRadius.circular(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add review",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade700),
                        ),

                      ],
                    ),
                  ),
                ),
              )
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  controller.deleteData(id);
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red.shade700,
                  size: 3.52.h,
                ))
          ],
        ),
      ),
    );
  }

  void clearText() {
    reviewController.clear();
  }
}
