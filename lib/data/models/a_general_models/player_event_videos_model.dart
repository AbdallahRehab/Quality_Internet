
import 'dart:convert';

PlayerEventVideosModel playerEventVideosModelFromJson(String str) => PlayerEventVideosModel.fromJson(json.decode(str));

String playerEventVideosModelToJson(PlayerEventVideosModel data) => json.encode(data.toJson());

class PlayerEventVideosModel {
  int? id;
  List<EventVideo>? eventVideos;

  PlayerEventVideosModel({
    this.id,
    this.eventVideos,
  });

  factory PlayerEventVideosModel.fromJson(Map<String, dynamic> json) => PlayerEventVideosModel(
    id: json["id"],
    eventVideos: json["event_videos"] == null ? [] : List<EventVideo>.from(json["event_videos"]!.map((x) => EventVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "event_videos": eventVideos == null ? [] : List<dynamic>.from(eventVideos!.map((x) => x.toJson())),
  };
}

class EventVideo {
  String? video;
  int? id;

  EventVideo({
    this.video,
    this.id,
  });

  factory EventVideo.fromJson(Map<String, dynamic> json) => EventVideo(
    video: json["video"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "video": video,
    "id": id,
  };
}
