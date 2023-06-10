
import 'dart:convert';

PlayerEventsModel playerEventsModelFromJson(String str) => PlayerEventsModel.fromJson(json.decode(str));

String playerEventsModelToJson(PlayerEventsModel data) => json.encode(data.toJson());

class PlayerEventsModel {
  int? count;
  List<PlayerEventsData>? results;
  String? next;
  String? previous;

  PlayerEventsModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory PlayerEventsModel.fromJson(Map<String, dynamic> json) => PlayerEventsModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<PlayerEventsData>.from(json["results"]!.map((x) => PlayerEventsData.fromJson(x))),
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

class PlayerEventsData {
  String? name;
  int? id;
  String? icon;
  String? iconUrl;
  String? videoUrl;
  String? location;

  PlayerEventsData({
    this.name,
    this.id,
    this.icon,
    this.iconUrl,
    this.videoUrl,
    this.location,
  });

  factory PlayerEventsData.fromJson(Map<String, dynamic> json) => PlayerEventsData(
    name: json["name"],
    id: json["id"],
    icon: json["icon"],
    iconUrl: json["icon_url"],
    videoUrl: json["video_url"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "icon": icon,
    "icon_url": iconUrl,
    "video_url": videoUrl,
    "location": location,
  };
}
