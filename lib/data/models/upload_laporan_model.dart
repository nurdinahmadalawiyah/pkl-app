// To parse this JSON data, do
//
//     final uploadLaporan = uploadLaporanFromJson(jsonString);

import 'dart:convert';

UploadLaporan uploadLaporanFromJson(String str) => UploadLaporan.fromJson(json.decode(str));

String uploadLaporanToJson(UploadLaporan data) => json.encode(data.toJson());

class UploadLaporan {
    UploadLaporan({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory UploadLaporan.fromJson(Map<String, dynamic> json) => UploadLaporan(
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
        required this.idLaporan,
        required this.idMahasiswa,
        required this.file,
        required this.tanggalUpload,
    });

    int idLaporan;
    int idMahasiswa;
    String file;
    DateTime tanggalUpload;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idLaporan: json["id_laporan"],
        idMahasiswa: json["id_mahasiswa"],
        file: json["file"],
        tanggalUpload: DateTime.parse(json["tanggal_upload"]),
    );

    Map<String, dynamic> toJson() => {
        "id_laporan": idLaporan,
        "id_mahasiswa": idMahasiswa,
        "file": file,
        "tanggal_upload": tanggalUpload.toIso8601String(),
    };
}
