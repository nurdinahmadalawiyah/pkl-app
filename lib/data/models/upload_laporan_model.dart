// To parse this JSON data, do
//
//     final uploadLaporan = uploadLaporanFromJson(jsonString);

import 'dart:convert';

UploadLaporan uploadLaporanFromJson(String str) => UploadLaporan.fromJson(json.decode(str));

String uploadLaporanToJson(UploadLaporan data) => json.encode(data.toJson());

class UploadLaporan {
    String status;
    String message;
    Data data;

    UploadLaporan({
        required this.status,
        required this.message,
        required this.data,
    });

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
    int idLaporan;
    String nama;
    String nim;
    String file;
    DateTime tanggalUpload;

    Data({
        required this.idLaporan,
        required this.nama,
        required this.nim,
        required this.file,
        required this.tanggalUpload,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idLaporan: json["id_laporan"],
        nama: json["nama"],
        nim: json["nim"],
        file: json["file"],
        tanggalUpload: DateTime.parse(json["tanggal_upload"]),
    );

    Map<String, dynamic> toJson() => {
        "id_laporan": idLaporan,
        "nama": nama,
        "nim": nim,
        "file": file,
        "tanggal_upload": "${tanggalUpload.year.toString().padLeft(4, '0')}-${tanggalUpload.month.toString().padLeft(2, '0')}-${tanggalUpload.day.toString().padLeft(2, '0')}",
    };
}
