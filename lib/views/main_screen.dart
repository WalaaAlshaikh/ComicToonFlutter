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
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.teal,
            //backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
            // here the title will change based on the taps on the nav bar and it change by the current index that we define in controller
            title: Text(controller.title[controller.currentIndex.value]),
            centerTitle: true,
          ),
          // we disable this because we need to change the mode based on the click on the icon
          // backgroundColor: Get.isDarkMode? Colors.white :darkGreyClr,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 3,
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex.value,
            items: [
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.home,
                      color:  Colors.black),
                  icon: Icon(
                    Icons.home,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.category,
                      color:  Colors.black),
                  icon: Icon(Icons.category,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: ""),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.shopping_cart,
                      color:  Colors.black),
                  icon: Icon(Icons.shopping_cart,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: ""),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.person,
                      color:  Colors.black),
                  icon: Icon(Icons.person,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  label: ""),
            ],
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              // adding this line because when he click on the items the index also change based on the click
              controller.currentIndex.value = index;
            },
          ),
          // here in the body we need to add the taps but before we need something called
          //(index stack) in state managemnet there are some states can't change like in fav if we ant to change it it can't change

          body: IndexedStack(
            index: controller.currentIndex.value,
            children: controller.taps as List<Widget>,
          ),
        )));
  }
}
