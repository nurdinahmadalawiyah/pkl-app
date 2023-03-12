// To parse this JSON data, do
//
//     final tambahJurnalKegiatan = tambahJurnalKegiatanFromJson(jsonString);

import 'dart:convert';

TambahJurnalKegiatan tambahJurnalKegiatanFromJson(String str) => TambahJurnalKegiatan.fromJson(json.decode(str));

String tambahJurnalKegiatanToJson(TambahJurnalKegiatan data) => json.encode(data.toJson());

class TambahJurnalKegiatan {
    TambahJurnalKegiatan({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory TambahJurnalKegiatan.fromJson(Map<String, dynamic> json) => TambahJurnalKegiatan(
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
        required this.idMahasiswa,
        required this.tanggal,
        required this.minggu,
        required this.bidangPekerjaan,
        required this.keterangan,
        required this.updatedAt,
        required this.createdAt,
        required this.idJurnalKegiatan,
    });

    int idMahasiswa;
    DateTime tanggal;
    String minggu;
    String bidangPekerjaan;
    String keterangan;
    DateTime updatedAt;
    DateTime createdAt;
    int idJurnalKegiatan;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idMahasiswa: json["id_mahasiswa"],
        tanggal: DateTime.parse(json["tanggal"]),
        minggu: json["minggu"],
        bidangPekerjaan: json["bidang_pekerjaan"],
        keterangan: json["keterangan"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        idJurnalKegiatan: json["id_jurnal_kegiatan"],
    );

    Map<String, dynamic> toJson() => {
        "id_mahasiswa": idMahasiswa,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "minggu": minggu,
        "bidang_pekerjaan": bidangPekerjaan,
        "keterangan": keterangan,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id_jurnal_kegiatan": idJurnalKegiatan,
    };
}
