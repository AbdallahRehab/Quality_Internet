
import 'dart:convert';

TeamInfoModel teamInfoModelFromJson(String str) => TeamInfoModel.fromJson(json.decode(str));

String teamInfoModelToJson(TeamInfoModel data) => json.encode(data.toJson());

class TeamInfoModel {
  int? id;
  List<Coach>? coaches;
  String? sport;
  int? playersCount;
  String? name;
  String? description;
  dynamic icon;
  String? iconUrl;
  String? ratePer;
  int? fromAge;
  int? toAge;
  String? gender;
  String? attendPer;

  TeamInfoModel({
    this.id,
    this.coaches,
    this.sport,
    this.playersCount,
    this.name,
    this.description,
    this.icon,
    this.iconUrl,
    this.ratePer,
    this.fromAge,
    this.toAge,
    this.gender,
    this.attendPer,
  });

  factory TeamInfoModel.fromJson(Map<String, dynamic> json) => TeamInfoModel(
    id: json["id"],
    coaches: json["coaches"] == null ? [] : List<Coach>.from(json["coaches"]!.map((x) => Coach.fromJson(x))),
    sport: json["sport"],
    playersCount: json["players_count"],
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
    iconUrl: json["icon_url"],
    ratePer: json["rate_per"],
    fromAge: json["from_age"],
    toAge: json["to_age"],
    gender: json["gender"],
    attendPer: json["attend_per"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coaches": coaches == null ? [] : List<dynamic>.from(coaches!.map((x) => x.toJson())),
    "sport": sport,
    "players_count": playersCount,
    "name": name,
    "description": description,
    "icon": icon,
    "icon_url": iconUrl,
    "rate_per": ratePer,
    "from_age": fromAge,
    "to_age": toAge,
    "gender": gender,
    "attend_per": attendPer,
  };
}

class Coach {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;

  Coach({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}
