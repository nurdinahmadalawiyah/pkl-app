// To parse this JSON data, do
//
//     final cancelLaporan = cancelLaporanFromJson(jsonString);

import 'dart:convert';

CancelLaporan cancelLaporanFromJson(String str) => CancelLaporan.fromJson(json.decode(str));

String cancelLaporanToJson(CancelLaporan data) => json.encode(data.toJson());

class CancelLaporan {
    String message;
    Data data;

    CancelLaporan({
        required this.message,
        required this.data,
    });

    factory CancelLaporan.fromJson(Map<String, dynamic> json) => CancelLaporan(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int idLaporan;
    int idMahasiswa;
    String file;
    DateTime tanggalUpload;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.idLaporan,
        required this.idMahasiswa,
        required this.file,
        required this.tanggalUpload,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idLaporan: json["id_laporan"],
        idMahasiswa: json["id_mahasiswa"],
        file: json["file"],
        tanggalUpload: DateTime.parse(json["tanggal_upload"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_laporan": idLaporan,
        "id_mahasiswa": idMahasiswa,
        "file": file,
        "tanggal_upload": "${tanggalUpload.year.toString().padLeft(4, '0')}-${tanggalUpload.month.toString().padLeft(2, '0')}-${tanggalUpload.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
