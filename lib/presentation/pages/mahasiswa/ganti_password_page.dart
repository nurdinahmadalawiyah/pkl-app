import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/ganti_password_model.dart';
import 'package:magang_app/presentation/provider/ganti_password_provider.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({Key? key}) : super(key: key);

  @override
  State<GantiPasswordPage> createState() =>
      _GantiPasswordPageState();
}

class _GantiPasswordPageState
    extends State<GantiPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    GantiPasswordProvider gantiPasswordProvider =
        Provider.of<GantiPasswordProvider>(context);
    late GantiPassword gantiPassword = gantiPasswordProvider.gantiPassword;

    handleUpdatePassword() async {
      if (newPasswordController.text != confirmNewPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              'Password Baru Tidak Sama',
              textAlign: TextAlign.center,
              style: kMedium.copyWith(color: backgroundColor),
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      if (await gantiPasswordProvider.updatePassword(
        passwordBaru: newPasswordController.text,
        passwordLama: oldPasswordController.text,
      )) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Ganti Password',
                style: kMedium.copyWith(color: blackColor)),
            content: Text(gantiPassword.message,
                style: kRegular.copyWith(color: blackColor)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              'Terjadi Kesalahan Saat Mengganti Password',
              textAlign: TextAlign.center,
              style: kMedium.copyWith(color: backgroundColor),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Ganti Password',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Consumer<PasswordVisibilityProvider>(
                builder: (context, provider, _) {
              return TextFormField(
                obscureText: !provider.passwordVisible,
                controller: newPasswordController,
                cursorColor: primaryColor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: accentColor,
                  labelText: 'Masukan Password Baru',
                  labelStyle: const TextStyle(color: Color(0xFF585656)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: primaryColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    IconlyBold.lock,
                    color: primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => provider.toogle(),
                    icon: Icon(provider.passwordVisible
                        ? IconlyBold.show
                        : IconlyBold.hide),
                    color: const Color(0xFFC3C5C8),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Consumer<PasswordVisibilityProvider>(
                builder: (context, provider, _) {
              return TextFormField(
                obscureText: !provider.passwordVisible,
                controller: confirmNewPasswordController,
                cursorColor: primaryColor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: accentColor,
                  labelText: 'Ketik Ulang Password Baru',
                  labelStyle: const TextStyle(color: Color(0xFF585656)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: primaryColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    IconlyBold.lock,
                    color: primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => provider.toogle(),
                    icon: Icon(provider.passwordVisible
                        ? IconlyBold.show
                        : IconlyBold.hide),
                    color: const Color(0xFFC3C5C8),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Untuk menjaga keamanan akun anda, silahkan untuk masukan password lama',
                style: kRegular.copyWith(
                  fontSize: 10,
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<PasswordVisibilityProvider>(
                builder: (context, provider, _) {
              return TextFormField(
                obscureText: !provider.passwordVisible,
                controller: oldPasswordController,
                cursorColor: primaryColor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: accentColor,
                  labelText: 'Password Lama',
                  labelStyle: const TextStyle(color: Color(0xFF585656)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: primaryColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    IconlyBold.lock,
                    color: primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => provider.toogle(),
                    icon: Icon(provider.passwordVisible
                        ? IconlyBold.show
                        : IconlyBold.hide),
                    color: const Color(0xFFC3C5C8),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: _isLoading
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: tertiaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(
                          backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: () => handleUpdatePassword(),
                style: ElevatedButton.styleFrom(
                    primary: tertiaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(15)),
                icon: const Icon(
                  IconlyBold.tick_square,
                  color: backgroundColor,
                ),
                label: FittedBox(
                  child: Text(
                    'Konfirmasi',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: kSemiBold.copyWith(
                      fontSize: 16,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
