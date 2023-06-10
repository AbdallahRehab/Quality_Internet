import 'dart:convert';

UpdateKpiScoreModel updateKpiRateModelFromJson(String str) =>
    UpdateKpiScoreModel.fromJson(json.decode(str));

String updateKpiRateModelToJson(UpdateKpiScoreModel data) =>
    json.encode(data.toJson());

class UpdateKpiScoreModel {
  String? message;
  Data? data;
  bool? errors;

  UpdateKpiScoreModel({
    this.message,
    this.data,
    this.errors,
  });

  factory UpdateKpiScoreModel.fromJson(Map<String, dynamic> json) =>
      UpdateKpiScoreModel(
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
  int? score;
  int? maxScore;

  Data({
    this.score,
    this.maxScore,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        score: json["score"],
        maxScore: json["max_score"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "max_score": maxScore,
      };
}
