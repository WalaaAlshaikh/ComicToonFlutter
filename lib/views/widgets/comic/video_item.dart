import 'dart:async';

import 'package:comic_toon_flutter/logic/controllers/video_controller.dart';

import 'package:comic_toon_flutter/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/theme.dart';

class VideoItem extends StatelessWidget {
  VideoItem({Key? key}) : super(key: key);
  final controller = Get.find<VideoController>();

  Future<void> launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        );
      } else {
        return Expanded(
          child: GridView.builder(
            itemCount: controller.videoList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.45.w,
                mainAxisSpacing: 1.17.h,
                crossAxisSpacing: 0.2.h,
                maxCrossAxisExtent: 100.h),
            itemBuilder: (context, index) {
              return buildCard(
                  image: controller.videoList[index].image.imageUrl,
                  name: controller.videoList[index].name,
                  videoModel: controller.videoList[index],
                  onTap: () {
                    if (controller.videoList[index].youtubeId != null) {
                      final Uri url = Uri.parse(
                          "http://www.youtube.com/watch?v=${controller.videoList[index].youtubeId}");
                      launchURL(url);
                    } else {
                      return;
                    }
                  });
            },
          ),
        );
      }
    });
  }

  Widget buildCard(
      {required String image,
      required String name,
      required Videos videoModel,
      required Function() onTap}) {
    return Padding(
        padding: const EdgeInsets.all(7),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          " $name",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
