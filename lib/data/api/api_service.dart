import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magang_app/data/models/biodata_industri_model.dart';
import 'package:magang_app/data/models/ganti_password_model.dart';
import 'package:magang_app/data/models/isi_biodata_industri_model.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/konfirmasi_diterima_pkl_model.dart';
import 'package:magang_app/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:magang_app/data/models/logout_model.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';
import 'package:magang_app/data/models/pencarian_lowongan.dart';
import 'package:magang_app/data/models/pengajuan_pkl_model.dart';
import 'package:magang_app/data/models/profile_model.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';
import 'package:magang_app/data/models/tambah_jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/update_profile_model.dart';

class ApiService {
  static const String base_url = "http://10.0.2.2:8000/api";
  final storage = const FlutterSecureStorage();

  Future<Map<String, String>> getHeaders() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      throw Exception('Token not found in storage');
    }
  }

  Future<Login> loginMahasiswa(String username, String password) async {
    final response = await http.post(
      Uri.parse('$base_url/mahasiswa/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Login login = Login.fromJson(data);
      login.accessToken = data['access_token'];
      login.message = data['message'];
      return login;
    } else {
      throw Exception(
          'Failed to login: Response status code ${response.statusCode}');
    }
  }

  Future<Logout> logoutMahasiswa() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(Uri.parse('$base_url/mahasiswa/logout'),
        headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Logout logout = Logout.fromJson(data);
      logout.message = data['message'];
      return logout;
    } else {
      throw Exception(
          'Failed to logout: Response status code ${response.statusCode}');
    }
  }

  Future<LowonganPkl> getLowonganPkl() async {
    Map<String, String> headers = await getHeaders();
    final response =
        await http.get(Uri.parse('$base_url/lowongan-pkl'), headers: headers);
    if (response.statusCode == 200) {
      return LowonganPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get lowongan: Response status code ${response.statusCode}");
    }
  }

  Future<PencarianLowongan> getPencarianLowongan(String keyword) async {
    Map<String, String> headers = await getHeaders();
    final response = await http
        .get(Uri.parse('$base_url/lowongan-pkl/search?q='), headers: headers);
    if (response.statusCode == 200) {
      return PencarianLowongan.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load search lowongan");
    }
  }

  Future<Profile> getProfile() async {
    Map<String, String> headers = await getHeaders();
    final response =
        await http.get(Uri.parse('$base_url/mahasiswa/me'), headers: headers);
    if (response.statusCode == 200) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to load profile: Response status code ${response.statusCode}");
    }
  }

  Future<GantiPassword> updatePassword(
      String passwordLama, String passwordBaru) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/mahasiswa/update-password?_method=PUT'),
      headers: headers,
      body: jsonEncode({
        'password_lama': passwordLama,
        'password_baru': passwordBaru,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      GantiPassword gantiPassword = GantiPassword.fromJson(data);
      gantiPassword.message = data['message'];
      return gantiPassword;
    } else {
      throw Exception(
          'Failed to Update Password: Response status code ${response.statusCode}');
    }
  }

  Future<UpdateProfile> updateProfile(
      String email, String username, String semester, String nomorHp) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/mahasiswa/update-profile?_method=PUT'),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'username': username,
        'semester': semester,
        'nomor_hp': nomorHp,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      UpdateProfile updateProfile = UpdateProfile.fromJson(data);
      updateProfile.message = data['message'];
      updateProfile.data.email = data['email'];
      updateProfile.data.username = data['username'];
      updateProfile.data.semester = data['semester'];
      updateProfile.data.nomorHp = data['nomor_hp'];
      return updateProfile;
    } else {
      throw Exception(
          'Failed to update profile: Response status code ${response.statusCode}');
    }
  }

  Future<StatusPengajuanPkl> getStatusPengajuan() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(Uri.parse('$base_url/pengajuan-pkl/status'),
        headers: headers);
    if (response.statusCode == 200) {
      return StatusPengajuanPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get lowongan: Response status code ${response.statusCode}");
    }
  }

  Future<PengajuanPkl> ajukanTempatPKL(
      String namaPerusahaan,
      String alamatPerusahaan,
      String tanggalMulai,
      String tanggalSelesai) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/pengajuan-pkl'),
      headers: headers,
      body: jsonEncode({
        'nama_perusahaan': namaPerusahaan,
        'alamat_perusahaan': alamatPerusahaan,
        'tanggal_mulai': tanggalMulai,
        'tanggal_selesai': tanggalSelesai
      }),
    );
    if (response.statusCode == 200) {
      return PengajuanPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get lowongan: Response status code ${response.statusCode}");
    }
  }

  Future<KonfirmasiDiterimaPkl> konfirmasiDiterimaPkl(String idPengajuan,
      String konfirmasiNamaPembimbing, String konfirmasiNikPembimbing) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/tempat-pkl'),
      headers: headers,
      body: jsonEncode({
        'id_pengajuan': idPengajuan,
        'konfirmasi_nama_pembimbing': konfirmasiNamaPembimbing,
        'konfirmasi_nik_pembimbing': konfirmasiNikPembimbing,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      KonfirmasiDiterimaPkl konfirmasiDiterimaPkl =
          KonfirmasiDiterimaPkl.fromJson(data);
      konfirmasiDiterimaPkl.message = data['message'];
      konfirmasiDiterimaPkl.data.idPengajuan = data['id_pengajuan'];
      konfirmasiDiterimaPkl.data.konfirmasiNamaPembimbing =
          data['konfirmasi_nama_pembimbing'];
      konfirmasiDiterimaPkl.data.konfirmasiNikPembimbing =
          data['konfirmasiNikPembimbing'];
      return konfirmasiDiterimaPkl;
    } else {
      throw Exception(
          'Failed to send confirmation data : Response status code ${response.statusCode}');
    }
  }

  Future<BiodataIndustri> getBiodataIndustri() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/biodata-industri/detail-user'),
        headers: headers);
    if (response.statusCode == 200) {
      return BiodataIndustri.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get biodata industri: Response status code ${response.statusCode}");
    }
  }

  Future<IsiBiodataIndustri> addBiodataIndustri(
    String namaIndustri,
    String namaPimpinan,
    String alamatKantor,
    String noTelpFax,
    String contactPerson,
    String bidangUsahaJasa,
    String spesialisasiProduksiJasa,
    String kapasitasProduksi,
    String jangkauanPemasaran,
    String jumlahTenagaKerjaSd,
    String jumlahTenagaKerjaSltp,
    String jumlahTenagaKerjaSlta,
    String jumlahTenagaKerjaSmk,
    String jumlahTenagaKerjaSarjanaMuda,
    String jumlahTenagaKerjaSarjanaMagister,
    String jumlahTenagaKerjaSarjanaDoktor,
  ) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(Uri.parse('$base_url/biodata-industri'),
        headers: headers,
        body: jsonEncode({
          'nama_industri': namaIndustri,
          'nama_pimpinan': namaPimpinan,
          'alamat_kantor': alamatKantor,
          'no_telp_fax': noTelpFax,
          'contact_person': contactPerson,
          'bidang_usaha_jasa': bidangUsahaJasa,
          'spesialisasi_produksi_jasa': spesialisasiProduksiJasa,
          'kapasitas_produksi': kapasitasProduksi,
          'jangkauan_pemasaran': jangkauanPemasaran,
          'jumlah_tenaga_kerja_sd': jumlahTenagaKerjaSd,
          'jumlah_tenaga_kerja_sltp': jumlahTenagaKerjaSltp,
          'jumlah_tenaga_kerja_slta': jumlahTenagaKerjaSlta,
          'jumlah_tenaga_kerja_smk': jumlahTenagaKerjaSmk,
          'jumlah_tenaga_kerja_sarjana_muda': jumlahTenagaKerjaSarjanaMuda,
          'jumlah_tenaga_kerja_sarjana_magister':
              jumlahTenagaKerjaSarjanaMagister,
          'jumlah_tenaga_kerja_sarjana_doktor': jumlahTenagaKerjaSarjanaDoktor,
        }));
    if (response.statusCode == 200) {
      return IsiBiodataIndustri.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to post biodata industri: Response status code ${response.statusCode}");
    }
  }

  Future<JurnalKegiatan> getJurnalKegiatan() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/jurnal-kegiatan/index-user'),
        headers: headers);
    if (response.statusCode == 200) {
      return JurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }

  Future<TambahJurnalKegiatan> addJurnalKegiatan(
    String tanggal,
    String minggu,
    String bidangPekerjaan,
    String keterangan,
  ) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/jurnal-kegiatan'),
      headers: headers,
      body: jsonEncode({
        'tanggal': tanggal,
        'minggu': minggu,
        'bidang_pekerjaan': bidangPekerjaan,
        'keterangan': keterangan,
      }),
    );
    if (response.statusCode == 200) {
      return TambahJurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to post jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }

  Future<TambahJurnalKegiatan> updateJurnalKegiatan(
    String idJurnalKegiatan,
    String tanggal,
    String minggu,
    String bidangPekerjaan,
    String keterangan,
  ) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/jurnal-kegiatan/4?_method=PUT'),
      headers: headers,
      body: jsonEncode({
        'tanggal': tanggal,
        'minggu': minggu,
        'bidang_pekerjaan': bidangPekerjaan,
        'keterangan': keterangan,
      }),
    );
    if (response.statusCode == 200) {
      return TambahJurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to update jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }
}
