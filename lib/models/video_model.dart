class Videos {
  late String name;
  late int id;
  late String youtubeId;
  late Picture image;
  late String url;

  Videos({
    required this.name,
    required this.youtubeId,
    required this.image,
    required this.id,
    required this.url,
  });

  Videos.fromJson(Map<String, dynamic> map) {
    image = Picture.fromJson(map["image"]);
    name = map["name"] ?? '';
    youtubeId = map["youtube_id"] ?? '';
    id = map["id"] ?? '';
    url = map["low_url"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": youtubeId,
        "imageUrl": image.imageUrl,
        "low_url": url,
      };
}

class Picture {
  late String imageUrl;

  Picture(this.imageUrl);
  Picture.fromJson(Map<String, dynamic> map) {
    imageUrl = map["small_url"] as String;
  }
}
