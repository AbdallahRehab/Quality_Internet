
import 'dart:convert';

PlayerEducationsModel playerEducationsModelFromJson(String str) => PlayerEducationsModel.fromJson(json.decode(str));

String playerEducationsModelToJson(PlayerEducationsModel data) => json.encode(data.toJson());

class PlayerEducationsModel {
  int? count;
  List<PlayerEducationsData>? results;
  String? next;
  String? previous;

  PlayerEducationsModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerEducationsModel.fromJson(Map<String, dynamic> json) => PlayerEducationsModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerEducationsData>.from(json["results"]!.map((x) => PlayerEducationsData.fromJson(x))),
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

class PlayerEducationsData {
  int? id;
  String? year;
  String? degree;
  String? universty;

  PlayerEducationsData({
    this.id,
    this.year,
    this.degree,
    this.universty,
  });

  factory PlayerEducationsData.fromJson(Map<String, dynamic> json) => PlayerEducationsData(
    id: json["id"],
    year: json["year"],
    degree: json["degree"],
    universty: json["universty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "year": year,
    "degree": degree,
    "universty": universty,
  };
}
