// To parse this JSON data, do
//
//     final statusPengajuanPkl = statusPengajuanPklFromJson(jsonString);

import 'dart:convert';

StatusPengajuanPkl statusPengajuanPklFromJson(String str) => StatusPengajuanPkl.fromJson(json.decode(str));

String statusPengajuanPklToJson(StatusPengajuanPkl data) => json.encode(data.toJson());

class StatusPengajuanPkl {
    StatusPengajuanPkl({
        required this.status,
        required this.message,
        required this.user,
        required this.data,
    });

    String status;
    String message;
    User user;
    List<LitsStatus> data;

    factory StatusPengajuanPkl.fromJson(Map<String, dynamic> json) => StatusPengajuanPkl(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        data: List<LitsStatus>.from(json["data"].map((x) => LitsStatus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class LitsStatus {
    LitsStatus({
        required this.idPengajuan,
        required this.idMahasiswa,
        required this.namaPerusahaan,
        required this.alamatPerusahaan,
        required this.tanggalMulai,
        required this.tanggalSelesai,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int idPengajuan;
    int idMahasiswa;
    String namaPerusahaan;
    String alamatPerusahaan;
    DateTime tanggalMulai;
    DateTime tanggalSelesai;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    factory LitsStatus.fromJson(Map<String, dynamic> json) => LitsStatus(
        idPengajuan: json["id_pengajuan"],
        idMahasiswa: json["id_mahasiswa"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatPerusahaan: json["alamat_perusahaan"],
        tanggalMulai: DateTime.parse(json["tanggal_mulai"]),
        tanggalSelesai: DateTime.parse(json["tanggal_selesai"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_pengajuan": idPengajuan,
        "id_mahasiswa": idMahasiswa,
        "nama_perusahaan": namaPerusahaan,
        "alamat_perusahaan": alamatPerusahaan,
        "tanggal_mulai": "${tanggalMulai.year.toString().padLeft(4, '0')}-${tanggalMulai.month.toString().padLeft(2, '0')}-${tanggalMulai.day.toString().padLeft(2, '0')}",
        "tanggal_selesai": "${tanggalSelesai.year.toString().padLeft(4, '0')}-${tanggalSelesai.month.toString().padLeft(2, '0')}-${tanggalSelesai.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class User {
    User({
        required this.nama,
        required this.namaProdi,
        required this.nim,
    });

    String nama;
    String namaProdi;
    String nim;

    factory User.fromJson(Map<String, dynamic> json) => User(
        nama: json["nama"],
        namaProdi: json["nama_prodi"],
        nim: json["nim"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "nama_prodi": namaProdi,
        "nim": nim,
    };
}
