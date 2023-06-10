import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? country;
  List<dynamic>? teams;
  dynamic lastLogin;
  String? firstName;
  String? lastName;
  String? name;
  dynamic email;
  int? chatId;
  String? mobile;
  String? userType;
  dynamic bio;
  Details? details;
  String? avatar;
  dynamic job;
  DateTime? dob;
  int? club;

  UserModel({
    this.id,
    this.country,
    this.teams,
    this.lastLogin,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
    this.chatId,
    this.mobile,
    this.userType,
    this.bio,
    this.details,
    this.avatar,
    this.job,
    this.dob,
    this.club,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        country: json["country"],
        teams: json["teams"] == null
            ? []
            : List<dynamic>.from(json["teams"]!.map((x) => x)),
        lastLogin: json["last_login"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        name: json["name"],
        email: json["email"],
        chatId: json["chat_id"],
        mobile: json["mobile"],
        userType: json["user_type"],
        bio: json["bio"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        avatar: json["avatar"],
        job: json["job"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        club: json["club"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x)),
        "last_login": lastLogin,
        "first_name": firstName,
        "last_name": lastName,
        "name": name,
        "email": email,
        "chat_id": chatId,
        "mobile": mobile,
        "user_type": userType,
        "bio": bio,
        "details": details?.toJson(),
        "avatar": avatar,
        "job": job,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "club": club,
      };

  UserModel copyWith({
    int? id,
    String? country,
    List<dynamic>? teams,
    dynamic? lastLogin,
    String? firstName,
    String? lastName,
    String? name,
    dynamic? email,
    int? chatId,
    String? mobile,
    String? userType,
    dynamic? bio,
    Details? details,
    String? avatar,
    dynamic? job,
    DateTime? dob,
    int? club,
  }) {
    return UserModel(
      id: id ?? this.id,
      country: country ?? this.country,
      teams: teams ?? this.teams,
      lastLogin: lastLogin ?? this.lastLogin,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      email: email ?? this.email,
      chatId: chatId ?? this.chatId,
      mobile: mobile ?? this.mobile,
      userType: userType ?? this.userType,
      bio: bio ?? this.bio,
      details: details ?? this.details,
      avatar: avatar ?? this.avatar,
      job: job ?? this.job,
      dob: dob ?? this.dob,
      club: club ?? this.club,
    );
  }
}

class Details {
  Details();

  factory Details.fromJson(Map<String, dynamic> json) => Details();

  Map<String, dynamic> toJson() => {};
}
