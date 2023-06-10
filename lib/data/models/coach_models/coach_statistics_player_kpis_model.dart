
import 'dart:convert';

CoachStatisticsPlayerKpisModel coachStatisticsPlayerKpisModelFromJson(String str) => CoachStatisticsPlayerKpisModel.fromJson(json.decode(str));

String coachStatisticsPlayerKpisModelToJson(CoachStatisticsPlayerKpisModel data) => json.encode(data.toJson());

class CoachStatisticsPlayerKpisModel {
  int? count;
  List<CoachStatisticsPlayerKpisData>? results;
  String? next;
  String? previous;

  CoachStatisticsPlayerKpisModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachStatisticsPlayerKpisModel.fromJson(Map<String, dynamic> json) => CoachStatisticsPlayerKpisModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<CoachStatisticsPlayerKpisData>.from(json["results"]!.map((x) => CoachStatisticsPlayerKpisData.fromJson(x))),
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

class CoachStatisticsPlayerKpisData {
  String? name;
  int? id;
  String? statistics;
  String? icon;
  String? iconUrl;

  CoachStatisticsPlayerKpisData({
    this.name,
    this.id,
    this.statistics,
    this.icon,
    this.iconUrl,
  });

  factory CoachStatisticsPlayerKpisData.fromJson(Map<String, dynamic> json) => CoachStatisticsPlayerKpisData(
    name: json["name"],
    id: json["id"],
    statistics: json["statistics"],
    icon: json["icon"],
    iconUrl: json["icon_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "statistics": statistics,
    "icon": icon,
    "icon_url": iconUrl,
  };
}
