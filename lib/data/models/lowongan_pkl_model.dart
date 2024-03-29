// To parse this JSON data, do
//
//     final lowonganPkl = lowonganPklFromJson(jsonString);

import 'dart:convert';

LowonganPkl lowonganPklFromJson(String str) => LowonganPkl.fromJson(json.decode(str));

String lowonganPklToJson(LowonganPkl data) => json.encode(data.toJson());

class LowonganPkl {
    LowonganPkl({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    List<Lowongan> data;

    factory LowonganPkl.fromJson(Map<String, dynamic> json) => LowonganPkl(
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
        required this.sumber
    });

    int idLowongan;
    int idProdi;
    String posisi;
    String namaPerusahaan;
    String alamatPerusahaan;
    String gambar;
    dynamic url;
    String sumber;

    factory Lowongan.fromJson(Map<String, dynamic> json) => Lowongan(
        idLowongan: json["id_lowongan"],
        idProdi: json["id_prodi"],
        posisi: json["posisi"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatPerusahaan: json["alamat_perusahaan"],
        gambar: json["gambar"],
        url: json["url"],
        sumber: json["sumber"],
    );

    Map<String, dynamic> toJson() => {
        "id_lowongan": idLowongan,
        "id_prodi": idProdi,
        "posisi": posisi,
        "nama_perusahaan": namaPerusahaan,
        "alamat_perusahaan": alamatPerusahaan,
        "gambar": gambar,
        "url": url,
        "sumber": sumber,
    };
}
