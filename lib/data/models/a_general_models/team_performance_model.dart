// To parse this JSON data, do
//
//     final teamPerformanceModel = teamPerformanceModelFromJson(jsonString);

import 'dart:convert';

TeamPerformanceModel teamPerformanceModelFromJson(String str) => TeamPerformanceModel.fromJson(json.decode(str));

String teamPerformanceModelToJson(TeamPerformanceModel data) => json.encode(data.toJson());

class TeamPerformanceModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<TeamPerformanceData>? results;

  TeamPerformanceModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory TeamPerformanceModel.fromJson(Map<String, dynamic> json) => TeamPerformanceModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<TeamPerformanceData>.from(json["results"]!.map((x) => TeamPerformanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class TeamPerformanceData {
  int? id;
  String? icon;
  String? name;
  List<PlayerMetric>? playerMetric;

  TeamPerformanceData({
    this.id,
    this.icon,
    this.name,
    this.playerMetric,
  });

  factory TeamPerformanceData.fromJson(Map<String, dynamic> json) => TeamPerformanceData(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
    playerMetric: json["player_metric"] == null ? [] : List<PlayerMetric>.from(json["player_metric"]!.map((x) => PlayerMetric.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "name": name,
    "player_metric": playerMetric == null ? [] : List<dynamic>.from(playerMetric!.map((x) => x.toJson())),
  };
}

class PlayerMetric {
  int? id;
  String? metric;
  int? lastScore;
  String? kpi;

  PlayerMetric({
    this.id,
    this.metric,
    this.lastScore,
    this.kpi,
  });

  factory PlayerMetric.fromJson(Map<String, dynamic> json) => PlayerMetric(
    id: json["id"],
    metric: json["metric"],
    lastScore: json["last_score"],
    kpi: json["kpi"]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "metric": metric,
    "last_score": lastScore,
    "kpi": kpi,
  };
}


