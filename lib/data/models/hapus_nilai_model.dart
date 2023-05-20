// To parse this JSON data, do
//
//     final hapusNilai = hapusNilaiFromJson(jsonString);

import 'dart:convert';

HapusNilai hapusNilaiFromJson(String str) => HapusNilai.fromJson(json.decode(str));

String hapusNilaiToJson(HapusNilai data) => json.encode(data.toJson());

class HapusNilai {
  String message;
  Data data;

  HapusNilai({
    required this.message,
    required this.data,
  });

  factory HapusNilai.fromJson(Map<String, dynamic> json) => HapusNilai(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int idPenilaianPembimbing;
  int idMahasiswa;
  int idTempatPkl;
  double integritas;
  double profesionalitas;
  double bahasaInggris;
  double teknologiInformasi;
  double komunikasi;
  double kerjaSama;
  double organisasi;
  double totalNilai;
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
    integritas: json["integritas"]?.toDouble(),
    profesionalitas: json["profesionalitas"]?.toDouble(),
    bahasaInggris: json["bahasa_inggris"]?.toDouble(),
    teknologiInformasi: json["teknologi_informasi"]?.toDouble(),
    komunikasi: json["komunikasi"]?.toDouble(),
    kerjaSama: json["kerja_sama"]?.toDouble(),
    organisasi: json["organisasi"]?.toDouble(),
    totalNilai: json["total_nilai"]?.toDouble(),
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
