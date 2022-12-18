import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_toon_flutter/logic/controllers/auth_controllers.dart';
import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:comic_toon_flutter/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavScreen extends StatelessWidget {
  FavScreen({Key? key}) : super(key: key);

  final controller = Get.put(ComicController());
  final authController = Get.find<AuthController>();

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
                issue: snapshot.data?.docs[index]['last_issue']?? "");
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
                  SizedBox(height: 100,width: 100,
                    child: Image.asset("assets/images/Mask group.png"),),
                  const SizedBox(height: 20),
                  Text("Please,Add your favourite products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode? Colors.white :Colors.black54,
                        fontSize: 18
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
              SizedBox(height: 100,width: 100,
                child: Image.asset("assets/images/Mask group.png"),),
              const SizedBox(height: 20),
              Text("Mark your favourite comics",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode? Colors.white :Colors.black54,
                    fontSize: 18
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
    required String issue
  }) {
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
                    borderRadius: BorderRadius.circular(10)),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            const SizedBox(
              width: 15,
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
                        fontSize: 16),
                  ),
                  SizedBox(height: 7,),
                  Text(
                    "$issue issues",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
