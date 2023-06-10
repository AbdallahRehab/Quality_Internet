import 'dart:convert';

ClubTeamsModel clubTeamsModelFromJson(String str) =>
    ClubTeamsModel.fromJson(json.decode(str));

String clubTeamsModelToJson(ClubTeamsModel data) => json.encode(data.toJson());

class ClubTeamsModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<ClubTeamsData>? results;

  ClubTeamsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ClubTeamsModel.fromJson(Map<String, dynamic> json) => ClubTeamsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<ClubTeamsData>.from(
                json["results"]!.map((x) => ClubTeamsData.fromJson(x))),
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

class ClubTeamsData {
  int? id;
  String? name;

  ClubTeamsData({
    this.id,
    this.name,
  });

  factory ClubTeamsData.fromJson(Map<String, dynamic> json) => ClubTeamsData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
