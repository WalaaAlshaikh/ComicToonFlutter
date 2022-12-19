import 'package:comic_toon_flutter/models/video_model.dart';
import 'package:get/get.dart';

import '../../service/network/comic_service.dart';

class VideoController extends GetxController {
  var videoList = <Videos>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    getVideos();
    super.onInit();
  }

  void getVideos() async {
    var videos = await ComicServices.getVideo();
    try {
      isLoading(true);
      if (videos.isNotEmpty) {
        videoList.addAll(videos);
      }
//finally means after it finish what should it do
    } finally {
      isLoading(false);
    }
  }
}
