import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/profile/edit_profile_cubit.dart';
import 'package:magang_app/presentation/cubit/profile/profile_cubit.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = ProfileCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Edit Profile',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<EditProfileCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                FormUpdateProfile(
                    formKey: _formKey,
                    cubit: cubit,
                    profileCubit: profileCubit),
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileLoadingState) {
            return const LoadingButton();
          } else if (state is EditProfileErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<EditProfileCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return ConfirmButton(formKey: _formKey, cubit: cubit);
          }
        },
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
          'Update Profile',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Data Profile Berhasil Diperbarui Dengan Data Baru',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/profile', ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final email = cubit.emailController.text;
            final username = cubit.usernameController.text;
            final tahunMasuk = cubit.tahunMasukController.text;
            final nomorHp = cubit.nomorhpController.text;

            cubit.updateProfile(email, username, tahunMasuk, nomorHp);
            cubit.resetForm();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: tertiaryColor,
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
    );
  }
}

class FormUpdateProfile extends StatelessWidget {
  const FormUpdateProfile({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.profileCubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditProfileCubit cubit;
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileState>(
      stream: profileCubit.stream,
      initialData: ProfileInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is ProfileLoaded) {
          cubit.emailController.text = state.profile.data.email ?? '';
          cubit.usernameController.text = state.profile.data.username;
          cubit.tahunMasukController.text = state.profile.data.tahunMasuk.toString();
          cubit.nomorhpController.text = state.profile.data.nomorHp ?? '';

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.emailController,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: 'Email',
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
                        IconlyBold.message,
                        color: primaryColor,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: cubit.usernameController,
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
                    controller: cubit.tahunMasukController,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: 'Tahun Masuk',
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
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/semester_icon.svg',
                          color: primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tahun Masuk tidak boleh kosong';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  // TextFormField(
                  //   controller: cubit.tahunMasukController,
                  //   keyboardType: TextInputType.text,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: accentColor,
                  //     labelText: 'Tahun Masuk',
                  //     labelStyle: const TextStyle(color: Color(0xFF585656)),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(16),
                  //       borderSide: const BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(16),
                  //       borderSide: const BorderSide(
                  //         width: 2,
                  //         style: BorderStyle.solid,
                  //         color: primaryColor,
                  //       ),
                  //     ),
                  //     prefixIcon: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: SvgPicture.asset(
                  //         'assets/semester_icon.svg',
                  //         color: primaryColor,
                  //       ),
                  //     ),
                  //     suffixIcon: Transform.rotate(
                  //       angle: 90 * 3.14 / 180,
                  //       child: const Icon(
                  //         Icons.chevron_right_rounded,
                  //         color: primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  //   style: const TextStyle(color: tertiaryColor),
                  //   readOnly: true,
                  //   onTap: () async {
                  //     final selectedOption = await showMenu<String>(
                  //       context: context,
                  //       position: const RelativeRect.fromLTRB(50, 340, 50, 50),
                  //       items: [
                  //         PopupMenuItem(
                  //           value: '1 (Satu)',
                  //           child: Text(
                  //             '1 (Satu)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '2 (Dua)',
                  //           child: Text(
                  //             '2 (Dua)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '3 (Tiga)',
                  //           child: Text(
                  //             '3 (Tiga)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '4 (Empat)',
                  //           child: Text(
                  //             '4 (Empat)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '5 (Lima)',
                  //           child: Text(
                  //             '5 (Lima)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '6 (Enam)',
                  //           child: Text(
                  //             '6 (Enam)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '7 (Tujuh)',
                  //           child: Text(
                  //             '7 (Tujuh)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: '8 (Delapan)',
                  //           child: Text(
                  //             '8 (Delapan)',
                  //             style: kMedium.copyWith(color: tertiaryColor),
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //     if (selectedOption != null) {
                  //       cubit.tahunMasukController.text = selectedOption;
                  //     }
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: cubit.nomorhpController,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: 'No. Hp',
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
                        IconlyBold.call,
                        color: primaryColor,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Untuk menjaga keamanan akun, anda hanya bisa edit email, username, tahun masuk dan nomor hp. Jika ada kesalahan dalam penulisan nama dan nim silahkan hubungi akademik atau prodi.',
                      style: kRegular.copyWith(
                        fontSize: 11,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
