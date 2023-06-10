
import 'dart:convert';

PlayerSkillsModel playerSkillsModelFromJson(String str) => PlayerSkillsModel.fromJson(json.decode(str));

String playerSkillsModelToJson(PlayerSkillsModel data) => json.encode(data.toJson());

class PlayerSkillsModel {
  int? count;
  List<PlayerSkillsData>? results;
  String? next;
  String? previous;

  PlayerSkillsModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerSkillsModel.fromJson(Map<String, dynamic> json) => PlayerSkillsModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerSkillsData>.from(json["results"]!.map((x) => PlayerSkillsData.fromJson(x))),
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

class PlayerSkillsData {
  String? name;
  int? id;

  PlayerSkillsData({
    this.name,
    this.id,
  });

  factory PlayerSkillsData.fromJson(Map<String, dynamic> json) => PlayerSkillsData(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
