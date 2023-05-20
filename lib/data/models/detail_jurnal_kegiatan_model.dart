// To parse this JSON data, do
//
//     final detailJurnalKegiatan = detailJurnalKegiatanFromJson(jsonString);

import 'dart:convert';

DetailJurnalKegiatan detailJurnalKegiatanFromJson(String str) => DetailJurnalKegiatan.fromJson(json.decode(str));

String detailJurnalKegiatanToJson(DetailJurnalKegiatan data) => json.encode(data.toJson());

class DetailJurnalKegiatan {
  String status;
  String message;
  List<ListJurnalKegiatan> data;

  DetailJurnalKegiatan({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailJurnalKegiatan.fromJson(Map<String, dynamic> json) => DetailJurnalKegiatan(
    status: json["status"],
    message: json["message"],
    data: List<ListJurnalKegiatan>.from(json["data"].map((x) => ListJurnalKegiatan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ListJurnalKegiatan {
  int minggu;
  List<DataKegiatan> dataKegiatan;

  ListJurnalKegiatan({
    required this.minggu,
    required this.dataKegiatan,
  });

  factory ListJurnalKegiatan.fromJson(Map<String, dynamic> json) => ListJurnalKegiatan(
    minggu: json["minggu"],
    dataKegiatan: List<DataKegiatan>.from(json["data_kegiatan"].map((x) => DataKegiatan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "minggu": minggu,
    "data_kegiatan": List<dynamic>.from(dataKegiatan.map((x) => x.toJson())),
  };
}

class DataKegiatan {
  int idJurnalKegiatan;
  int idMahasiswa;
  DateTime tanggal;
  int minggu;
  String bidangPekerjaan;
  String keterangan;

  DataKegiatan({
    required this.idJurnalKegiatan,
    required this.idMahasiswa,
    required this.tanggal,
    required this.minggu,
    required this.bidangPekerjaan,
    required this.keterangan,
  });

  factory DataKegiatan.fromJson(Map<String, dynamic> json) => DataKegiatan(
    idJurnalKegiatan: json["id_jurnal_kegiatan"],
    idMahasiswa: json["id_mahasiswa"],
    tanggal: DateTime.parse(json["tanggal"]),
    minggu: json["minggu"],
    bidangPekerjaan: json["bidang_pekerjaan"],
    keterangan: json["keterangan"],
  );

  Map<String, dynamic> toJson() => {
    "id_jurnal_kegiatan": idJurnalKegiatan,
    "id_mahasiswa": idMahasiswa,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "minggu": minggu,
    "bidang_pekerjaan": bidangPekerjaan,
    "keterangan": keterangan,
  };
}
