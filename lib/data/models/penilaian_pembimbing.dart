// To parse this JSON data, do
//
//     final penilaianPembimbing = penilaianPembimbingFromJson(jsonString);

import 'dart:convert';

PenilaianPembimbing penilaianPembimbingFromJson(String str) => PenilaianPembimbing.fromJson(json.decode(str));

String penilaianPembimbingToJson(PenilaianPembimbing data) => json.encode(data.toJson());

class PenilaianPembimbing {
    PenilaianPembimbing({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory PenilaianPembimbing.fromJson(Map<String, dynamic> json) => PenilaianPembimbing(
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
        required this.idPenilaianPembimbing,
        required this.idMahasiswa,
        required this.integritas,
        required this.profesionalitas,
        required this.bahasaInggris,
        required this.teknologiInformasi,
        required this.komunikasi,
        required this.kerjaSama,
        required this.organisasi,
        required this.totalNilai,
        required this.createdAt,
        required this.updatedAt,
    });

    int idPenilaianPembimbing;
    int idMahasiswa;
    String integritas;
    String profesionalitas;
    String bahasaInggris;
    String teknologiInformasi;
    String komunikasi;
    String kerjaSama;
    String organisasi;
    String totalNilai;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPenilaianPembimbing: json["id_penilaian_pembimbing"],
        idMahasiswa: json["id_mahasiswa"],
        integritas: json["integritas"],
        profesionalitas: json["profesionalitas"],
        bahasaInggris: json["bahasa_inggris"],
        teknologiInformasi: json["teknologi_informasi"],
        komunikasi: json["komunikasi"],
        kerjaSama: json["kerja_sama"],
        organisasi: json["organisasi"],
        totalNilai: json["total_nilai"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_penilaian_pembimbing": idPenilaianPembimbing,
        "id_mahasiswa": idMahasiswa,
        "integritas": integritas,
        "profesionalitas": profesionalitas,
        "bahasa_inggris": bahasaInggris,
        "teknologi_informasi": teknologiInformasi,
        "komunikasi": komunikasi,
        "kerja_sama": kerjaSama,
        "organisasi": organisasi,
        "total_nilai": totalNilai,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
