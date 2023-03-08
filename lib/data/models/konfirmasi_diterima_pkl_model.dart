// To parse this JSON data, do
//
//     final konfirmasiDiterimaPkl = konfirmasiDiterimaPklFromJson(jsonString);

import 'dart:convert';

KonfirmasiDiterimaPkl konfirmasiDiterimaPklFromJson(String str) => KonfirmasiDiterimaPkl.fromJson(json.decode(str));

String konfirmasiDiterimaPklToJson(KonfirmasiDiterimaPkl data) => json.encode(data.toJson());

class KonfirmasiDiterimaPkl {
    KonfirmasiDiterimaPkl({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory KonfirmasiDiterimaPkl.fromJson(Map<String, dynamic> json) => KonfirmasiDiterimaPkl(
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
    Data({
        required this.idPengajuan,
        this.idPembimbing,
        required this.konfirmasiNamaPembimbing,
        required this.konfirmasiNikPembimbing,
        required this.updatedAt,
        required this.createdAt,
        required this.idTempatPkl,
    });

    String idPengajuan;
    dynamic idPembimbing;
    String konfirmasiNamaPembimbing;
    String konfirmasiNikPembimbing;
    DateTime updatedAt;
    DateTime createdAt;
    int idTempatPkl;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPengajuan: json["id_pengajuan"],
        idPembimbing: json["id_pembimbing"],
        konfirmasiNamaPembimbing: json["konfirmasi_nama_pembimbing"],
        konfirmasiNikPembimbing: json["konfirmasi_nik_pembimbing"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        idTempatPkl: json["id_tempat_pkl"],
    );

    Map<String, dynamic> toJson() => {
        "id_pengajuan": idPengajuan,
        "id_pembimbing": idPembimbing,
        "konfirmasi_nama_pembimbing": konfirmasiNamaPembimbing,
        "konfirmasi_nik_pembimbing": konfirmasiNikPembimbing,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id_tempat_pkl": idTempatPkl,
    };
}
