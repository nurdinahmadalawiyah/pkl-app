// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    bool status;
    String message;
    User user;

    Register({
        required this.status,
        required this.message,
        required this.user,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    String username;
    String nama;
    String nik;
    DateTime updatedAt;
    DateTime createdAt;
    int idPembimbing;

    User({
        required this.username,
        required this.nama,
        required this.nik,
        required this.updatedAt,
        required this.createdAt,
        required this.idPembimbing,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        nama: json["nama"],
        nik: json["nik"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        idPembimbing: json["id_pembimbing"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "nama": nama,
        "nik": nik,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id_pembimbing": idPembimbing,
    };
}
