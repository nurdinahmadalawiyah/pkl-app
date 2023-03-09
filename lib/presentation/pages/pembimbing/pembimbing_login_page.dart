import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class PembimbingLoginPage extends StatefulWidget {
  const PembimbingLoginPage({Key? key}) : super(key: key);

  @override
  State<PembimbingLoginPage> createState() => _PembimbingLoginPageState();
}

class _PembimbingLoginPageState extends State<PembimbingLoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/login_illustration2.svg',
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
                    'Silahkan login menggunakan akun pembimbing',
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
                            IconlyBold.user_2,
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
                              icon: Icon(_isPasswordVisible
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
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.all(15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        valueColor: AlwaysStoppedAnimation(
                                          backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard-pembimbing'),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
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
                  onTap: () => Navigator.pushNamed(context, '/login-mahasiswa'),
                  child: Text(
                    'Login Sebagai Mahasiswa',
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
