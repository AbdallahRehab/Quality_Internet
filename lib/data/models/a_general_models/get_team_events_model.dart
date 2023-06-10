import 'dart:convert';

GetTeamEventsModel getTeamEventsModelFromJson(String str) =>
    GetTeamEventsModel.fromJson(json.decode(str));

String getTeamEventsModelToJson(GetTeamEventsModel data) =>
    json.encode(data.toJson());

class GetTeamEventsModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  GetTeamEventsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetTeamEventsModel.fromJson(Map<String, dynamic> json) =>
      GetTeamEventsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? name;
  String? icon;
  String? iconUrl;
  DateTime? date;
  Club? club;
  bool? upcoming;
  dynamic videoUrl;
  dynamic location;

  Result({
    this.id,
    this.name,
    this.icon,
    this.iconUrl,
    this.date,
    this.club,
    this.upcoming,
    this.videoUrl,
    this.location,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        iconUrl: json["icon_url"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        club: json["club"] == null ? null : Club.fromJson(json["club"]),
        upcoming: json["upcoming"],
        videoUrl: json["video_url"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "icon_url": iconUrl,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "club": club?.toJson(),
        "upcoming": upcoming,
        "video_url": videoUrl,
        "location": location,
      };
}

class Club {
  int? id;
  String? name;
  String? icon;
  String? iconUrl;

  Club({
    this.id,
    this.name,
    this.icon,
    this.iconUrl,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
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
