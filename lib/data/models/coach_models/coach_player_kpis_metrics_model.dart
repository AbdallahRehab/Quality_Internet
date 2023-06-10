
import 'dart:convert';

CoachPlayerKpisMetricsModel coachPlayerKpisMetricsModelFromJson(String str) => CoachPlayerKpisMetricsModel.fromJson(json.decode(str));

String coachPlayerKpisMetricsModelToJson(CoachPlayerKpisMetricsModel data) => json.encode(data.toJson());

class CoachPlayerKpisMetricsModel {
  int? id;
  String? kpi;
  String? scoreAvg;
  String? oldScoreAvg;

  CoachPlayerKpisMetricsModel({
    this.id,
    this.kpi,
    this.scoreAvg,
    this.oldScoreAvg,
  });

  factory CoachPlayerKpisMetricsModel.fromJson(Map<String, dynamic> json) => CoachPlayerKpisMetricsModel(
    id: json["id"],
    kpi: json["kpi"],
    scoreAvg: json["score_avg"],
    oldScoreAvg: json["old_score_avg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kpi": kpi,
    "score_avg": scoreAvg,
    "old_score_avg": oldScoreAvg,
  };
}
