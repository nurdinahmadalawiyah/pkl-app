// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/isi_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/edit_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/tambah_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/edit_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/tambah_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/pelaporan/upload_laporan_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/konfirmasi_diterima_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/lowongan_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/pengajuan_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/status_pengajuan_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/nilai_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/profile/edit_profile_cubit.dart';
import 'package:magang_app/presentation/cubit/profile/profile_cubit.dart';
import 'package:magang_app/presentation/pages/mahasiswa/ajukan_tempat_pkl_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/biodata_industri_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/daftar_hadir_detail_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/edit_daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/edit_jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/isi_biodata_industri_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/jurnal_kegiatan_detail_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/konfirmasi_diterima_pkl_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/lowongan_pkl_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/mahasiswa_dashboard_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/edit_profile_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/ganti_password_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/mahasiswa_login_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/nilai_pkl_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/profile_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/status_pengajuan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/pencarian_lowongan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/tambah_daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/tambah_jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/upload_laporan_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/pembimbing_dashboard_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/pembimbing_login_page.dart';
import 'package:magang_app/presentation/pages/splash_page.dart';
import 'package:magang_app/presentation/provider/auth_provider.dart';
import 'package:magang_app/presentation/provider/ganti_password_provider.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:magang_app/presentation/provider/pencarian_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PencarianProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GantiPasswordProvider(),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => LowonganPklCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => PengajuanPklCubit(),
        ),
        BlocProvider(
          create: (_) => StatusPengajuanCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => EditProfileCubit(),
        ),
        BlocProvider(
          create: (_) => KonfirmasiDiterimaPklCubit(),
        ),
        BlocProvider(
          create: (_) => BiodataIndustriCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => IsiBiodataIndustriCubit(),
        ),
        BlocProvider(
          create: (_) => JurnalKegiatanCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => TambahJurnalKegiatanCubit(),
        ),
        BlocProvider(
          create: (_) => EditJurnalKegiatanCubit(),
        ),
        BlocProvider(
          create: (_) => NilaiPklCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => DaftarHadirCubit(apiService: ApiService()),
        ),
        BlocProvider(
          create: (_) => TambahDaftarHadirCubit(),
        ),
        BlocProvider(
          create: (_) => EditDaftarHadirCubit(),
        ),
        BlocProvider(
          create: (_) => UploadLaporanCubit(),
        )
      ],
      child: MaterialApp(
        title: 'PKL App',
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
          primaryColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: kTextTheme,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/dashboard': (context) => const MahasiswaDashboardPage(),
          '/login-mahasiswa': (context) => const MahasiswaLoginPage(),
          '/lowongan-pkl': (context) => const LowonganPklPage(),
          '/login-pembimbing': (context) => const PembimbingLoginPage(),
          '/pencarian': (context) => const PencarianLowonganPage(),
          '/profile': (context) => const ProfilePage(),
          '/ganti-password': (context) => const GantiPasswordPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/status-pengajuan': (context) => const StatusPengajuanPage(),
          '/pengajuan-pkl': (context) => const AjukanTempatPklPage(),
          '/konfirmasi-pkl': (context) => const KonfirmasiDiterimaPklPage(),
          '/biodata-industri': (context) => const BiodataIndustriPage(),
          '/isi-biodata-industri': (context) => const IsiBiodataIndustriPage(),
          '/jurnal-kegiatan': (context) => const JurnalKegiatanPage(),
          '/jurnal-kegiatan-detail': (context) =>
              const JurnalKegiatanDetailPage(),
          '/tambah-jurnal-kegiatan': (context) =>
              const TambahJurnalKegiatanPage(),
          '/edit-jurnal-kegiatan': (context) => const EditJurnalKegiatanPage(),
          '/nilai-pkl': (context) => const NilaiPklPage(),
          '/daftar-hadir': (context) => const DaftarHadirPage(),
          '/daftar-hadir-detail': (context) => const DaftarHadirDetailPage(),
          '/tambah-daftar-hadir': (context) => const TambahDaftarHadirPage(),
          '/edit-daftar-hadir': (context) => const EditDaftarHadirPage(),
          '/upload-laporan': (context) => const UploadLaporanPage(),
          '/dashboard-pembimbing': (context) => const PembimbingDashboardPage(),
        },
      ),
    );
  }
}
