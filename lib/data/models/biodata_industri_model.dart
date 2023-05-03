// To parse this JSON data, do
//
//     final biodataIndustri = biodataIndustriFromJson(jsonString);

import 'dart:convert';

BiodataIndustri biodataIndustriFromJson(String str) => BiodataIndustri.fromJson(json.decode(str));

String biodataIndustriToJson(BiodataIndustri data) => json.encode(data.toJson());

class BiodataIndustri {
    String status;
    String message;
    String pdfUrl;
    Data data;

    BiodataIndustri({
        required this.status,
        required this.message,
        required this.pdfUrl,
        required this.data,
    });

    factory BiodataIndustri.fromJson(Map<String, dynamic> json) => BiodataIndustri(
        status: json["status"],
        message: json["message"],
        pdfUrl: json["pdf_url"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pdf_url": pdfUrl,
        "data": data.toJson(),
    };
}

class Data {
    int idBiodataIndustri;
    int idMahasiswa;
    int idTempatPkl;
    String namaIndustri;
    String namaPimpinan;
    String alamatKantor;
    String noTelpFax;
    String contactPerson;
    String bidangUsahaJasa;
    String spesialisasiProduksiJasa;
    String jangkauanPemasaran;
    int kapasitasProduksi;
    int jumlahTenagaKerjaSd;
    int jumlahTenagaKerjaSltp;
    int jumlahTenagaKerjaSlta;
    int jumlahTenagaKerjaSmk;
    int jumlahTenagaKerjaSarjanaMuda;
    int jumlahTenagaKerjaSarjanaMagister;
    int jumlahTenagaKerjaSarjanaDoktor;
    DateTime createdAt;
    DateTime updatedAt;
    String nama;
    String nim;
    String namaPembimbing;
    String nik;

    Data({
        required this.idBiodataIndustri,
        required this.idMahasiswa,
        required this.idTempatPkl,
        required this.namaIndustri,
        required this.namaPimpinan,
        required this.alamatKantor,
        required this.noTelpFax,
        required this.contactPerson,
        required this.bidangUsahaJasa,
        required this.spesialisasiProduksiJasa,
        required this.jangkauanPemasaran,
        required this.kapasitasProduksi,
        required this.jumlahTenagaKerjaSd,
        required this.jumlahTenagaKerjaSltp,
        required this.jumlahTenagaKerjaSlta,
        required this.jumlahTenagaKerjaSmk,
        required this.jumlahTenagaKerjaSarjanaMuda,
        required this.jumlahTenagaKerjaSarjanaMagister,
        required this.jumlahTenagaKerjaSarjanaDoktor,
        required this.createdAt,
        required this.updatedAt,
        required this.nama,
        required this.nim,
        required this.namaPembimbing,
        required this.nik,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idBiodataIndustri: json["id_biodata_industri"],
        idMahasiswa: json["id_mahasiswa"],
        idTempatPkl: json["id_tempat_pkl"],
        namaIndustri: json["nama_industri"],
        namaPimpinan: json["nama_pimpinan"],
        alamatKantor: json["alamat_kantor"],
        noTelpFax: json["no_telp_fax"],
        contactPerson: json["contact_person"],
        bidangUsahaJasa: json["bidang_usaha_jasa"],
        spesialisasiProduksiJasa: json["spesialisasi_produksi_jasa"],
        jangkauanPemasaran: json["jangkauan_pemasaran"],
        kapasitasProduksi: json["kapasitas_produksi"],
        jumlahTenagaKerjaSd: json["jumlah_tenaga_kerja_sd"],
        jumlahTenagaKerjaSltp: json["jumlah_tenaga_kerja_sltp"],
        jumlahTenagaKerjaSlta: json["jumlah_tenaga_kerja_slta"],
        jumlahTenagaKerjaSmk: json["jumlah_tenaga_kerja_smk"],
        jumlahTenagaKerjaSarjanaMuda: json["jumlah_tenaga_kerja_sarjana_muda"],
        jumlahTenagaKerjaSarjanaMagister: json["jumlah_tenaga_kerja_sarjana_magister"],
        jumlahTenagaKerjaSarjanaDoktor: json["jumlah_tenaga_kerja_sarjana_doktor"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nama: json["nama"],
        nim: json["nim"],
        namaPembimbing: json["nama_pembimbing"],
        nik: json["nik"],
    );

    Map<String, dynamic> toJson() => {
        "id_biodata_industri": idBiodataIndustri,
        "id_mahasiswa": idMahasiswa,
        "id_tempat_pkl": idTempatPkl,
        "nama_industri": namaIndustri,
        "nama_pimpinan": namaPimpinan,
        "alamat_kantor": alamatKantor,
        "no_telp_fax": noTelpFax,
        "contact_person": contactPerson,
        "bidang_usaha_jasa": bidangUsahaJasa,
        "spesialisasi_produksi_jasa": spesialisasiProduksiJasa,
        "jangkauan_pemasaran": jangkauanPemasaran,
        "kapasitas_produksi": kapasitasProduksi,
        "jumlah_tenaga_kerja_sd": jumlahTenagaKerjaSd,
        "jumlah_tenaga_kerja_sltp": jumlahTenagaKerjaSltp,
        "jumlah_tenaga_kerja_slta": jumlahTenagaKerjaSlta,
        "jumlah_tenaga_kerja_smk": jumlahTenagaKerjaSmk,
        "jumlah_tenaga_kerja_sarjana_muda": jumlahTenagaKerjaSarjanaMuda,
        "jumlah_tenaga_kerja_sarjana_magister": jumlahTenagaKerjaSarjanaMagister,
        "jumlah_tenaga_kerja_sarjana_doktor": jumlahTenagaKerjaSarjanaDoktor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama": nama,
        "nim": nim,
        "nama_pembimbing": namaPembimbing,
        "nik": nik,
    };
}
