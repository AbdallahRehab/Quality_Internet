
import 'dart:convert';

PlayerInfoModel playerInfoModelFromJson(String str) => PlayerInfoModel.fromJson(json.decode(str));

String playerInfoModelToJson(PlayerInfoModel data) => json.encode(data.toJson());

class PlayerInfoModel {
  int? id;
  String? icon;
  String? iconUrl;
  String? name;
  DateTime? dob;
  dynamic worldWeight;
  String? olympicWeight;
  dynamic weight;
  String? height;
  String? sport;
  String? parentName;
  dynamic profile;
  List<TeamPlayerInfo>? team;
  String? phone;
  String? frontLeg;

  PlayerInfoModel({
    this.id,
    this.icon,
    this.iconUrl,
    this.name,
    this.dob,
    this.worldWeight,
    this.olympicWeight,
    this.weight,
    this.height,
    this.sport,
    this.parentName,
    this.profile,
    this.team,
    this.phone,
    this.frontLeg,
  });

  factory PlayerInfoModel.fromJson(Map<String, dynamic> json) => PlayerInfoModel(
    id: json["id"],
    icon: json["icon"],
    iconUrl: json["icon_url"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    worldWeight: json["world_weight"],
    olympicWeight: json["olympic_weight"],
    weight: json["weight"],
    height: json["height"],
    sport: json["sport"],
    parentName: json["parent_name"],
    profile: json["profile"],
    team: json["team"] == null ? [] : List<TeamPlayerInfo>.from(json["team"]!.map((x) => TeamPlayerInfo.fromJson(x))),
    phone: json["phone"],
    frontLeg: json["front_leg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "icon_url": iconUrl,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "world_weight": worldWeight,
    "olympic_weight": olympicWeight,
    "weight": weight,
    "height": height,
    "sport": sport,
    "parent_name": parentName,
    "profile": profile,
    "team": team == null ? [] : List<dynamic>.from(team!.map((x) => x.toJson())),
    "phone": phone,
    "front_leg": frontLeg,
  };
}

class TeamPlayerInfo {
  int? id;
  String? name;

  TeamPlayerInfo({
    this.id,
    this.name,
  });

  factory TeamPlayerInfo.fromJson(Map<String, dynamic> json) => TeamPlayerInfo(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
