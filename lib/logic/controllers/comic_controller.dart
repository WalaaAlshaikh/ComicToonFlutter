
import 'package:comic_toon_flutter/service/network/comic_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/comic_model.dart';

class ComicController extends GetxController{

  var comicList= <Comic> [].obs;
  var isLoading=true.obs;

  var searchList= <Comic>[].obs;

  TextEditingController searchController=TextEditingController();
  @override
  void onInit() async {
    getComics();

    super.onInit();
  }

  void getComics() async{

    var comics= await ComicServices.getProduct();
    try{
      isLoading(true);
      if(comics.isNotEmpty){
        comicList.addAll(comics);
      }
//finally means after it finish what should it do
    }
    finally{
      isLoading(false);
    }
  }

  void addSearchToList(String searchName){
    searchName=searchName.toLowerCase();
    searchList.value=comicList.where((search) {
      var searchTitle=search.name.toLowerCase();
      return searchTitle.contains(searchName) ;
    }).toList();

    update();
  }

  void clearSearch(){
    searchController.clear();
    addSearchToList("");
  }



}



