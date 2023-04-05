// To parse this JSON data, do
//
//     final listMahasiswa = listMahasiswaFromJson(jsonString);

import 'dart:convert';

ListMahasiswa listMahasiswaFromJson(String str) => ListMahasiswa.fromJson(json.decode(str));

String listMahasiswaToJson(ListMahasiswa data) => json.encode(data.toJson());

class ListMahasiswa {
    ListMahasiswa({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    List<Datum> data;

    factory ListMahasiswa.fromJson(Map<String, dynamic> json) => ListMahasiswa(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.idTempatPkl,
        required this.idMahasiswa,
        required this.namaMahasiswa,
        required this.namaProdi,
        required this.nim,
        required this.namaPembimbing,
        required this.nik,
    });

    int idTempatPkl;
    int idMahasiswa;
    String namaMahasiswa;
    String namaProdi;
    String nim;
    String namaPembimbing;
    String nik;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idTempatPkl: json["id_tempat_pkl"],
        idMahasiswa: json["id_mahasiswa"],
        namaMahasiswa: json["nama_mahasiswa"],
        namaProdi: json["nama_prodi"],
        nim: json["nim"],
        namaPembimbing: json["nama_pembimbing"],
        nik: json["nik"],
    );

    Map<String, dynamic> toJson() => {
        "id_tempat_pkl": idTempatPkl,
        "id_mahasiswa": idMahasiswa,
        "nama_mahasiswa": namaMahasiswa,
        "nama_prodi": namaProdi,
        "nim": nim,
        "nama_pembimbing": namaPembimbing,
        "nik": nik,
    };
}
