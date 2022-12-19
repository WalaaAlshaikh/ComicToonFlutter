import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:comic_toon_flutter/views/widgets/comic/carditem.dart';
import 'package:comic_toon_flutter/views/widgets/comic/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
              padding:  EdgeInsets.only(top: 1.85.h,left: 5.1.w,right: 5.1.w),
              child: SearchFormText()),
           SizedBox(
            height:2.81.h
          ),
          Padding(
            padding:  EdgeInsets.only(left: 5.08.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextUtils(
                  text: "Top picks for you",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Get.isDarkMode ? Colors.white : Colors.red.shade700),
            ),
          ),
           SizedBox(
            height: 1.17.h,
          ),
          CardItem(),
        ],
      ),
    ));
  }
}
