import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/tambah_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class TambahCatatanKhususPage extends StatefulWidget {
  const TambahCatatanKhususPage({super.key});

  @override
  State<TambahCatatanKhususPage> createState() =>
      _TambahCatatanKhususPageState();
}

class _TambahCatatanKhususPageState extends State<TambahCatatanKhususPage> {
  final _formKey = GlobalKey<FormState>();
  late final CatatanKhususCubit catatanKhusus;
  final catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    catatanKhusus = CatatanKhususCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    catatanKhusus.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TambahCatatanKhususCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Tambah / Edit Catatan Khusus PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<TambahCatatanKhususCubit, TambahCatatanKhususState>(
        builder: (context, state) {
          if (state is TambahCatatanKhususSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahCatatanKhususCubit>().resetState();
              showSuccessDialog(context);
            });
          }
          return FormCatatanKhusus(
            catatanKhusus: catatanKhusus,
            catatanController: catatanController,
            formKey: _formKey,
            cubit: cubit,
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<TambahCatatanKhususCubit, TambahCatatanKhususState>(
        builder: (context, state) {
          if (state is TambahCatatanKhususLoading) {
            return const LoadingButton();
          } else if (state is TambahCatatanKhususError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahCatatanKhususCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi Kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return SaveButton(formKey: _formKey, catatanController: catatanController, cubit: cubit);
          }
        },
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.catatanController,
    required this.cubit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController catatanController;
  final TambahCatatanKhususCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final catatan = catatanController.text;
            cubit.addCatatanKhusus(catatan);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15)),
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

class FormCatatanKhusus extends StatelessWidget {
  const FormCatatanKhusus({
    super.key,
    required this.catatanKhusus,
    required this.catatanController,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  }) : _formKey = formKey;

  final CatatanKhususCubit catatanKhusus;
  final TextEditingController catatanController;
  final GlobalKey<FormState> _formKey;
  final TambahCatatanKhususCubit cubit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CatatanKhususState>(
        stream: catatanKhusus.stream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is CatatanKhususLoaded) {
            var data = state.catatanKhusus.data;
            catatanController.text = data.catatan;
            return FormInput(
              formKey: _formKey,
              cubit: cubit,
              catatanController: catatanController,
            );
          } else if (state is CatatanKhususError) {
            return FormInput(
              formKey: _formKey,
              cubit: cubit,
              catatanController: catatanController,
            );
          } else if (state is CatatanKhususNoData) {
            return FormInput(
              formKey: _formKey,
              cubit: cubit,
              catatanController: catatanController,
            );
          }
          return Container();
        });
  }
}

class FormInput extends StatelessWidget {
  const FormInput(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.cubit,
      required this.catatanController})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TambahCatatanKhususCubit cubit;
  final catatanController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Catatan",
                  style: kRegular.copyWith(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: catatanController,
                  maxLines: 10,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.multiline,
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
                      return 'Catatan tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
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
          'Catatan Khusus',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil menambah / mengubah catatan khusus PKL',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/catatan-khusus',
                  ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
