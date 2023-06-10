
import 'dart:convert';

CoachMetricsScoresWeaknessList coachMetricsScoresWeaknessListFromJson(String str) => CoachMetricsScoresWeaknessList.fromJson(json.decode(str));

String coachMetricsScoresWeaknessListToJson(CoachMetricsScoresWeaknessList data) => json.encode(data.toJson());

class CoachMetricsScoresWeaknessList {
  int? count;
  List<CoachMetricsScoresWeaknessListData>? results;
  String? next;
  String? previous;

  CoachMetricsScoresWeaknessList({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory CoachMetricsScoresWeaknessList.fromJson(Map<String, dynamic> json) => CoachMetricsScoresWeaknessList(
    count: json["count"],
    results: json["results"] == null ? [] : List<CoachMetricsScoresWeaknessListData>.from(json["results"]!.map((x) => CoachMetricsScoresWeaknessListData.fromJson(x))),
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

class CoachMetricsScoresWeaknessListData {
  int? id;
  String? metric;
  String? kpi;
  String? avgScore;
  String? level;

  CoachMetricsScoresWeaknessListData({
    this.id,
    this.metric,
    this.kpi,
    this.avgScore,
    this.level,
  });

  factory CoachMetricsScoresWeaknessListData.fromJson(Map<String, dynamic> json) => CoachMetricsScoresWeaknessListData(
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
