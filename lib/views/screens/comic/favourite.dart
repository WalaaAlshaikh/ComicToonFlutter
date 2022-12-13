import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_toon_flutter/logic/controllers/auth_controllers.dart';
import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
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
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return buildFavItem(
                  image: snapshot.data?.docs[index]['imageUrl'] ?? "",
                  title: snapshot.data?.docs[index]['name'] ?? "",
                  id: snapshot.data?.docs[index]['id'] ?? "");
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
          );
        } else if (snapshot.hasError) {
          const Text('No data available right now');
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }

  Widget buildFavItem({
    required String image,
    required String title,
    required int id,
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
                  Icons.bookmark,
                  color: Colors.red.shade700,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
