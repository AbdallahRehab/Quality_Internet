
import 'dart:convert';

PlayerCoursesModel playerCoursesModelFromJson(String str) => PlayerCoursesModel.fromJson(json.decode(str));

String playerCoursesModelToJson(PlayerCoursesModel data) => json.encode(data.toJson());

class PlayerCoursesModel {
  int? count;
  List<PlayerCoursesData>? results;
  String? next;
  String? previous;

  PlayerCoursesModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerCoursesModel.fromJson(Map<String, dynamic> json) => PlayerCoursesModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerCoursesData>.from(json["results"]!.map((x) => PlayerCoursesData.fromJson(x))),
    next: json["next"],
    previous: json["previous"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "next": next,
    "previous": previous,
  };
}

class PlayerCoursesData {
  String? name;
  int? id;

  PlayerCoursesData({
    this.name,
    this.id,
  });

  factory PlayerCoursesData.fromJson(Map<String, dynamic> json) => PlayerCoursesData(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
