import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/detail_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/isi_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/detail_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/hapus_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/tambah_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/detail_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/edit_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/tambah_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/cubit/dashboard/check_status_cubit.dart';
import 'package:magang_app/presentation/cubit/dashboard/list_mahasiswa_cubit.dart';
import 'package:magang_app/presentation/cubit/dashboard/save_player_id_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/detail_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/edit_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/tambah_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/pelaporan/upload_laporan_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/data_pembimbing_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/konfirmasi_diterima_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/lowongan_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/pengajuan_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/status_pengajuan_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/detail_nilai_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/list_nilai_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/nilai_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/penilaian_pembimbing_cubit.dart';
import 'package:magang_app/presentation/cubit/profile/edit_profile_cubit.dart';
import 'package:magang_app/presentation/cubit/profile/profile_cubit.dart';
import 'package:magang_app/presentation/pages/mahasiswa/ajukan_tempat_pkl_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/biodata_industri_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/catatan_khusus_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/daftar_hadir_detail_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/download_catatan_khusus_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/download_daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/donwload_jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/download_biodata_industri_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/download_surat_pengantar_pkl_page.dart';
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
import 'package:magang_app/presentation/pages/mahasiswa/tambah_catatan_khusus_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/tambah_daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/tambah_jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/mahasiswa/upload_laporan_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_biodata_industri_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_catatan_khusus_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_daftar_hadir_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_jurnal_kegiatan_2_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_jurnal_kegiatan_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/detail_kelola_nilai_pkl_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/edit_nilai_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/kelola_nilai_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/menu_mahasiswa_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/pembimbing_dashboard_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/pembimbing_login_page.dart';
import 'package:magang_app/presentation/pages/pembimbing/pembimbing_register_page.dart';
import 'package:magang_app/presentation/pages/splash_page.dart';
import 'package:magang_app/presentation/provider/auth_provider.dart';
import 'package:magang_app/presentation/provider/ganti_password_provider.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:magang_app/presentation/provider/pencarian_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/mahasiswa/download_lembar_penilaian_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f8bc8286-9b49-4347-995c-1885262c4dc3");
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
        BlocProvider(create: (_) => CheckStatusCubit(apiService: ApiService())),
        BlocProvider(create: (_) => SavePlayerIdCubit()),
        BlocProvider(create: (_) => ProfileCubit(apiService: ApiService())),
        BlocProvider(create: (_) => LowonganPklCubit(apiService: ApiService())),
        BlocProvider(create: (_) => PengajuanPklCubit()),
        BlocProvider(create: (_) => StatusPengajuanCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DataPembimbingPklCubit(apiService: ApiService())),
        BlocProvider(create: (_) => EditProfileCubit()),
        BlocProvider(create: (_) => KonfirmasiDiterimaPklCubit()),
        BlocProvider(create: (_) => BiodataIndustriCubit(apiService: ApiService())),
        BlocProvider(create: (_) => IsiBiodataIndustriCubit()),
        BlocProvider(create: (_) => JurnalKegiatanCubit(apiService: ApiService())),
        BlocProvider(create: (_) => TambahJurnalKegiatanCubit()),
        BlocProvider(create: (_) => EditJurnalKegiatanCubit()),
        BlocProvider(create: (_) => NilaiPklCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DaftarHadirCubit(apiService: ApiService())),
        BlocProvider(create: (_) => TambahDaftarHadirCubit()),
        BlocProvider(create: (_) => EditDaftarHadirCubit()),
        BlocProvider(create: (_) => CatatanKhususCubit(apiService: ApiService())),
        BlocProvider(create: (_) => TambahCatatanKhususCubit()),
        BlocProvider(create: (_) => HapusCatatanKhususCubit()),
        BlocProvider(create: (_) => UploadLaporanCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ListNilaiPklCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DetailNilaiCubit(apiService: ApiService())),
        BlocProvider(create: (_) => PenilaianPembimbingCubit()),
        BlocProvider(create: (_) => ListMahasiswaCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DetailBiodataIndustriCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DetailJurnalKegiatanCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DetailDaftarHadirCubit(apiService: ApiService())),
        BlocProvider(create: (_) => DetailCatatanKhususCubit(apiService: ApiService()))
      ],
      child: MaterialApp(
        title: 'PKL App',
        debugShowCheckedModeBanner: false,
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
          '/pencarian': (context) => const PencarianLowonganPage(),
          '/profile': (context) => const ProfilePage(),
          '/ganti-password': (context) => const GantiPasswordPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/status-pengajuan': (context) => const StatusPengajuanPage(),
          '/download-surat-pengantar-pkl': (context) => const DownloadSuratPengantarPklPage(),
          '/pengajuan-pkl': (context) => const AjukanTempatPklPage(),
          '/konfirmasi-pkl': (context) => const KonfirmasiDiterimaPklPage(),
          '/biodata-industri': (context) => const BiodataIndustriPage(),
          '/isi-biodata-industri': (context) => const IsiBiodataIndustriPage(),
          '/download-biodata-industri': (context) => const DownloadBiodataIndustriPage(),
          '/jurnal-kegiatan': (context) => const JurnalKegiatanPage(),
          '/jurnal-kegiatan-detail': (context) => const JurnalKegiatanDetailPage(),
          '/tambah-jurnal-kegiatan': (context) => const TambahJurnalKegiatanPage(),
          '/edit-jurnal-kegiatan': (context) => const EditJurnalKegiatanPage(),
          '/download-jurnal-kegiatan': (context) => const DownloadJurnalKegiatanPage(),
          '/nilai-pkl': (context) => const NilaiPklPage(),
          '/download-lembar-penilaian': (context) => const DownloadLembarPenilaianPage(),
          '/daftar-hadir': (context) => const DaftarHadirPage(),
          '/daftar-hadir-detail': (context) => const DaftarHadirDetailPage(),
          '/tambah-daftar-hadir': (context) => const TambahDaftarHadirPage(),
          '/edit-daftar-hadir': (context) => const EditDaftarHadirPage(),
          '/download-daftar-hadir': (context) => const DownloadDaftarHadirPage(),
          '/catatan-khusus': (context) => const CatatanKhususPage(),
          '/tambah-catatan-khusus': (context) => const TambahCatatanKhususPage(),
          '/download-catatan-khusus': (context) => const DownloadCatatanKhususPage(),
          '/upload-laporan': (context) => const UploadLaporanPage(),
          '/login-pembimbing': (context) => const PembimbingLoginPage(),
          '/register-pembimbing': (context) => const PembimbingRegisterPage(),
          '/dashboard-pembimbing': (context) => const PembimbingDashboardPage(),
          '/kelola-nilai': (context) => const KelolaNilaiPage(),
          '/edit-nilai': (context) => const EditNilaiPage(),
          '/detail-kelola-nilai': (context) => const DetailKelolaNilaiPklPage(),
          '/menu-mahasiswa': (context) => const MenuMahasiswaPage(),
          '/detail-biodata-industri': (context) => const DetailBiodataIndustriPage(),
          '/detail-jurnal-kegiatan': (context) => const DetailJurnalKegiatanPage(),
          '/detail-jurnal-kegiatan-2': (context) => const DetailJurnalKegiatan2Page(),
          '/detail-daftar-hadir':(context) => const DetailDaftarHadirPage(),
          '/detail-catatan-khusus': (context) => const DetailCatatanKhususPage(),
        },
      ),
    );
  }
}
