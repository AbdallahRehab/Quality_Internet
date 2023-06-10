import 'dart:convert';

UpdateAttendanceDayModel updateAttendanceDayModelFromJson(String str) =>
    UpdateAttendanceDayModel.fromJson(json.decode(str));

String updateAttendanceDayModelToJson(UpdateAttendanceDayModel data) =>
    json.encode(data.toJson());

class UpdateAttendanceDayModel {
  String? message;
  Data? data;
  bool? errors;

  UpdateAttendanceDayModel({
    this.message,
    this.data,
    this.errors,
  });

  factory UpdateAttendanceDayModel.fromJson(Map<String, dynamic> json) =>
      UpdateAttendanceDayModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "errors": errors,
      };
}

class Data {
  String? status;

  Data({
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
