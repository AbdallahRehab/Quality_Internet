
import 'dart:convert';

PlayerAchievementsModel playerAchievementsModelFromJson(String str) => PlayerAchievementsModel.fromJson(json.decode(str));

String playerAchievementsModelToJson(PlayerAchievementsModel data) => json.encode(data.toJson());

class PlayerAchievementsModel {
  int? count;
  List<PlayerAchievementsData>? results;
  String? next;
  String? previous;

  PlayerAchievementsModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerAchievementsModel.fromJson(Map<String, dynamic> json) => PlayerAchievementsModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerAchievementsData>.from(json["results"]!.map((x) => PlayerAchievementsData.fromJson(x))),
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

class PlayerAchievementsData {
  String? type;
  int? id;
  DateTime? date;
  String? place;
  String? location;

  PlayerAchievementsData({
    this.type,
    this.id,
    this.date,
    this.place,
    this.location,
  });

  factory PlayerAchievementsData.fromJson(Map<String, dynamic> json) => PlayerAchievementsData(
    type: json["type"],
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    place: json["place"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "place": place,
    "location": location,
  };
}
