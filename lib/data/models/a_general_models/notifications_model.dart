
import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  int? count;
  List<NotificationsData>? results;
  String? next;
  String? previous;

  NotificationsModel({
    this.count,
    this.results,
    this.next,
    this.previous,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    count: json["count"],
    results: json["results"] == null ? [] : List<NotificationsData>.from(json["results"]!.map((x) => NotificationsData.fromJson(x))),
    next: json["next"],
    previous: json["previous"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "next": next,
    "previous": previous,
  };
}

class NotificationsData {
  String? message;
  String? notificationType;
  Sender? sender;
  DateTime? createdAt;
  String? player;
  bool? read;
  int? unreadCount;

  NotificationsData({
    this.message,
    this.notificationType,
    this.sender,
    this.createdAt,
    this.player,
    this.read,
    this.unreadCount,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
    message: json["message"],
    notificationType: json["notification_type"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    player: json["player"],
    read: json["read"],
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "notification_type": notificationType,
    "sender": sender?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "player": player,
    "read": read,
    "unread_count": unreadCount,
  };
}

class Sender {
  int? id;
  String? fullName;
  String? avatar;

  Sender({
    this.id,
    this.fullName,
    this.avatar,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    fullName: json["full_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "avatar": avatar,
  };
}
