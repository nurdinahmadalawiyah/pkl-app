// To parse this JSON data, do
//
//     final catatanKhusus = catatanKhususFromJson(jsonString);

import 'dart:convert';

CatatanKhusus catatanKhususFromJson(String str) => CatatanKhusus.fromJson(json.decode(str));

String catatanKhususToJson(CatatanKhusus data) => json.encode(data.toJson());

class CatatanKhusus {
    String status;
    String message;
    String pdfUrl;
    Data data;

    CatatanKhusus({
        required this.status,
        required this.message,
        required this.pdfUrl,
        required this.data,
    });

    factory CatatanKhusus.fromJson(Map<String, dynamic> json) => CatatanKhusus(
        status: json["status"],
        message: json["message"],
        pdfUrl: json["pdf_url"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pdf_url": pdfUrl,
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
    String nama;
    String nim;

    Data({
        required this.idCatatanKhusus,
        required this.idMahasiswa,
        required this.idTempatPkl,
        required this.catatan,
        required this.createdAt,
        required this.updatedAt,
        required this.nama,
        required this.nim,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idCatatanKhusus: json["id_catatan_khusus"],
        idMahasiswa: json["id_mahasiswa"],
        idTempatPkl: json["id_tempat_pkl"],
        catatan: json["catatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nama: json["nama"],
        nim: json["nim"],
    );

    Map<String, dynamic> toJson() => {
        "id_catatan_khusus": idCatatanKhusus,
        "id_mahasiswa": idMahasiswa,
        "id_tempat_pkl": idTempatPkl,
        "catatan": catatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama": nama,
        "nim": nim,
    };
}
