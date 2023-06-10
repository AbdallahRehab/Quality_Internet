
import 'dart:convert';

CoachRecommendationsList coachRecommendationsListFromJson(String str) => CoachRecommendationsList.fromJson(json.decode(str));

String coachRecommendationsListToJson(CoachRecommendationsList data) => json.encode(data.toJson());

class CoachRecommendationsList {
  int? count;
  List<CoachRecommendationsListData>? results;
  String? next;
  String? previous;

  CoachRecommendationsList({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachRecommendationsList.fromJson(Map<String, dynamic> json) => CoachRecommendationsList(
    count: json["count"],
    results: json["results"] == null ? [] : List<CoachRecommendationsListData>.from(json["results"]!.map((x) => CoachRecommendationsListData.fromJson(x))),
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

class CoachRecommendationsListData {
  String? name;
  Metric? metric;
  int? id;
  String? description;

  CoachRecommendationsListData({
    this.name,
    this.metric,
    this.id,
    this.description,
  });

  factory CoachRecommendationsListData.fromJson(Map<String, dynamic> json) => CoachRecommendationsListData(
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
