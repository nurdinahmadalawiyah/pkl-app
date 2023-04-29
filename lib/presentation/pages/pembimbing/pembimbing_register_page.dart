import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';

class PembimbingRegisterPage extends StatefulWidget {
  const PembimbingRegisterPage({super.key});

  @override
  State<PembimbingRegisterPage> createState() => _PembimbingRegisterPageState();
}

class _PembimbingRegisterPageState extends State<PembimbingRegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
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
                    'Silahkan isi data untuk membuat akun pembimbing',
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
                  child: Form(
                    // key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: accentColor,
                            labelText: 'Nama',
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
                              IconlyBold.user_2,
                              color: primaryColor,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: usernameController,
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: accentColor,
                            labelText: 'NIK/NIP',
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
                              IconlyBold.user_2,
                              color: primaryColor,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'NIK/NIP tidak boleh kosong';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: usernameController,
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: accentColor,
                            labelText: 'Username',
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
                              IconlyBold.user_2,
                              color: primaryColor,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //obscureText: !provider.passwordVisible,
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
                            // suffixIcon: IconButton(
                            //   onPressed: () => provider.toogle(),
                            //   icon: Icon(provider.passwordVisible
                            //       ? IconlyBold.show
                            //       : IconlyBold.hide),
                            //   color: const Color(0xFFC3C5C8),
                            // ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //obscureText: !provider.passwordVisible,
                          controller: passwordController,
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: accentColor,
                            labelText: 'Ketik Ulang Password',
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
                            // suffixIcon: IconButton(
                            //   onPressed: () => provider.toogle(),
                            //   icon: Icon(provider.passwordVisible
                            //       ? IconlyBold.show
                            //       : IconlyBold.hide),
                            //   color: const Color(0xFFC3C5C8),
                            // ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak sama';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tidak Punya Akun?',
                              style: kRegular.copyWith(
                                fontSize: 12,
                                color: tertiaryColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, '/register-pembimbing'),
                              child: Text(
                                'Daftar Disini',
                                style: kRegular.copyWith(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonLogin(),
                      ],
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

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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
    );
  }
}
