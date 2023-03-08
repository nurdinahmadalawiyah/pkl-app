// To parse this JSON data, do
//
//     final pengajuanPkl = pengajuanPklFromJson(jsonString);

import 'dart:convert';

PengajuanPkl pengajuanPklFromJson(String str) => PengajuanPkl.fromJson(json.decode(str));

String pengajuanPklToJson(PengajuanPkl data) => json.encode(data.toJson());

class PengajuanPkl {
    PengajuanPkl({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory PengajuanPkl.fromJson(Map<String, dynamic> json) => PengajuanPkl(
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
        required this.namaPerusahaan,
        required this.alamatPerusahaan,
        required this.tanggalMulai,
        required this.tanggalSelesai,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.idPengajuan,
    });

    int idMahasiswa;
    String namaPerusahaan;
    String alamatPerusahaan;
    DateTime tanggalMulai;
    DateTime tanggalSelesai;
    String status;
    DateTime updatedAt;
    DateTime createdAt;
    int idPengajuan;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idMahasiswa: json["id_mahasiswa"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatPerusahaan: json["alamat_perusahaan"],
        tanggalMulai: DateTime.parse(json["tanggal_mulai"]),
        tanggalSelesai: DateTime.parse(json["tanggal_selesai"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        idPengajuan: json["id_pengajuan"],
    );

    Map<String, dynamic> toJson() => {
        "id_mahasiswa": idMahasiswa,
        "nama_perusahaan": namaPerusahaan,
        "alamat_perusahaan": alamatPerusahaan,
        "tanggal_mulai": tanggalMulai.toIso8601String(),
        "tanggal_selesai": tanggalSelesai.toIso8601String(),
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id_pengajuan": idPengajuan,
    };
}
