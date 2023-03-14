// To parse this JSON data, do
//
//     final tambahDaftarHadir = tambahDaftarHadirFromJson(jsonString);

import 'dart:convert';

TambahDaftarHadir tambahDaftarHadirFromJson(String str) => TambahDaftarHadir.fromJson(json.decode(str));

String tambahDaftarHadirToJson(TambahDaftarHadir data) => json.encode(data.toJson());

class TambahDaftarHadir {
    TambahDaftarHadir({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory TambahDaftarHadir.fromJson(Map<String, dynamic> json) => TambahDaftarHadir(
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
        required this.idDaftarHadir,
        required this.idMahasiswa,
        required this.hariTanggal,
        required this.minggu,
        required this.tandaTangan,
    });

    int idDaftarHadir;
    int idMahasiswa;
    DateTime hariTanggal;
    String minggu;
    String tandaTangan;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDaftarHadir: json["id_daftar_hadir"],
        idMahasiswa: json["id_mahasiswa"],
        hariTanggal: DateTime.parse(json["hari_tanggal"]),
        minggu: json["minggu"],
        tandaTangan: json["tanda_tangan"],
    );

    Map<String, dynamic> toJson() => {
        "id_daftar_hadir": idDaftarHadir,
        "id_mahasiswa": idMahasiswa,
        "hari_tanggal": "${hariTanggal.year.toString().padLeft(4, '0')}-${hariTanggal.month.toString().padLeft(2, '0')}-${hariTanggal.day.toString().padLeft(2, '0')}",
        "minggu": minggu,
        "tanda_tangan": tandaTangan,
    };
}
