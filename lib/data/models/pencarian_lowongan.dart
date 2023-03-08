// To parse this JSON data, do
//
//     final pencarianLowongan = pencarianLowonganFromJson(jsonString);

import 'dart:convert';

PencarianLowongan pencarianLowonganFromJson(String str) => PencarianLowongan.fromJson(json.decode(str));

String pencarianLowonganToJson(PencarianLowongan data) => json.encode(data.toJson());

class PencarianLowongan {
    PencarianLowongan({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    List<Lowongan> data;

    factory PencarianLowongan.fromJson(Map<String, dynamic> json) => PencarianLowongan(
        status: json["status"],
        message: json["message"],
        data: List<Lowongan>.from(json["data"].map((x) => Lowongan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Lowongan {
    Lowongan({
        required this.idLowongan,
        required this.idProdi,
        required this.posisi,
        required this.namaPerusahaan,
        required this.alamatPerusahaan,
        required this.gambar,
        this.url,
    });

    int idLowongan;
    int idProdi;
    String posisi;
    String namaPerusahaan;
    String alamatPerusahaan;
    String gambar;
    dynamic url;

    factory Lowongan.fromJson(Map<String, dynamic> json) => Lowongan(
        idLowongan: json["id_lowongan"],
        idProdi: json["id_prodi"],
        posisi: json["posisi"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatPerusahaan: json["alamat_perusahaan"],
        gambar: json["gambar"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id_lowongan": idLowongan,
        "id_prodi": idProdi,
        "posisi": posisi,
        "nama_perusahaan": namaPerusahaan,
        "alamat_perusahaan": alamatPerusahaan,
        "gambar": gambar,
        "url": url,
    };
}
