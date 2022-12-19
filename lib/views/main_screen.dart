import 'package:comic_toon_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = Get.put(MainController());

  // final cartcontroller = Get.find<CartController>();

  //we need stream (obx) because in this page it retrieve data from api and transferring the data between each page

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
          // this will enable the theme in backgroundColor // it will not change until we go to main.dart
          backgroundColor:Colors.white,
          appBar: AppBar(

            elevation: 0,
            backgroundColor: Colors.transparent,
            //backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
            // here the title will change based on the taps on the nav bar and it change by the current index that we define in controller
            title: Text(controller.title[controller.currentIndex.value],style: TextStyle(color: Colors.black),),
            centerTitle: true,

          ),
          // we disable this because we need to change the mode based on the click on the icon
          // backgroundColor: Get.isDarkMode? Colors.white :darkGreyClr,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 3,
            backgroundColor: Colors.grey.shade300,
            currentIndex: controller.currentIndex.value,
            selectedLabelStyle: TextStyle(color: Colors.red),
            unselectedLabelStyle:TextStyle(color: Colors.black),
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            items: [
              BottomNavigationBarItem(
                  activeIcon: Image.asset("assets/images/comic 1.png",color: Colors.red,),
                  icon: Image.asset("assets/images/comic 1.png",color: Colors.black,),
                  label: "comics",),

              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.video_call_outlined,
                      color:  Colors.red),
                  icon: Icon(Icons.video_call_outlined,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: "videos",),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.bookmark_outlined,
                      color:  Colors.red),
                  icon: Icon(Icons.bookmark_outlined,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: "saved"),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.person_outline,
                      color:  Colors.red),
                  icon: Icon(Icons.person_outline,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: "profile"),
            ],
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              // adding this line because when he click on the items the index also change based on the click
              controller.currentIndex.value = index;
            },
          ),
          // here in the body we need to add the taps but before we need something called
          //(index stack) in state management there are some states can't change like in fav if we ant to change it it can't change

          body:
          IndexedStack(
            index: controller.currentIndex.value,
            children: controller.taps,
          ),
        )));
  }
}
