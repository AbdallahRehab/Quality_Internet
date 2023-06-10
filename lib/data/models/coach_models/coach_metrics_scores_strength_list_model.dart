
import 'dart:convert';

CoachMetricsScoresStrengthList coachMetricsScoresStrengthListFromJson(String str) => CoachMetricsScoresStrengthList.fromJson(json.decode(str));

String coachMetricsScoresStrengthListToJson(CoachMetricsScoresStrengthList data) => json.encode(data.toJson());

class CoachMetricsScoresStrengthList {
  int? count;
  List<CoachMetricsScoresStrengthListData>? results;
  String? next;
  String? previous;

  CoachMetricsScoresStrengthList({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachMetricsScoresStrengthList.fromJson(Map<String, dynamic> json) => CoachMetricsScoresStrengthList(
    count: json["count"],
    results: json["results"] == null ? [] : List<CoachMetricsScoresStrengthListData>.from(json["results"]!.map((x) => CoachMetricsScoresStrengthListData.fromJson(x))),
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

class CoachMetricsScoresStrengthListData {
  int? id;
  String? metric;
  String? kpi;
  String? avgScore;
  String? level;

  CoachMetricsScoresStrengthListData({
    this.id,
    this.metric,
    this.kpi,
    this.avgScore,
    this.level,
  });

  factory CoachMetricsScoresStrengthListData.fromJson(Map<String, dynamic> json) => CoachMetricsScoresStrengthListData(
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
