
import 'dart:convert';

PlayerLeaguesModel playerLeaguesModelFromJson(String str) => PlayerLeaguesModel.fromJson(json.decode(str));

String playerLeaguesModelToJson(PlayerLeaguesModel data) => json.encode(data.toJson());

class PlayerLeaguesModel {
  int? count;
  List<PlayerLeaguesData>? results;
  String? next;
  String? previous;

  PlayerLeaguesModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerLeaguesModel.fromJson(Map<String, dynamic> json) => PlayerLeaguesModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerLeaguesData>.from(json["results"]!.map((x) => PlayerLeaguesData.fromJson(x))),
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

class PlayerLeaguesData {
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  int? id;
  String? location;

  PlayerLeaguesData({
    this.title,
    this.startDate,
    this.endDate,
    this.id,
    this.location,
  });

  factory PlayerLeaguesData.fromJson(Map<String, dynamic> json) => PlayerLeaguesData(
    title: json["title"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    id: json["id"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "id": id,
    "location": location,
  };
}
