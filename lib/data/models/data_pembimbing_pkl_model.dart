// To parse this JSON data, do
//
//     final dataPembimbingPkl = dataPembimbingPklFromJson(jsonString);

import 'dart:convert';

DataPembimbingPkl dataPembimbingPklFromJson(String str) => DataPembimbingPkl.fromJson(json.decode(str));

String dataPembimbingPklToJson(DataPembimbingPkl data) => json.encode(data.toJson());

class DataPembimbingPkl {
    String status;
    String message;
    List<Datum> data;

    DataPembimbingPkl({
        required this.status,
        required this.message,
        required this.data,
    });

    factory DataPembimbingPkl.fromJson(Map<String, dynamic> json) => DataPembimbingPkl(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int idPembimbing;
    String username;
    String nama;
    String nik;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.idPembimbing,
        required this.username,
        required this.nama,
        required this.nik,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPembimbing: json["id_pembimbing"],
        username: json["username"],
        nama: json["nama"],
        nik: json["nik"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_pembimbing": idPembimbing,
        "username": username,
        "nama": nama,
        "nik": nik,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
