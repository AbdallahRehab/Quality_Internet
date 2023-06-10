import 'dart:convert';

TeamAttendanceDayModel teamAttendanceDayModelFromJson(String str) =>
    TeamAttendanceDayModel.fromJson(json.decode(str));

String teamAttendanceDayModelToJson(TeamAttendanceDayModel data) =>
    json.encode(data.toJson());

class TeamAttendanceDayModel {
  int? count;
  List<TeamAttendanceDayData>? results;
  String? next;
  String? previous;

  TeamAttendanceDayModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory TeamAttendanceDayModel.fromJson(Map<String, dynamic> json) =>
      TeamAttendanceDayModel(
        count: json["count"],
        results: json["results"] == null
            ? []
            : List<TeamAttendanceDayData>.from(
                json["results"]!.map((x) => TeamAttendanceDayData.fromJson(x))),
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "next": next,
        "previous": previous,
      };
}

class TeamAttendanceDayData {
  DateTime? day;
  int? id;
  String? status;
  List<AttendanceSession>? attendanceSessions;

  TeamAttendanceDayData({
    this.day,
    this.id,
    this.status,
    this.attendanceSessions,
  });

  factory TeamAttendanceDayData.fromJson(Map<String, dynamic> json) =>
      TeamAttendanceDayData(
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        id: json["id"],
        status: json["status"],
        attendanceSessions: json["attendance_sessions"] == null
            ? []
            : List<AttendanceSession>.from(json["attendance_sessions"]!
                .map((x) => AttendanceSession.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "id": id,
        "status": status,
        "attendance_sessions": attendanceSessions == null
            ? []
            : List<dynamic>.from(attendanceSessions!.map((x) => x.toJson())),
      };
}

class AttendanceSession {
  String? fromHour;
  String? toHour;
  int? id;
  String? status;

  AttendanceSession({
    this.fromHour,
    this.toHour,
    this.id,
    this.status,
  });

  factory AttendanceSession.fromJson(Map<String, dynamic> json) =>
      AttendanceSession(
        fromHour: json["from_hour"],
        toHour: json["to_hour"],
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "from_hour": fromHour,
        "to_hour": toHour,
        "id": id,
        "status": status,
      };
}
