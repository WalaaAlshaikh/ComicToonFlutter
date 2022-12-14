import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_toon_flutter/logic/controllers/auth_controllers.dart';
import 'package:comic_toon_flutter/service/network/comic_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/comic_model.dart';
import '../../routes.dart';

class ComicController extends GetxController {
  final authController = Get.find<AuthController>();
  var comicList = <Comic>[].obs;
  var isLoading = true.obs;
  var searchList = <Comic>[].obs;
  var favList = <Favourite>[].obs;
  var box = GetStorage();
  final fireRef = FirebaseFirestore.instance.collection("users");

  TextEditingController searchController = TextEditingController();
  @override
  void onInit() async {
    getComics();

    super.onInit();
  }

  void getComics() async {
    var comics = await ComicServices.getComic();
    try {
      isLoading(true);
      if (comics.isNotEmpty) {
        comicList.addAll(comics);
      }
//finally means after it finish what should it do
    } finally {
      isLoading(false);
    }
  }

  void addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();
    searchList.value = comicList.where((search) {
      var searchTitle = search.name.toLowerCase();
      return searchTitle.contains(searchName);
    }).toList();

    update();
  }

  void clearSearch() {
    searchController.clear();
    addSearchToList("");
  }


  bool isFav(int productId) {
    //navigate in the parent list is the id of its item same as the id that i will give u or not
    return favList.any((element) => element.id == productId);
  }

  Future<void> addComicToFireStore(Comic comic) async {
    var indexWanted = favList.indexWhere((element) {
      print("-----------------${element.id}");
      return element.id == comic.id;
    });
    print("------------- ${comic.id}");
    print(indexWanted);
    print("-------------");

    if (indexWanted >= 0) {
      await fireRef
          .doc(authController.displayUserEmail.value)
          .collection("favourite")
          .doc(comic.id.toString())
          .delete();
      Get.snackbar("", "deleted successfully..");
      Get.toNamed(Routes.mainScreen);
    } else {
      final comicRef = fireRef
          .doc(authController.displayUserEmail.value)
          .collection("favourite")
          .doc(comic.id.toString());
      final data = comic.toJson(); // insert to fiserbase
      print("----- ${comicRef.id}");
      print("------------- ${comic.id}");

      comicRef.set(data).whenComplete(() {
        if (comicRef.id == comic.id.toString()) {
          Get.snackbar("", "Added successfully..");
          Get.toNamed(Routes.mainScreen);
        } else {
          Get.snackbar("Error", "something went wrong");
        }
      }).catchError((error) {
        Get.snackbar("Error", "something went wrong");
      });
    }
    // we need Reference to firebase
  }

  Future<void> deleteData(int id) async {
    await fireRef
        .doc(authController.displayUserEmail.value)
        .collection("favourite")
        .doc(id.toString())
        .delete();
  }

  Future<void> updateData(int id, TextEditingController value) async {
    try {
      await fireRef
          .doc(authController.displayUserEmail.value)
          .collection("favourite")
          .doc(id.toString())
          .update({"review": value.text});
      Get.snackbar(
        'Success!',
        "Updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
      );

      update();
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }
}
