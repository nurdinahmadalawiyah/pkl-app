// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/login_model.dart';
import 'package:magang_app/presentation/provider/auth_provider.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:magang_app/presentation/widgets/auth_button_loading.dart';
import 'package:provider/provider.dart';

class MahasiswaLoginPage extends StatefulWidget {
  const MahasiswaLoginPage({Key? key}) : super(key: key);

  @override
  State<MahasiswaLoginPage> createState() => _MahasiswaLoginPageState();
}

class _MahasiswaLoginPageState extends State<MahasiswaLoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    late Login login = authProvider.login;

    handleLogin() async {
      if (usernameController.text.isEmpty && passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              'Username dan Password tidak boleh kosong',
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

      if (await authProvider.authLogin(
        username: usernameController.text,
        password: passwordController.text,
      )) {
        Navigator.pushReplacementNamed(context, '/dashboard');
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Login Berhasil!',
                style: kMedium.copyWith(color: blackColor)),
            content: Text(login.message,
                style: kRegular.copyWith(color: blackColor)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
              'Username atau Password yang dimasukan salah \nSilahkan coba lagi!',
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
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/login_illustration.svg',
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: kSemiBold.copyWith(
                        fontSize: 48,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      '.',
                      style: kSemiBold.copyWith(
                        fontSize: 48,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  child: Text(
                    'Silahkan login menggunakan akun mahasiswa',
                    style: kRegular.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: accentColor,
                          labelText: 'Username',
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
                            IconlyBold.profile,
                            color: primaryColor,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<PasswordVisibilityProvider>(
                          builder: (context, provider, _) {
                        return TextFormField(
                          obscureText: !provider.passwordVisible,
                          controller: passwordController,
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: accentColor,
                            labelText: 'Password',
                            labelStyle:
                                const TextStyle(color: Color(0xFF585656)),
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
                        height: 40,
                      ),
                      _isLoading
                          ? const AuthButtonLoading()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  handleLogin();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                ),
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: kBold.copyWith(
                                    fontSize: 20,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/login-pembimbing'),
                  child: Text(
                    'Login Sebagai Pembimbing',
                    style: kRegular.copyWith(
                      fontSize: 14,
                      color: tertiaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}