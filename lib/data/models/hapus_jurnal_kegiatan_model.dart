// To parse this JSON data, do
//
//     final hapusJurnalKegiatan = hapusJurnalKegiatanFromJson(jsonString);

import 'dart:convert';

HapusJurnalKegiatan hapusJurnalKegiatanFromJson(String str) => HapusJurnalKegiatan.fromJson(json.decode(str));

String hapusJurnalKegiatanToJson(HapusJurnalKegiatan data) => json.encode(data.toJson());

class HapusJurnalKegiatan {
    HapusJurnalKegiatan({
        required this.message,
        required this.data,
    });

    String message;
    Data data;

    factory HapusJurnalKegiatan.fromJson(Map<String, dynamic> json) => HapusJurnalKegiatan(
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
        required this.idJurnalKegiatan,
        required this.idMahasiswa,
        required this.tanggal,
        required this.minggu,
        required this.bidangPekerjaan,
        required this.keterangan,
        required this.createdAt,
        required this.updatedAt,
    });

    int idJurnalKegiatan;
    int idMahasiswa;
    DateTime tanggal;
    int minggu;
    String bidangPekerjaan;
    String keterangan;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idJurnalKegiatan: json["id_jurnal_kegiatan"],
        idMahasiswa: json["id_mahasiswa"],
        tanggal: DateTime.parse(json["tanggal"]),
        minggu: json["minggu"],
        bidangPekerjaan: json["bidang_pekerjaan"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_jurnal_kegiatan": idJurnalKegiatan,
        "id_mahasiswa": idMahasiswa,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "minggu": minggu,
        "bidang_pekerjaan": bidangPekerjaan,
        "keterangan": keterangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
