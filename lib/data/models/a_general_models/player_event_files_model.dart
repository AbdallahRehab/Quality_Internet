
import 'dart:convert';

PlayerEventFilesModel playerEventFilesModelFromJson(String str) => PlayerEventFilesModel.fromJson(json.decode(str));

String playerEventFilesModelToJson(PlayerEventFilesModel data) => json.encode(data.toJson());

class PlayerEventFilesModel {
  int? id;
  List<EventFile>? eventFiles;
  String? videoUrl;

  PlayerEventFilesModel({
    this.id,
    this.eventFiles,
    this.videoUrl,
  });

  factory PlayerEventFilesModel.fromJson(Map<String, dynamic> json) => PlayerEventFilesModel(
    id: json["id"],
    eventFiles: json["event_files"] == null ? [] : List<EventFile>.from(json["event_files"]!.map((x) => EventFile.fromJson(x))),
    videoUrl: json["video_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "event_files": eventFiles == null ? [] : List<dynamic>.from(eventFiles!.map((x) => x.toJson())),
    "video_url": videoUrl,
  };
}

class EventFile {
  int? id;
  String? file;

  EventFile({
    this.id,
    this.file,
  });

  factory EventFile.fromJson(Map<String, dynamic> json) => EventFile(
    id: json["id"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
  };
}
