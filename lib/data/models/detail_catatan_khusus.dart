// To parse this JSON data, do
//
//     final detailCatatanKhusus = detailCatatanKhususFromJson(jsonString);

import 'dart:convert';

DetailCatatanKhusus detailCatatanKhususFromJson(String str) => DetailCatatanKhusus.fromJson(json.decode(str));

String detailCatatanKhususToJson(DetailCatatanKhusus data) => json.encode(data.toJson());

class DetailCatatanKhusus {
    String status;
    String message;
    Data data;

    DetailCatatanKhusus({
        required this.status,
        required this.message,
        required this.data,
    });

    factory DetailCatatanKhusus.fromJson(Map<String, dynamic> json) => DetailCatatanKhusus(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int idCatatanKhusus;
    int idMahasiswa;
    int idTempatPkl;
    String catatan;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.idCatatanKhusus,
        required this.idMahasiswa,
        required this.idTempatPkl,
        required this.catatan,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idCatatanKhusus: json["id_catatan_khusus"],
        idMahasiswa: json["id_mahasiswa"],
        idTempatPkl: json["id_tempat_pkl"],
        catatan: json["catatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_catatan_khusus": idCatatanKhusus,
        "id_mahasiswa": idMahasiswa,
        "id_tempat_pkl": idTempatPkl,
        "catatan": catatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
