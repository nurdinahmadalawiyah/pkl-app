// To parse this JSON data, do
//
//     final hapusDaftarHadir = hapusDaftarHadirFromJson(jsonString);

import 'dart:convert';

HapusDaftarHadir hapusDaftarHadirFromJson(String str) => HapusDaftarHadir.fromJson(json.decode(str));

String hapusDaftarHadirToJson(HapusDaftarHadir data) => json.encode(data.toJson());

class HapusDaftarHadir {
    HapusDaftarHadir({
        required this.message,
        required this.data,
    });

    String message;
    Data data;

    factory HapusDaftarHadir.fromJson(Map<String, dynamic> json) => HapusDaftarHadir(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.idDaftarHadir,
        required this.idMahasiswa,
        required this.hariTanggal,
        required this.minggu,
        required this.tandaTangan,
        required this.createdAt,
        required this.updatedAt,
    });

    int idDaftarHadir;
    int idMahasiswa;
    DateTime hariTanggal;
    int minggu;
    String tandaTangan;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDaftarHadir: json["id_daftar_hadir"],
        idMahasiswa: json["id_mahasiswa"],
        hariTanggal: DateTime.parse(json["hari_tanggal"]),
        minggu: json["minggu"],
        tandaTangan: json["tanda_tangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_daftar_hadir": idDaftarHadir,
        "id_mahasiswa": idMahasiswa,
        "hari_tanggal": "${hariTanggal.year.toString().padLeft(4, '0')}-${hariTanggal.month.toString().padLeft(2, '0')}-${hariTanggal.day.toString().padLeft(2, '0')}",
        "minggu": minggu,
        "tanda_tangan": tandaTangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
