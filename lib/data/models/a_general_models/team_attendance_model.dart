import 'dart:convert';

TeamAttendanceModel teamAttendanceModelFromJson(String str) =>
    TeamAttendanceModel.fromJson(json.decode(str));

String teamAttendanceModelToJson(TeamAttendanceModel data) =>
    json.encode(data.toJson());

class TeamAttendanceModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<TeamAttendanceData>? results;

  TeamAttendanceModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory TeamAttendanceModel.fromJson(Map<String, dynamic> json) =>
      TeamAttendanceModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<TeamAttendanceData>.from(
                json["results"]!.map((x) => TeamAttendanceData.fromJson(x))),
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

class TeamAttendanceData {
  int? id;
  String? icon;
  String? name;
  List<PlayerAttendance?>? playerAttendance;

  TeamAttendanceData({
    this.id,
    this.icon,
    this.name,
    this.playerAttendance,
  });

  factory TeamAttendanceData.fromJson(Map<String, dynamic> json) =>
      TeamAttendanceData(
        id: json["id"],
        icon: json["icon"],
        name: json["name"],
        playerAttendance: json["player_attendance"] == null
            ? []
            : List<PlayerAttendance>.from(json["player_attendance"]!
                .map((x) => PlayerAttendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "name": name,
        "player_attendance": playerAttendance == null
            ? []
            : List<dynamic>.from(playerAttendance!.map((x) => x!.toJson())),
      };
}

class PlayerAttendance {
  int? id;
  DateTime? day;
  String? status;
  List<AttendanceSession>? attendanceSessions;

  PlayerAttendance({
    this.id,
    this.day,
    this.status,
    this.attendanceSessions,
  });

  factory PlayerAttendance.fromJson(Map<String, dynamic> json) =>
      PlayerAttendance(
        id: json["id"],
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        status: json["status"],
        attendanceSessions: json["attendance_sessions"] == null
            ? []
            : List<AttendanceSession>.from(json["attendance_sessions"]!
                .map((x) => AttendanceSession.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "status": status,
        "attendance_sessions": attendanceSessions == null
            ? []
            : List<dynamic>.from(attendanceSessions!.map((x) => x.toJson())),
      };
}

class AttendanceSession {
  int? id;
  String? fromHour;
  String? toHour;
  String? status;

  AttendanceSession({
    this.id,
    this.fromHour,
    this.toHour,
    this.status,
  });

  factory AttendanceSession.fromJson(Map<String, dynamic> json) =>
      AttendanceSession(
        id: json["id"],
        fromHour: json["from_hour"],
        toHour: json["to_hour"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_hour": fromHour,
        "to_hour": toHour,
        "status": status,
      };
}
