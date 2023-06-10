// To parse this JSON data, do
//
//     final teamPerformanceMetricsModel = teamPerformanceMetricsModelFromJson(jsonString);

import 'dart:convert';

TeamPerformanceMetricsModel teamPerformanceMetricsModelFromJson(String str) =>
    TeamPerformanceMetricsModel.fromJson(json.decode(str));

String teamPerformanceMetricsModelToJson(TeamPerformanceMetricsModel data) =>
    json.encode(data.toJson());

class TeamPerformanceMetricsModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<TeamPerformanceMetricsData>? results;

  TeamPerformanceMetricsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory TeamPerformanceMetricsModel.fromJson(Map<String, dynamic> json) =>
      TeamPerformanceMetricsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<TeamPerformanceMetricsData>.from(json["results"]!
                .map((x) => TeamPerformanceMetricsData.fromJson(x))),
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

class TeamPerformanceMetricsData {
  int? id;
  String? name;
  List<KpiMetric>? kpiMetric;

  TeamPerformanceMetricsData({
    this.id,
    this.name,
    this.kpiMetric,
  });

  factory TeamPerformanceMetricsData.fromJson(Map<String, dynamic> json) =>
      TeamPerformanceMetricsData(
        id: json["id"],
        name: json["name"],
        kpiMetric: json["kpi_metric"] == null
            ? []
            : List<KpiMetric>.from(
                json["kpi_metric"]!.map((x) => KpiMetric.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kpi_metric": kpiMetric == null
            ? []
            : List<dynamic>.from(kpiMetric!.map((x) => x.toJson())),
      };
}

class KpiMetric {
  int? id;
  String? name;
  String? icon;

  KpiMetric({
    this.id,
    this.name,
    this.icon,
  });

  factory KpiMetric.fromJson(Map<String, dynamic> json) => KpiMetric(
        id: json["id"],
        name: json["name"],
        icon: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
