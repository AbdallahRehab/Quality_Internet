
import 'dart:convert';

List<CoachCalendarDetailed> coachCalendarDetailedFromJson(String str) => List<CoachCalendarDetailed>.from(json.decode(str).map((x) => CoachCalendarDetailed.fromJson(x)));

String coachCalendarDetailedToJson(List<CoachCalendarDetailed> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoachCalendarDetailed {
  String? name;
  Statistics? statistics;

  CoachCalendarDetailed({
    this.name,
    this.statistics,
  });

  factory CoachCalendarDetailed.fromJson(Map<String, dynamic> json) => CoachCalendarDetailed(
    name: json["name"],
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "statistics": statistics?.toJson(),
  };
}

class Statistics {
  double? attends;
  double? absent;
  int? upcoming;

  Statistics({
    this.attends,
    this.absent,
    this.upcoming,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    attends: json["attends"]?.toDouble(),
    absent: json["absent"]?.toDouble(),
    upcoming: json["upcoming"],
  );

  Map<String, dynamic> toJson() => {
    "attends": attends,
    "absent": absent,
    "upcoming": upcoming,
  };
}
