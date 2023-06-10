
import 'dart:convert';

ClubsModel clubsModelFromJson(String str) => ClubsModel.fromJson(json.decode(str));

String clubsModelToJson(ClubsModel data) => json.encode(data.toJson());

class ClubsModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<ClubData>? results;

  ClubsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ClubsModel.fromJson(Map<String, dynamic> json) => ClubsModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<ClubData>.from(json["results"]!.map((x) => ClubData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class ClubData {
  int? id;
  String? name;
  String? icon;
  String? iconUrl;

  ClubData({
    this.id,
    this.name,
    this.icon,
    this.iconUrl,
  });

  factory ClubData.fromJson(Map<String, dynamic> json) => ClubData(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    iconUrl: json["icon_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "icon_url": iconUrl,
  };
}
