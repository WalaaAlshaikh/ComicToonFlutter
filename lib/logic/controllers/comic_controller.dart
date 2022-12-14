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
  var favList =<Favourite> [].obs;
  var box = GetStorage();
  final fireRef=FirebaseFirestore.instance.collection("users");

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

  void manageFav(int id) async {
    // navigate the index inside the list where its id equal to the id that i choose
    var indexWanted = favList.indexWhere((element) {
      print("-----------------${element.id}");
      return element.id == id;
    });
    print("------------- $id");
    print(indexWanted);
    print("-------------");

    if (indexWanted >= 0) {
      favList.removeAt(indexWanted);
      await box.remove("isFav");
    } else {
      // adding items from product model (parent list) to favourite list (child) based on the id
      favList.add(favList.firstWhere((element) => element.id == id));

      await box.write("isFav", favList);
    }
  }

  bool isFav(int productId) {
    //navigate in the parent list is the id of its item same as the id that i will give u or not
    return favList.any((element) => element.id == productId);
  }


  Future<void> addComicToFireStore(Comic comic) async {
    // we need Reference to firebase
    final comicRef = fireRef
        .doc(authController.displayUserEmail.value)
        .collection("favourite")
        .doc(comic.id.toString());
    final data = comic.toJson(); // insert to fiserbase
    print("----- ${comicRef.id}");
    print("------------- ${comic.id}");

      comicRef.set(data).whenComplete(() {
        if(comicRef.id==comic.id.toString()){
          Get.snackbar("", "Added successfully..");
          Get.toNamed(Routes.mainScreen);
        } else{
          Get.snackbar("Error", "something went wrong");
        }

      }).catchError((error) {
        Get.snackbar("Error", "something went wrong");
      });

  }

  Future<void> deleteData(int id) async {

    await fireRef
        .doc(authController.displayUserEmail.value)
        .collection("favourite")
        .doc(id.toString())
        .delete();
  }
}
