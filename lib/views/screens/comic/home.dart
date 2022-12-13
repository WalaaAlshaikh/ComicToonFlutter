import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:comic_toon_flutter/views/widgets/comic/carditem.dart';
import 'package:comic_toon_flutter/views/widgets/comic/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
              child: SearchFormText()),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextUtils(
                  text: "Top picks for you",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Get.isDarkMode ? Colors.white : Colors.red.shade700),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CardItem(),
        ],
      ),
    ));
  }
}
