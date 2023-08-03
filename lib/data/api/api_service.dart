import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magang_app/data/models/biodata_industri_model.dart';
import 'package:magang_app/data/models/cancel_laporan_model.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:magang_app/data/models/data_pembimbing_pkl_model.dart';
import 'package:magang_app/data/models/detail_biodata_industri_model.dart';
import 'package:magang_app/data/models/detail_daftar_hadir_model.dart';
import 'package:magang_app/data/models/detail_jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/detail_nilai_model.dart';
import 'package:magang_app/data/models/ganti_password_model.dart';
import 'package:magang_app/data/models/hapus_biodata_industri.dart';
import 'package:magang_app/data/models/hapus_daftar_hadir_model.dart';
import 'package:magang_app/data/models/hapus_jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/isi_biodata_industri_model.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/konfirmasi_diterima_pkl_model.dart';
import 'package:magang_app/data/models/check_status_model.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/data/models/login_model.dart';
import 'package:magang_app/data/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:magang_app/data/models/logout_model.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';
import 'package:magang_app/data/models/nilai_pkl_model.dart';
import 'package:magang_app/data/models/pencarian_lowongan.dart';
import 'package:magang_app/data/models/pengajuan_pkl_model.dart';
import 'package:magang_app/data/models/profile_model.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';
import 'package:magang_app/data/models/tambah_daftar_hadir_model.dart';
import 'package:magang_app/data/models/tambah_jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/update_profile_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:magang_app/data/models/upload_laporan_model.dart';

class ApiService {
  static const String base_url = "https://backend-pkl-app.serveo.net/api";
  final storage = const FlutterSecureStorage();

  Future<Map<String, String>> getHeaders() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Connection": "Keep-Alive",
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

