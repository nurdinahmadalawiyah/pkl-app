// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class PembimbingLoginPage extends StatefulWidget {
  const PembimbingLoginPage({Key? key}) : super(key: key);

  @override
  State<PembimbingLoginPage> createState() => _PembimbingLoginPageState();
}

class _PembimbingLoginPageState extends State<PembimbingLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthInitial) {
          return FormLogin(
            cubit: cubit,
            formKey: _formKey,
            usernameController: usernameController,
            passwordController: passwordController,
          );
        } else if (state is AuthLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showLoadingDialog(context);
            cubit.resetState();
          });
        } else if (state is AuthLoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/dashboard-pembimbing');
            showSuccessDialog(context);
            cubit.resetState();
          });
        } else if (state is AuthFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
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
            cubit.resetState();
          });
        }
        return Container();
      }),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required this.cubit,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final AuthCubit cubit;
  final GlobalKey<FormState> _formKey;
  final usernameController;
  final passwordController;

  @override
  Widget build(BuildContext context) {
    return Align(
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
                child: Form(
                  key: _formKey,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        );
                      }),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonLogin(
                          cubit: cubit,
                          formKey: _formKey,
                          usernameController: usernameController,
                          passwordController: passwordController),
                    ],
                  ),
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
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.usernameController,
    required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AuthCubit cubit;
  final usernameController;
  final passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final username = usernameController.text;
            final password = passwordController.text;

            cubit.loginPembimbing(username, password);
          }
        },
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

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: accentColor,
        title: Text(
          'Login Berhasil',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil login ke akun anda',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.pushNamedAndRemoveUntil(context, '/jurnal-kegiatan',
              //     ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              // The loading indicator
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    },
  );
}
