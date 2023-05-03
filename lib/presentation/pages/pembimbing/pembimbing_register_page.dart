// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:magang_app/presentation/provider/password_visibility_provider.dart';
import 'package:magang_app/presentation/widgets/auth_button_loading.dart';
import 'package:provider/provider.dart';

class PembimbingRegisterPage extends StatefulWidget {
  const PembimbingRegisterPage({super.key});

  @override
  State<PembimbingRegisterPage> createState() => _PembimbingRegisterPageState();
}

class _PembimbingRegisterPageState extends State<PembimbingRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nikController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 0.1),
          child: ListView(
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthRegisterSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showSuccessDialog(context);
                      cubit.resetState();
                    });
                  }
                  return FormRegister(
                    formKey: _formKey,
                    nameController: nameController,
                    nikController: nikController,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    retypePasswordController: retypePasswordController,
                    cubit: cubit,
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthRegisterLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AuthButtonLoading(),
                    );
                  } else if (state is AuthRegisterFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<AuthCubit>().resetState();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terjadi kesalahan: ${state.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                    return Container();
                  } else {
                    return ButtonRegister(
                      cubit: cubit,
                      formKey: _formKey,
                      nameController: nameController,
                      nikController: nikController,
                      passwordController: passwordController,
                      retypePasswordController: retypePasswordController,
                      usernameController: usernameController,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.nikController,
    required this.usernameController,
    required this.passwordController,
    required this.retypePasswordController,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final AuthCubit cubit;
  final GlobalKey<FormState> _formKey;
  final nameController;
  final nikController;
  final usernameController;
  final passwordController;
  final retypePasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Nama',
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
                  controller: nikController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'NIK/NIP',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<PasswordVisibilityProvider>(
                  builder: (context, provider, _) {
                    return TextFormField(
                      obscureText: !provider.passwordVisible,
                      controller: retypePasswordController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: 'Ketik Ulang Password',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    Key? key,
    required this.cubit,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.nikController,
    required this.usernameController,
    required this.passwordController,
    required this.retypePasswordController,
  })  : _formKey = formKey,
        super(key: key);

  final AuthCubit cubit;
  final GlobalKey<FormState> _formKey;
  final nameController;
  final nikController;
  final usernameController;
  final passwordController;
  final retypePasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                passwordController.text == retypePasswordController.text) {
              final nama = nameController.text;
              final nik = nikController.text;
              final username = usernameController.text;
              final password = passwordController.text;

              cubit.registerPembimbing(nama, nik, username, password);
            } else if (passwordController.text !=
                retypePasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                    'Password Tidak Sama',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(color: backgroundColor),
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15),
          ),
          child: Text(
            'Register',
            textAlign: TextAlign.center,
            style: kBold.copyWith(
              fontSize: 20,
              color: backgroundColor,
            ),
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
          'Register Berhasil',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Silahkan login menggunakan akun yang telah dibuat',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/login-pembimbing');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
