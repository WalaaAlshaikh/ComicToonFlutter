import 'dart:convert';


class Comic {
  late String name;
  late int id;
  late String year;
  late String description;
  late Pic image;
  late Publisher publisher;

  Comic(
      {
    required this.name,
    required this.description,
    required this.image,
    required this.id,
    required this.year,
    required this.publisher,
  });

  Comic.fromJson(Map<String, dynamic> map) {
    image = Pic.fromJson(map["image"]);
    publisher = Publisher.fromJson(map["publisher"]);
    name = map["name"] ?? '';
    description = map["description"] ?? '';
    id = map["id"] ?? '';
    year = map["start_year"] ?? '';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "year": year,
    "imageUrl": image.imageUrl,
    "publisher": publisher.publishName,

  };
}

class Pic {
  late String imageUrl;

  Pic(this.imageUrl);
  Pic.fromJson(Map<String, dynamic> map) {
    imageUrl = map["small_url"] as String;
  }
}

class Publisher {
  late String publishName;

  Publisher(this.publishName);
  Publisher.fromJson(Map<String, dynamic> map) {
    publishName = map["name"] as String;
  }
}


// To parse this JSON data, do
//
//     final comicModel = comicModelFromJson(jsonString);



// List<ComicModel> comicModelFromJson(String str) => List<ComicModel>.from(json.decode(str).map((x) => ComicModel.fromJson(x)));
//
// String comicModelToJson(List<ComicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ComicModel {
//   ComicModel({
//     this.aliases,
//     required this.apiDetailUrl,
//     required this.countOfIssues,
//     required this.dateAdded,
//     required this.dateLastUpdated,
//     this.deck,
//     required this.description,
//     required this.firstIssue,
//     required this.id,
//     required this.image,
//     required  this.lastIssue,
//     required this.name,
//     required  this.publisher,
//     required this.siteDetailUrl,
//     required  this.startYear,
//   });
//
//   dynamic aliases;
//   String apiDetailUrl;
//   int countOfIssues;
//   DateTime dateAdded;
//   DateTime dateLastUpdated;
//   dynamic deck;
//   String description;
//   FirstIssue firstIssue;
//   int id;
//   Images image;
//   FirstIssue lastIssue;
//   String name;
//   FirstIssue publisher;
//   String siteDetailUrl;
//   String startYear;
//
//   factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
//     aliases: json["aliases"],
//     apiDetailUrl: json["api_detail_url"],
//     countOfIssues: json["count_of_issues"],
//     dateAdded: DateTime.parse(json["date_added"]),
//     dateLastUpdated: DateTime.parse(json["date_last_updated"]),
//     deck: json["deck"],
//     description: json["description"],
//     firstIssue: FirstIssue.fromJson(json["first_issue"]),
//     id: json["id"],
//     image: Images.fromJson(json["image"]),
//     lastIssue: FirstIssue.fromJson(json["last_issue"]),
//     name: json["name"],
//     publisher: FirstIssue.fromJson(json["publisher"]),
//     siteDetailUrl: json["site_detail_url"],
//     startYear: json["start_year"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "aliases": aliases,
//     "api_detail_url": apiDetailUrl,
//     "count_of_issues": countOfIssues,
//     "date_added": dateAdded.toIso8601String(),
//     "date_last_updated": dateLastUpdated.toIso8601String(),
//     "deck": deck,
//     "description": description,
//     "first_issue": firstIssue.toJson(),
//     "id": id,
//     "image": image.toJson(),
//     "last_issue": lastIssue.toJson(),
//     "name": name,
//     "publisher": publisher.toJson(),
//     "site_detail_url": siteDetailUrl,
//     "start_year": startYear,
//   };
// }
//
// class FirstIssue {
//   FirstIssue({
//     required  this.apiDetailUrl,
//     required  this.id,
//     required this.name,
//     required this.issueNumber,
//   });
//
//   String apiDetailUrl;
//   int id;
//   String name;
//   String issueNumber;
//
//   factory FirstIssue.fromJson(Map<String, dynamic> json) => FirstIssue(
//     apiDetailUrl: json["api_detail_url"],
//     id: json["id"],
//     name: json["name"],
//     issueNumber: json["issue_number"] == null ? null : json["issue_number"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "api_detail_url": apiDetailUrl,
//     "id": id,
//     "name": name,
//     "issue_number": issueNumber == null ? null : issueNumber,
//   };
// }
//
// class Images {
//   Images({
//     required this.iconUrl,
//     required this.mediumUrl,
//     required this.screenUrl,
//     required this.screenLargeUrl,
//     required this.smallUrl,
//     required this.superUrl,
//     required this.thumbUrl,
//     required this.tinyUrl,
//     required this.originalUrl,
//     required this.imageTags,
//   });
//
//   String iconUrl;
//   String mediumUrl;
//   String screenUrl;
//   String screenLargeUrl;
//   String smallUrl;
//   String superUrl;
//   String thumbUrl;
//   String tinyUrl;
//   String originalUrl;
//   String imageTags;
//
//   factory Images.fromJson(Map<String, dynamic> json) => Images(
//     iconUrl: json["icon_url"],
//     mediumUrl: json["medium_url"],
//     screenUrl: json["screen_url"],
//     screenLargeUrl: json["screen_large_url"],
//     smallUrl: json["small_url"],
//     superUrl: json["super_url"],
//     thumbUrl: json["thumb_url"],
//     tinyUrl: json["tiny_url"],
//     originalUrl: json["original_url"],
//     imageTags: json["image_tags"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "icon_url": iconUrl,
//     "medium_url": mediumUrl,
//     "screen_url": screenUrl,
//     "screen_large_url": screenLargeUrl,
//     "small_url": smallUrl,
//     "super_url": superUrl,
//     "thumb_url": thumbUrl,
//     "tiny_url": tinyUrl,
//     "original_url": originalUrl,
//     "image_tags": imageTags,
//   };
// }
