import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:comic_toon_flutter/views/screen.dart';
import 'package:comic_toon_flutter/views/widgets/comic/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration:  BoxDecoration(
                color: Colors.grey ,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
            ),
            child:Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtils(
                      text: "Find Your",
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                      color: Colors.white),
                  const SizedBox(height: 5,),
                  TextUtils(
                      text: "INSPIRATION",
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                      color: Colors.white),
                  const SizedBox(height: 18,),
                  SearchFormText(),
                ],
              ),
            ) ,

          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextUtils(
                  text: "Categories",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Get.isDarkMode? Colors.white :Colors.black),
            ),
          ),
          const SizedBox(height: 20,),
          CardItem(),


        ],

      ),

    ));
  }
}