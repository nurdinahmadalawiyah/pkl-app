// To parse this JSON data, do
//
//     final isiBiodataIndustri = isiBiodataIndustriFromJson(jsonString);

import 'dart:convert';

IsiBiodataIndustri isiBiodataIndustriFromJson(String str) => IsiBiodataIndustri.fromJson(json.decode(str));

String isiBiodataIndustriToJson(IsiBiodataIndustri data) => json.encode(data.toJson());

class IsiBiodataIndustri {
    IsiBiodataIndustri({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory IsiBiodataIndustri.fromJson(Map<String, dynamic> json) => IsiBiodataIndustri(
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
        required this.idBiodataIndustri,
        required this.idMahasiswa,
        required this.namaIndustri,
        required this.namaPimpinan,
        required this.alamatKantor,
        required this.noTelpFax,
        required this.contactPerson,
        required this.bidangUsahaJasa,
        required this.spesialisasiProduksiJasa,
        required this.kapasitasProduksi,
        required this.jangkauanPemasaran,
        required this.jumlahTenagaKerjaSd,
        required this.jumlahTenagaKerjaSltp,
        required this.jumlahTenagaKerjaSlta,
        required this.jumlahTenagaKerjaSmk,
        required this.jumlahTenagaKerjaSarjanaMuda,
        required this.jumlahTenagaKerjaSarjanaMagister,
        required this.jumlahTenagaKerjaSarjanaDoktor,
        required this.createdAt,
        required this.updatedAt,
    });

    int idBiodataIndustri;
    int idMahasiswa;
    String namaIndustri;
    String namaPimpinan;
    String alamatKantor;
    String noTelpFax;
    String contactPerson;
    String bidangUsahaJasa;
    String spesialisasiProduksiJasa;
    String kapasitasProduksi;
    String jangkauanPemasaran;
    String jumlahTenagaKerjaSd;
    String jumlahTenagaKerjaSltp;
    String jumlahTenagaKerjaSlta;
    String jumlahTenagaKerjaSmk;
    String jumlahTenagaKerjaSarjanaMuda;
    String jumlahTenagaKerjaSarjanaMagister;
    String jumlahTenagaKerjaSarjanaDoktor;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idBiodataIndustri: json["id_biodata_industri"],
        idMahasiswa: json["id_mahasiswa"],
        namaIndustri: json["nama_industri"],
        namaPimpinan: json["nama_pimpinan"],
        alamatKantor: json["alamat_kantor"],
        noTelpFax: json["no_telp_fax"],
        contactPerson: json["contact_person"],
        bidangUsahaJasa: json["bidang_usaha_jasa"],
        spesialisasiProduksiJasa: json["spesialisasi_produksi_jasa"],
        kapasitasProduksi: json["kapasitas_produksi"],
        jangkauanPemasaran: json["jangkauan_pemasaran"],
        jumlahTenagaKerjaSd: json["jumlah_tenaga_kerja_sd"],
        jumlahTenagaKerjaSltp: json["jumlah_tenaga_kerja_sltp"],
        jumlahTenagaKerjaSlta: json["jumlah_tenaga_kerja_slta"],
        jumlahTenagaKerjaSmk: json["jumlah_tenaga_kerja_smk"],
        jumlahTenagaKerjaSarjanaMuda: json["jumlah_tenaga_kerja_sarjana_muda"],
        jumlahTenagaKerjaSarjanaMagister: json["jumlah_tenaga_kerja_sarjana_magister"],
        jumlahTenagaKerjaSarjanaDoktor: json["jumlah_tenaga_kerja_sarjana_doktor"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_biodata_industri": idBiodataIndustri,
        "id_mahasiswa": idMahasiswa,
        "nama_industri": namaIndustri,
        "nama_pimpinan": namaPimpinan,
        "alamat_kantor": alamatKantor,
        "no_telp_fax": noTelpFax,
        "contact_person": contactPerson,
        "bidang_usaha_jasa": bidangUsahaJasa,
        "spesialisasi_produksi_jasa": spesialisasiProduksiJasa,
        "kapasitas_produksi": kapasitasProduksi,
        "jangkauan_pemasaran": jangkauanPemasaran,
        "jumlah_tenaga_kerja_sd": jumlahTenagaKerjaSd,
        "jumlah_tenaga_kerja_sltp": jumlahTenagaKerjaSltp,
        "jumlah_tenaga_kerja_slta": jumlahTenagaKerjaSlta,
        "jumlah_tenaga_kerja_smk": jumlahTenagaKerjaSmk,
        "jumlah_tenaga_kerja_sarjana_muda": jumlahTenagaKerjaSarjanaMuda,
        "jumlah_tenaga_kerja_sarjana_magister": jumlahTenagaKerjaSarjanaMagister,
        "jumlah_tenaga_kerja_sarjana_doktor": jumlahTenagaKerjaSarjanaDoktor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
