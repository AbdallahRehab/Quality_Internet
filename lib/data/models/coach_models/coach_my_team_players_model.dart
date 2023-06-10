import 'dart:convert';

CoachMyTeamPlayersModel coachMyTeamPlayersModelFromJson(String str) =>
    CoachMyTeamPlayersModel.fromJson(json.decode(str));

String coachMyTeamPlayersModelToJson(CoachMyTeamPlayersModel data) =>
    json.encode(data.toJson());

class CoachMyTeamPlayersModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<CoachMyTeamPlayersData>? results;

  CoachMyTeamPlayersModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CoachMyTeamPlayersModel.fromJson(Map<String, dynamic> json) =>
      CoachMyTeamPlayersModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<CoachMyTeamPlayersData>.from(json["results"]!
                .map((x) => CoachMyTeamPlayersData.fromJson(x))),
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

class CoachMyTeamPlayersData {
  int? id;
  String? icon;
  String? iconUrl;
  String? name;
  DateTime? dob;
  dynamic worldWeight;
  String? olympicWeight;
  String? height;
  Sport? sport;
  String? parentName;
  dynamic profile;
  List<Team>? team;
  String? phone;
  FrontLeg? frontLeg;

  CoachMyTeamPlayersData({
    this.id,
    this.icon,
    this.iconUrl,
    this.name,
    this.dob,
    this.worldWeight,
    this.olympicWeight,
    this.height,
    this.sport,
    this.parentName,
    this.profile,
    this.team,
    this.phone,
    this.frontLeg,
  });

  factory CoachMyTeamPlayersData.fromJson(Map<String, dynamic> json) =>
      CoachMyTeamPlayersData(
        id: json["id"],
        icon: json["icon"],
        iconUrl: json["icon_url"],
        name: json["name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        worldWeight: json["world_weight"],
        olympicWeight: json["olympic_weight"],
        height: json["height"],
        // sport: sportValues.map[json["sport"]]!,
        parentName: json["parent_name"],
        profile: json["profile"],
        team: json["team"] == null
            ? []
            : List<Team>.from(json["team"]!.map((x) => Team.fromJson(x))),
        phone: json["phone"],
        // frontLeg: frontLegValues.map[json["front_leg"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "icon_url": iconUrl,
        "name": name,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "world_weight": worldWeight,
        "olympic_weight": olympicWeight,
        "height": height,
        "sport": sportValues.reverse[sport],
        "parent_name": parentName,
        "profile": profile,
        "team": team == null
            ? []
            : List<dynamic>.from(team!.map((x) => x.toJson())),
        "phone": phone,
        "front_leg": frontLegValues.reverse[frontLeg],
      };
}

enum FrontLeg { NONE, BOTH }

final frontLegValues =
    EnumValues({"BOTH": FrontLeg.BOTH, "NONE": FrontLeg.NONE});

enum Sport { TAEKWONDO }

final sportValues = EnumValues({"Taekwondo": Sport.TAEKWONDO});

class Team {
  int? id;
  Name? name;

  Team({
    this.id,
    this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        // name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
      };
}

enum Name { TEST, CADETS, CHILDS, JUNIORS, SENIORS }

final nameValues = EnumValues({
  "Cadets": Name.CADETS,
  "Childs": Name.CHILDS,
  "Juniors": Name.JUNIORS,
  "Seniors": Name.SENIORS,
  "Test": Name.TEST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
