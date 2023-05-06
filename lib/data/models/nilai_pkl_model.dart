// To parse this JSON data, do
//
//     final nilaiPkl = nilaiPklFromJson(jsonString);

import 'dart:convert';

NilaiPkl nilaiPklFromJson(String str) => NilaiPkl.fromJson(json.decode(str));

String nilaiPklToJson(NilaiPkl data) => json.encode(data.toJson());

class NilaiPkl {
    NilaiPkl({
        required this.status,
        required this.message,
        required this.pdfUrl,
        required this.data,
    });

    String status;
    String message;
    String pdfUrl;
    Data data;

    factory NilaiPkl.fromJson(Map<String, dynamic> json) => NilaiPkl(
        status: json["status"],
        message: json["message"],
        pdfUrl: json["pdf_url"],
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
        required this.idMahasiswa,
        required this.nama,
        required this.namaProdi,
        required this.nim,
        required this.idPenilaianProdi,
        required this.idPenilaianPembimbing,
        required this.presentasi,
        required this.dokumen,
        required this.integritas,
        required this.profesionalitas,
        required this.bahasaInggris,
        required this.teknologiInformasi,
        required this.komunikasi,
        required this.kerjaSama,
        required this.organisasi,
        required this.nilaiAkhir,
        required this.nilaiHuruf,
    });

    int idMahasiswa;
    String nama;
    String namaProdi;
    String nim;
    int idPenilaianProdi;
    int idPenilaianPembimbing;
    double presentasi;
    double dokumen;
    double integritas;
    double profesionalitas;
    double bahasaInggris;
    double teknologiInformasi;
    double komunikasi;
    double kerjaSama;
    double organisasi;
    double nilaiAkhir;
    String nilaiHuruf;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idMahasiswa: json["id_mahasiswa"],
        nama: json["nama"],
        namaProdi: json["nama_prodi"],
        nim: json["nim"],
        idPenilaianProdi: json["id_penilaian_prodi"],
        idPenilaianPembimbing: json["id_penilaian_pembimbing"],
        presentasi: json["presentasi"]?.toDouble(),
        dokumen: json["dokumen"]?.toDouble(),
        integritas: json["integritas"]?.toDouble(),
        profesionalitas: json["profesionalitas"]?.toDouble(),
        bahasaInggris: json["bahasa_inggris"]?.toDouble(),
        teknologiInformasi: json["teknologi_informasi"]?.toDouble(),
        komunikasi: json["komunikasi"]?.toDouble(),
        kerjaSama: json["kerja_sama"]?.toDouble(),
        organisasi: json["organisasi"]?.toDouble(),
        nilaiAkhir: json["nilai_akhir"]?.toDouble(),
        nilaiHuruf: json["nilai_huruf"],
    );

    Map<String, dynamic> toJson() => {
        "id_mahasiswa": idMahasiswa,
        "nama": nama,
        "nama_prodi": namaProdi,
        "nim": nim,
        "id_penilaian_prodi": idPenilaianProdi,
        "id_penilaian_pembimbing": idPenilaianPembimbing,
        "presentasi": presentasi,
        "dokumen": dokumen,
        "integritas": integritas,
        "profesionalitas": profesionalitas,
        "bahasa_inggris": bahasaInggris,
        "teknologi_informasi": teknologiInformasi,
        "komunikasi": komunikasi,
        "kerja_sama": kerjaSama,
        "organisasi": organisasi,
        "nilai_akhir": nilaiAkhir,
        "nilai_huruf": nilaiHuruf,
    };
}
