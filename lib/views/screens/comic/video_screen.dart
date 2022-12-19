import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/text_utils.dart';
import '../../widgets/comic/carditem.dart';
import '../../widgets/comic/video_item.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
               SizedBox(
                height:2.81.h
              ),
              Padding(
                padding:  EdgeInsets.only(left:5.08.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextUtils(
                      text: "Explore the world of comic videos",
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.red.shade700),
                ),
              ),
               SizedBox(
                height: 1.17.h,
              ),
              VideoItem(),
            ],
          ),
        ));
  }
}
