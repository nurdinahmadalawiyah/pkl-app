// To parse this JSON data, do
//
//     final detailNilai = detailNilaiFromJson(jsonString);

import 'dart:convert';

DetailNilai detailNilaiFromJson(String str) => DetailNilai.fromJson(json.decode(str));

String detailNilaiToJson(DetailNilai data) => json.encode(data.toJson());

class DetailNilai {
    String status;
    String message;
    Data data;

    DetailNilai({
        required this.status,
        required this.message,
        required this.data,
    });

    factory DetailNilai.fromJson(Map<String, dynamic> json) => DetailNilai(
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
    int idPenilaianPembimbing;
    int idMahasiswa;
    int idTempatPkl;
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

    Data({
        required this.idPenilaianPembimbing,
        required this.idMahasiswa,
        required this.idTempatPkl,
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPenilaianPembimbing: json["id_penilaian_pembimbing"],
        idMahasiswa: json["id_mahasiswa"],
        idTempatPkl: json["id_tempat_pkl"],
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
        "id_tempat_pkl": idTempatPkl,
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
