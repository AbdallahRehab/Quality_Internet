
import 'dart:convert';

CoachActionsList coachActionsListFromJson(String str) => CoachActionsList.fromJson(json.decode(str));

String coachActionsListToJson(CoachActionsList data) => json.encode(data.toJson());

class CoachActionsList {
  int? count;
  List<CoachActionsListData>? results;
  String? next;
  String? previous;

  CoachActionsList({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachActionsList.fromJson(Map<String, dynamic> json) => CoachActionsList(
    count: json["count"],
    results: json["results"] == null ? [] : List<CoachActionsListData>.from(json["results"]!.map((x) => CoachActionsListData.fromJson(x))),
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

class CoachActionsListData {
  String? name;
  Metric? metric;
  int? id;
  String? description;

  CoachActionsListData({
    this.name,
    this.metric,
    this.id,
    this.description,
  });

  factory CoachActionsListData.fromJson(Map<String, dynamic> json) => CoachActionsListData(
    name: json["name"],
    metric: json["metric"] == null ? null : Metric.fromJson(json["metric"]),
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "metric": metric?.toJson(),
    "id": id,
    "description": description,
  };
}

class Metric {
  String? name;
  int? id;

  Metric({
    this.name,
    this.id,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
