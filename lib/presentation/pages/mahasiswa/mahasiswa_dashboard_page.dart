import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/logout_model.dart';
import 'package:magang_app/presentation/cubit/dashboard/save_player_id_cubit.dart';
import 'package:magang_app/presentation/provider/auth_provider.dart';
import 'package:magang_app/presentation/widgets/menu_dashboard_mahasiswa.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class MahasiswaDashboardPage extends StatefulWidget {
  const MahasiswaDashboardPage({Key? key}) : super(key: key);

  @override
  State<MahasiswaDashboardPage> createState() => _MahasiswaDashboardPageState();
}

class _MahasiswaDashboardPageState extends State<MahasiswaDashboardPage> {
  String playerID = '';

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    final storage = FlutterSecureStorage();
    bool isPermissionRequested = await storage.read(key: 'notification_permission_requested') == 'true';

    if (!isPermissionRequested) {
      OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
        print("Accepted permission: $accepted");
      });

      await storage.write(key: 'notification_permission_requested', value: 'true');
    }
    await getPlayerID();
    if (playerID != 'Player ID tidak ditemukan') {
      context.read<SavePlayerIdCubit>().savePlayerId(playerID);
    }
  }

  Future<void> getPlayerID() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    setState(() {
      playerID = deviceState?.userId ?? 'Player ID tidak ditemukan';
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    late Logout logout = authProvider.logout;
    const storage = FlutterSecureStorage();

    handleLogout() async {
      String? token = await storage.read(key: 'token');
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Konfirmasi Logout',
              style: kMedium.copyWith(color: blackColor)),
          content: Text('Apakah anda yakin ingin logout dari akun anda?',
              style: kRegular.copyWith(color: blackColor)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () async {
                if (await authProvider.authLogout(token: token!)) {
                  Navigator.pushReplacementNamed(context, '/login-mahasiswa');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        logout.message,
                        textAlign: TextAlign.center,
                        style: kMedium.copyWith(color: backgroundColor),
                      ),
                      backgroundColor: tertiaryColor,
                    ),
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/login-mahasiswa');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        'Terjadi Kesalahan Saat Proses Logout',
                        textAlign: TextAlign.center,
                        style: kMedium.copyWith(color: backgroundColor),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                await storage.delete(key: 'token');
              },
              child: const Text('Ya'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batalkan'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'PKL ',
              style: kSemiBold.copyWith(
                color: primaryColor,
                fontSize: 24,
              ),
            ),
            Text(
              'TEDC',
              style: kSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: greyColor,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: blackColor,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  trailing: const Icon(
                    IconlyBold.user_2,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Profile',
                    style: kMedium.copyWith(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () => handleLogout(),
                  trailing: const Icon(
                    IconlyBold.logout,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: kMedium.copyWith(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/pencarian'),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  enabled: false,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Cari Tempat PKL',
                    labelStyle: const TextStyle(color: Color(0xFF585656)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: const Icon(
                      IconlyLight.search,
                      color: primaryColor,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Ajukan Tempat PKL',
                            style: kSemiBold.copyWith(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/pengajuan-pkl'),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              IconlyBold.paper_plus,
                              color: backgroundColor,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      onTap: () =>
                          Navigator.pushNamed(context, '/status-pengajuan'),
                      title: Text(
                        'Status Pengajuan',
                        style: kMedium.copyWith(fontSize: 16),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const MenuDashboardMahasiswa(),
          ],
        ),
      ),
    );
  }
}