  Future<CheckStatus> getCheckStatus() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(Uri.parse('$base_url/mahasiswa/status'),
        headers: headers);
    if (response.statusCode == 200) {
      return CheckStatus.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get status mahasiswa: Response status code ${response.statusCode}");
    }
  }

  Future<void> savePlayerId(String notificationId,) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/mahasiswa/save-player-id?_method=PUT'),
      headers: headers,
      body: jsonEncode({
        'notification_id': notificationId,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to save player id: Response status code ${response.statusCode}');
    }
  }

  Future<LowonganPkl> getLowonganPkl() async {
    Map<String, String> headers = await getHeaders();
    final response = await http
        .get(Uri.parse('$base_url/lowongan-pkl/mahasiswa'), headers: headers);
    if (response.statusCode == 200) {
      return LowonganPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get lowongan: Response status code ${response.statusCode}");
    }
  }

  Future<PencarianLowongan> getPencarianLowongan(String keyword) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/lowongan-pkl/mahasiswa/search?q=$keyword'),
        headers: headers);
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
    final response = await http.get(
        Uri.parse('$base_url/pengajuan-pkl/mahasiswa/status'),
        headers: headers);
    if (response.statusCode == 200) {
      return StatusPengajuanPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get status: Response status code ${response.statusCode}");
    }
  }

  Future<PengajuanPkl> ajukanTempatPKL(
      String namaPerusahaan,
      String alamatPerusahaan,
      String tanggalMulai,
      String tanggalSelesai) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/pengajuan-pkl/mahasiswa'),
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

  Future<KonfirmasiDiterimaPkl> konfirmasiDiterimaPkl(
      String idPengajuan, String idPembimbing) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/tempat-pkl/mahasiswa'),
      headers: headers,
      body: jsonEncode({
        'id_pengajuan': idPengajuan,
        'id_pembimbing': idPembimbing,
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

  Future<DataPembimbingPkl> getDataPembimbingPkl() async {
    final response =
        await http.get(Uri.parse('$base_url/pembimbing/list-pembimbing'));
    if (response.statusCode == 200) {
      return DataPembimbingPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get data pembimbing PKL: Response status code ${response.statusCode}");
    }
  }

  Future<BiodataIndustri> getBiodataIndustri() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/biodata-industri/mahasiswa/detail'),
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
    String jumlahTenagaKerjaSmea,
    String jumlahTenagaKerjaSmkk,
    String jumlahTenagaKerjaSarjanaMuda,
    String jumlahTenagaKerjaSarjanaMagister,
    String jumlahTenagaKerjaSarjanaDoktor,
  ) async {
    Map<String, String> headers = await getHeaders();
    final response =
        await http.post(Uri.parse('$base_url/biodata-industri/mahasiswa'),
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
              'jumlah_tenaga_kerja_smea': jumlahTenagaKerjaSmea,
              'jumlah_tenaga_kerja_smkk': jumlahTenagaKerjaSmkk,
              'jumlah_tenaga_kerja_sarjana_muda': jumlahTenagaKerjaSarjanaMuda,
              'jumlah_tenaga_kerja_sarjana_magister':
                  jumlahTenagaKerjaSarjanaMagister,
              'jumlah_tenaga_kerja_sarjana_doktor':
                  jumlahTenagaKerjaSarjanaDoktor,
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
        Uri.parse('$base_url/jurnal-kegiatan/mahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return JurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }

  Future<HapusBiodataIndustri> deleteBiodataIndustri() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.delete(
      Uri.parse('$base_url/biodata-industri/mahasiswa'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return HapusBiodataIndustri.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to delete biodata industri: Response status code ${response.statusCode}");
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
      Uri.parse('$base_url/jurnal-kegiatan/mahasiswa'),
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
      Uri.parse(
          '$base_url/jurnal-kegiatan/mahasiswa/$idJurnalKegiatan?_method=PUT'),
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

  Future<HapusJurnalKegiatan> deleteJurnalKegiatan(
    String idJurnalKegiatan,
  ) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.delete(
      Uri.parse('$base_url/jurnal-kegiatan/mahasiswa/$idJurnalKegiatan'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return HapusJurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to delete jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }

  Future<NilaiPkl> getNilaiPkl() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(Uri.parse('$base_url/penilaian/mahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return NilaiPkl.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get nilai pkl: Response status code ${response.statusCode}");
    }
  }

  Future<DaftarHadir> getDaftarHadir() async {
    Map<String, String> headers = await getHeaders();
    final response = await http
        .get(Uri.parse('$base_url/daftar-hadir/mahasiswa'), headers: headers);
    if (response.statusCode == 200) {
      return DaftarHadir.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get daftar hadir: Response status code ${response.statusCode}");
    }
  }

  Future<TambahDaftarHadir> addDaftarHadir(
    String hariTanggal,
    String minggu,
    File tandaTanganFile,
  ) async {
    Map<String, String> headers = await getHeaders();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$base_url/daftar-hadir/mahasiswa'),
    );
    request.headers.addAll(headers);
    request.fields['hari_tanggal'] = hariTanggal;
    request.fields['minggu'] = minggu;
    request.files.add(http.MultipartFile(
      'tanda_tangan',
      tandaTanganFile.readAsBytes().asStream(),
      tandaTanganFile.lengthSync(),
      filename: tandaTanganFile.path.split('/').last,
      contentType: MediaType.parse('image/png'),
    ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      return TambahDaftarHadir.fromJson(json.decode(responseString));
    } else {
      throw Exception(
          "Failed to post daftar hadir: Response status code ${response.statusCode}");
    }
  }

  Future<TambahDaftarHadir> updateDaftarHadir(
    String idDaftarHadir,
    String hariTanggal,
    String minggu,
    File tandaTanganFile,
  ) async {
    Map<String, String> headers = await getHeaders();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$base_url/daftar-hadir/mahasiswa/$idDaftarHadir?_method=PUT'),
    );
    request.headers.addAll(headers);
    request.fields['hari_tanggal'] = hariTanggal;
    request.fields['minggu'] = minggu;
    request.files.add(http.MultipartFile(
      'tanda_tangan',
      tandaTanganFile.readAsBytes().asStream(),
      tandaTanganFile.lengthSync(),
      filename: tandaTanganFile.path.split('/').last,
      contentType: MediaType.parse('image/png'),
    ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      return TambahDaftarHadir.fromJson(json.decode(responseString));
    } else {
      throw Exception(
          "Failed to update daftar hadir: Response status code ${response.statusCode}");
    }
  }

  Future<HapusDaftarHadir> deleteDaftarHadir(String idDaftarHadir) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.delete(
      Uri.parse('$base_url/daftar-hadir/mahasiswa/$idDaftarHadir'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return HapusDaftarHadir.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to delete daftar hadir: Response status code ${response.statusCode}");
    }
  }

  Future<UploadLaporan> uploadLaporan(
    File file,
  ) async {
    Map<String, String> headers = await getHeaders();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$base_url/laporan/mahasiswa/upload'),
    );
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
      contentType: MediaType('application', 'octet-stream'),
    ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      return UploadLaporan.fromJson(json.decode(responseString));
    } else {
      throw Exception(
          "Failed to upload: Response status code ${response.statusCode}");
    }
  }

  Future<UploadLaporan> getLaporan() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(Uri.parse('$base_url/laporan/mahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return UploadLaporan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get Laporan: Response status code ${response.statusCode}");
    }
  }

  Future<CancelLaporan> cancelLaporan(String idLaporan) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.delete(
      Uri.parse('$base_url/laporan/mahasiswa/$idLaporan'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return CancelLaporan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to delete laporan: Response status code ${response.statusCode}");
    }
  }

  Future<Login> loginPembimbing(String username, String password) async {
    final response = await http.post(
      Uri.parse('$base_url/pembimbing/login'),
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

  Future<Register> registerPembimbing(
      String nama, String nik, String username, String password) async {
    final response = await http.post(
      Uri.parse('$base_url/pembimbing/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'nik': nik,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return Register.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to Register: Response status code ${response.statusCode}');
    }
  }

  Future<Logout> logoutPembimbing() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(Uri.parse('$base_url/pembimbing/logout'),
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

  Future<ListMahasiswa> getListNilaiPkl() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/penilaian-pembimbing/pembimbing'),
        headers: headers);
    if (response.statusCode == 200) {
      return ListMahasiswa.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get nilai pkl: Response status code ${response.statusCode}");
    }
  }

  Future<DetailNilai> getDetailNilaiPkl(String idMahasiswa) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/penilaian-pembimbing/pembimbing/$idMahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailNilai.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get detail nilai pkl: Response status code ${response.statusCode}");
    }
  }

  Future<void> penilaianPembimbing(
      int idMahasiswa,
      int idTempatPkl,
      String integritas,
      String profesionalitas,
      String bahasaInggris,
      String teknologiInformasi,
      String komunikasi,
      String kerjaSama,
      String organisasi) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$base_url/penilaian-pembimbing/pembimbing'),
      headers: headers,
      body: jsonEncode({
        'id_mahasiswa': idMahasiswa,
        'id_tempat_pkl': idTempatPkl,
        'integritas': integritas,
        'profesionalitas': profesionalitas,
        'bahasa_inggris': bahasaInggris,
        'teknologi_informasi': teknologiInformasi,
        'komunikasi': komunikasi,
        'kerja_sama': kerjaSama,
        'organisasi': organisasi,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          "Failed to post penilaian: Response status code ${response.statusCode}");
    }
  }

  Future<ListMahasiswa> getListMahasiswa() async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/mahasiswa/list/pembimbing'),
        headers: headers);
    if (response.statusCode == 200) {
      return ListMahasiswa.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return ListMahasiswa.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get list mahasiswa: Response status code ${response.statusCode}");
    }
  }

  Future<DetailBiodataIndustri> getDetailBiodataIndustri(String idMahasiswa) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/biodata-industri/pembimbing/$idMahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailBiodataIndustri.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get detail biodata industri: Response status code ${response.statusCode}");
    }
  }

  Future<DetailJurnalKegiatan> getDetailJurnalKegiatan(String idMahasiswa) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/jurnal-kegiatan/pembimbing/$idMahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailJurnalKegiatan.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get detail jurnal kegiatan: Response status code ${response.statusCode}");
    }
  }

  Future<DetailDaftarHadir> getDetailDaftarHadir(String idMahasiswa) async {
    Map<String, String> headers = await getHeaders();
    final response = await http.get(
        Uri.parse('$base_url/daftar-hadir/pembimbing/$idMahasiswa'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailDaftarHadir.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to get detail Daftar Hadir: Response status code ${response.statusCode}");
    }
  }
}
