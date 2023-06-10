
import 'dart:convert';

CoachMetricsScoresModerateList coachMetricsScoresModerateListFromJson(String str) => CoachMetricsScoresModerateList.fromJson(json.decode(str));

String coachMetricsScoresModerateListToJson(CoachMetricsScoresModerateList data) => json.encode(data.toJson());

class CoachMetricsScoresModerateList {
  int? count;
  List<MetricsScoresModerateListData>? results;
  String? next;
  String? previous;

  CoachMetricsScoresModerateList({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachMetricsScoresModerateList.fromJson(Map<String, dynamic> json) => CoachMetricsScoresModerateList(
    count: json["count"],
    results: json["results"] == null ? [] : List<MetricsScoresModerateListData>.from(json["results"]!.map((x) => MetricsScoresModerateListData.fromJson(x))),
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

class MetricsScoresModerateListData {
  int? id;
  String? metric;
  String? kpi;
  String? avgScore;
  String? level;

  MetricsScoresModerateListData({
    this.id,
    this.metric,
    this.kpi,
    this.avgScore,
    this.level,
  });

  factory MetricsScoresModerateListData.fromJson(Map<String, dynamic> json) => MetricsScoresModerateListData(
    id: json["id"],
    metric: json["metric"],
    kpi: json["kpi"],
    avgScore: json["avg_score"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "metric": metric,
    "kpi": kpi,
    "avg_score": avgScore,
    "level": level,
  };
}
