import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextUtils(
                      text: "Explore the world of comic videos",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.white : Colors.red.shade700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              VideoItem(),
            ],
          ),
        ));
  }
}
