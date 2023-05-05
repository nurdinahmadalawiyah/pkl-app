// To parse this JSON data, do
//
//     final daftarHadir = daftarHadirFromJson(jsonString);

import 'dart:convert';

DaftarHadir daftarHadirFromJson(String str) => DaftarHadir.fromJson(json.decode(str));

String daftarHadirToJson(DaftarHadir data) => json.encode(data.toJson());

class DaftarHadir {
    String status;
    String message;
    String pdfUrl;
    List<ListDaftarHadir> data;

    DaftarHadir({
        required this.status,
        required this.message,
        required this.pdfUrl,
        required this.data,
    });

    factory DaftarHadir.fromJson(Map<String, dynamic> json) => DaftarHadir(
        status: json["status"],
        message: json["message"],
        pdfUrl: json["pdf_url"],
        data: List<ListDaftarHadir>.from(json["data"].map((x) => ListDaftarHadir.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pdf_url": pdfUrl,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ListDaftarHadir {
    int minggu;
    List<DataKehadiran> dataKehadiran;

    ListDaftarHadir({
        required this.minggu,
        required this.dataKehadiran,
    });

    factory ListDaftarHadir.fromJson(Map<String, dynamic> json) => ListDaftarHadir(
        minggu: json["minggu"],
        dataKehadiran: List<DataKehadiran>.from(json["data_kehadiran"].map((x) => DataKehadiran.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "minggu": minggu,
        "data_kehadiran": List<dynamic>.from(dataKehadiran.map((x) => x.toJson())),
    };
}

class DataKehadiran {
    int idDaftarHadir;
    int idMahasiswa;
    DateTime hariTanggal;
    int minggu;
    String tandaTangan;

    DataKehadiran({
        required this.idDaftarHadir,
        required this.idMahasiswa,
        required this.hariTanggal,
        required this.minggu,
        required this.tandaTangan,
    });

    factory DataKehadiran.fromJson(Map<String, dynamic> json) => DataKehadiran(
        idDaftarHadir: json["id_daftar_hadir"],
        idMahasiswa: json["id_mahasiswa"],
        hariTanggal: DateTime.parse(json["hari_tanggal"]),
        minggu: json["minggu"],
        tandaTangan: json["tanda-tangan"],
    );

    Map<String, dynamic> toJson() => {
        "id_daftar_hadir": idDaftarHadir,
        "id_mahasiswa": idMahasiswa,
        "hari_tanggal": "${hariTanggal.year.toString().padLeft(4, '0')}-${hariTanggal.month.toString().padLeft(2, '0')}-${hariTanggal.day.toString().padLeft(2, '0')}",
        "minggu": minggu,
        "tanda-tangan": tandaTangan,
    };
}
