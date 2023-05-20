// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/penilaian/detail_nilai_cubit.dart';
import 'package:magang_app/presentation/cubit/penilaian/penilaian_pembimbing_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class EditNilaiPage extends StatefulWidget {
  const EditNilaiPage({super.key});

  @override
  State<EditNilaiPage> createState() => _EditNilaiPageState();
}

class _EditNilaiPageState extends State<EditNilaiPage> {
  final _formKey = GlobalKey<FormState>();
  late final DetailNilaiCubit detailNilai;
  final integritasController = TextEditingController();
  final profesionalitasController = TextEditingController();
  final bahasaInggrisController = TextEditingController();
  final teknologiInformasiController = TextEditingController();
  final komunikasiController = TextEditingController();
  final kerjaSamaController = TextEditingController();
  final organisasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    detailNilai = DetailNilaiCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    detailNilai.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PenilaianPembimbingCubit>();
    final list = ModalRoute.of(context)?.settings.arguments as Datum;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Edit Data',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<PenilaianPembimbingCubit, PenilaianPembimbingState>(
        builder: (context, state) {
          if (state is PenilaianPembimbingSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PenilaianPembimbingCubit>().resetState();
              showSuccessDialog(context, list);
            });
          }
          return FormPenilaian(
            cubit: cubit,
            detailNilai: detailNilai,
            formKey: _formKey,
            bahasaInggrisController: bahasaInggrisController,
            integritasController: integritasController,
            kerjaSamaController: kerjaSamaController,
            komunikasiController: komunikasiController,
            organisasiController: organisasiController,
            profesionalitasController: profesionalitasController,
            teknologiInformasiController: teknologiInformasiController,
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<PenilaianPembimbingCubit, PenilaianPembimbingState>(
        builder: (context, state) {
          if (state is PenilaianPembimbingLoading) {
            return const LoadingButton();
          } else if (state is PenilaianPembimbingError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PenilaianPembimbingCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
//            WidgetsBinding.instance.addPostFrameCallback((_) {
//               context.read<PenilaianPembimbingCubit>().resetState();
//               showSuccessDialog(context, list);
//            });
            return Container();
          } else {
            return ButtonAdd(
              cubit: cubit,
              formKey: _formKey,
              list: list,
              bahasaInggrisController: bahasaInggrisController,
              integritasController: integritasController,
              kerjaSamaController: kerjaSamaController,
              komunikasiController: komunikasiController,
              organisasiController: organisasiController,
              profesionalitasController: profesionalitasController,
              teknologiInformasiController: teknologiInformasiController,
            );
          }
        },
      ),
    );
  }
}

class FormPenilaian extends StatelessWidget {
  const FormPenilaian({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.integritasController,
    required this.profesionalitasController,
    required this.bahasaInggrisController,
    required this.teknologiInformasiController,
    required this.komunikasiController,
    required this.kerjaSamaController,
    required this.organisasiController,
    required this.detailNilai,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final PenilaianPembimbingCubit cubit;
  final DetailNilaiCubit detailNilai;
  final TextEditingController integritasController;
  final TextEditingController profesionalitasController;
  final TextEditingController bahasaInggrisController;
  final TextEditingController teknologiInformasiController;
  final TextEditingController komunikasiController;
  final TextEditingController kerjaSamaController;
  final TextEditingController organisasiController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailNilaiCubit, DetailNilaiState>(
      builder: (context, state) {
        if (state is DetailNilaiLoaded) {
          var data = state.detailNilai.data;

          integritasController.text = data.integritas.toString();
          profesionalitasController.text = data.profesionalitas.toString();
          bahasaInggrisController.text = data.bahasaInggris.toString();
          teknologiInformasiController.text = data.teknologiInformasi.toString();
          komunikasiController.text = data.komunikasi.toString();
          kerjaSamaController.text = data.kerjaSama.toString();
          organisasiController.text = data.organisasi.toString();

          return FormInput(
            formKey: _formKey,
            integritasController: integritasController,
            profesionalitasController: profesionalitasController,
            bahasaInggrisController: bahasaInggrisController,
            teknologiInformasiController: teknologiInformasiController,
            komunikasiController: komunikasiController,
            kerjaSamaController: kerjaSamaController,
            organisasiController: organisasiController,
            cubit: cubit,
          );
        }
        return FormInput(
          formKey: _formKey,
          integritasController: integritasController,
          profesionalitasController: profesionalitasController,
          bahasaInggrisController: bahasaInggrisController,
          teknologiInformasiController: teknologiInformasiController,
          komunikasiController: komunikasiController,
          kerjaSamaController: kerjaSamaController,
          organisasiController: organisasiController,
          cubit: cubit,
        );
      },
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.integritasController,
    required this.profesionalitasController,
    required this.bahasaInggrisController,
    required this.teknologiInformasiController,
    required this.komunikasiController,
    required this.kerjaSamaController,
    required this.organisasiController,
    required this.cubit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final PenilaianPembimbingCubit cubit;
  final integritasController;
  final profesionalitasController;
  final bahasaInggrisController;
  final teknologiInformasiController;
  final komunikasiController;
  final kerjaSamaController;
  final organisasiController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Memiliki integritas yang baik di lingkungan kerja',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: integritasController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mampu bekerja secara profesional sesuai bidangnya',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: profesionalitasController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Cakap dalam berkomunikasi bahasa inggris',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: bahasaInggrisController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mampu mengaplikasikan teknologi informasi',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: teknologiInformasiController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mampu berkomunikasi dengan teman sejawat atau atasan',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: komunikasiController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mampu bekerjasama dengan teman sejawat/tim',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: kerjaSamaController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mampu mengorganisasikan pekerjaan berdasarkan visi ke depan',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: organisasiController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Data tidak boleh kosong';
                    } else {
                      final numericValue = double.tryParse(value);
                      if (numericValue == null) {
                        return 'Nilai harus berupa angka';
                      } else if (numericValue > 100) {
                        return 'Nilai tidak boleh lebih dari 100';
                      }
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showSuccessDialog(BuildContext context, Datum list) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: accentColor,
        title: Text(
          'Penilaian',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil memberi nilai kepada ${list.namaMahasiswa}',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/detail-kelola-nilai',
                  ModalRoute.withName('/kelola-nilai'),
                  arguments: list);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.integritasController,
    required this.profesionalitasController,
    required this.bahasaInggrisController,
    required this.teknologiInformasiController,
    required this.komunikasiController,
    required this.kerjaSamaController,
    required this.organisasiController,
    required this.list,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final PenilaianPembimbingCubit cubit;
  final Datum list;
  final integritasController;
  final profesionalitasController;
  final bahasaInggrisController;
  final teknologiInformasiController;
  final komunikasiController;
  final kerjaSamaController;
  final organisasiController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final idMahasiswa = list.idMahasiswa;
            final idTempatPkl = list.idTempatPkl;
            final integritas = integritasController.text;
            final profesionalitas = profesionalitasController.text;
            final bahasaInggris = bahasaInggrisController.text;
            final teknologiInformasi = teknologiInformasiController.text;
            final komunikasi = komunikasiController.text;
            final kerjaSama = kerjaSamaController.text;
            final organisasi = organisasiController.text;

            cubit.penilaianPembimbing(
              idMahasiswa,
              idTempatPkl,
              integritas,
              profesionalitas,
              bahasaInggris,
              teknologiInformasi,
              komunikasi,
              kerjaSama,
              organisasi,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
        ),
        child: FittedBox(
          child: Text(
            'Simpan',
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
