
import 'dart:convert';

CoachMyClubModel coachMyClubModelFromJson(String str) => CoachMyClubModel.fromJson(json.decode(str));

String coachMyClubModelToJson(CoachMyClubModel data) => json.encode(data.toJson());

class CoachMyClubModel {
  int? id;
  String? name;
  String? icon;
  String? iconUrl;

  CoachMyClubModel({
    this.id,
    this.name,
    this.icon,
    this.iconUrl,
  });

  factory CoachMyClubModel.fromJson(Map<String, dynamic> json) => CoachMyClubModel(
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
