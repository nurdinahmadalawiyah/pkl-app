import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/isi_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class IsiBiodataIndustriPage extends StatefulWidget {
  const IsiBiodataIndustriPage({Key? key}) : super(key: key);

  @override
  State<IsiBiodataIndustriPage> createState() => _IsiBiodataIndustriPageState();
}

class _IsiBiodataIndustriPageState extends State<IsiBiodataIndustriPage> {
  final _formKey = GlobalKey<FormState>();
  late final BiodataIndustriCubit biodataIndustri;

  @override
  void initState() {
    super.initState();
    biodataIndustri = BiodataIndustriCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    biodataIndustri.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IsiBiodataIndustriCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Isi / Edit Biodata Industri',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<IsiBiodataIndustriCubit, IsiBiodataIndustriState>(
        builder: (context, state) {
          if (state is IsiBiodataIndustriSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<IsiBiodataIndustriCubit>().resetState();
              showSuccessDialog(context);
            });
          }
          return FormBiodataIndustri(
              cubit: cubit,
              biodataIndustri: biodataIndustri,
              formKey: _formKey);
        },
      ),
      bottomNavigationBar:
          BlocBuilder<IsiBiodataIndustriCubit, IsiBiodataIndustriState>(
        builder: (context, state) {
          if (state is IsiBiodataIndustriLoading) {
            return const LoadingButton();
          } else if (state is IsiBiodataIndustriError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<IsiBiodataIndustriCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return SaveButton(formKey: _formKey, cubit: cubit);
          }
        },
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final IsiBiodataIndustriCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final namaIndustri = cubit.namaIndustriController.text;
            final namaPimpinan = cubit.namaPimpinanController.text;
            final alamatKantor = cubit.alamatKantorController.text;
            final noTelpFax = cubit.noTelpFaxController.text;
            final contactPerson = cubit.contactPersonController.text;
            final bidangUsahaJasa = cubit.bidangUsahaJasaController.text;
            final spesialisasiProduksiJasa = cubit.spesialisasiProduksiJasaController.text;
            final kapasitasProduksi = cubit.kapasitasProduksiController.text;
            final jangkauanPemasaran = cubit.jangkauanPemasaranController.text;
            final jumlahTenagaKerjaSd =  cubit.jumlahTenagaKerjaSdController.text;
            final jumlahTenagaKerjaSltp =  cubit.jumlahTenagaKerjaSltpController.text;
            final jumlahTenagaKerjaSmk =  cubit.jumlahTenagaKerjaSmkController.text;
            final jumlahTenagaKerjaSlta = cubit.jumlahTenagaKerjaSltaController.text;
            final jumlahTenagaKerjaSarjanaMuda = cubit.jumlahTenagaKerjaSarjanaMudaController.text;
            final jumlahTenagaKerjaSarjanaMagister = cubit.jumlahTenagaKerjaSarjanaMudaController.text;
            final jumlahTenagaKerjaSarjanaDoktor = cubit.jumlahTenagaKerjaSarjanaDoktorController.text;

            cubit.addBiodataIndustri(
              namaIndustri,
              namaPimpinan,
              alamatKantor,
              noTelpFax,
              contactPerson,
              bidangUsahaJasa,
              spesialisasiProduksiJasa,
              kapasitasProduksi,
              jangkauanPemasaran,
              jumlahTenagaKerjaSd,
              jumlahTenagaKerjaSltp,
              jumlahTenagaKerjaSlta,
              jumlahTenagaKerjaSmk,
              jumlahTenagaKerjaSarjanaMuda,
              jumlahTenagaKerjaSarjanaMagister,
              jumlahTenagaKerjaSarjanaDoktor,
            );
            cubit.resetForm();
          }
        },
        style: ElevatedButton.styleFrom(
            primary: tertiaryColor,
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

class FormBiodataIndustri extends StatelessWidget {
  const FormBiodataIndustri(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.cubit,
      required this.biodataIndustri})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final IsiBiodataIndustriCubit cubit;
  final BiodataIndustriCubit biodataIndustri;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BiodataIndustriState>(
        stream: biodataIndustri.stream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is BiodataIndustriLoaded) {
            var data = state.biodataIndustri.data;

            cubit.namaIndustriController.text = data.namaIndustri;
            cubit.alamatKantorController.text = data.alamatKantor;
            cubit.noTelpFaxController.text = data.noTelpFax;
            cubit.namaPimpinanController.text = data.namaPimpinan;
            cubit.contactPersonController.text = data.contactPerson;
            cubit.bidangUsahaJasaController.text = data.bidangUsahaJasa;
            cubit.spesialisasiProduksiJasaController.text = data.spesialisasiProduksiJasa;
            cubit.kapasitasProduksiController.text = data.kapasitasProduksi?.toString() ?? '';
            cubit.jangkauanPemasaranController.text = data.jangkauanPemasaran;
            cubit.jumlahTenagaKerjaSdController.text = data.jumlahTenagaKerjaSd?.toString() ?? '';
            cubit.jumlahTenagaKerjaSltpController.text = data.jumlahTenagaKerjaSltp?.toString() ?? '';
            cubit.jumlahTenagaKerjaSltaController.text = data.jumlahTenagaKerjaSlta?.toString() ?? '';
            cubit.jumlahTenagaKerjaSmkController.text = data.jumlahTenagaKerjaSmk?.toString() ?? '';
            cubit.jumlahTenagaKerjaSarjanaMudaController.text = data.jumlahTenagaKerjaSarjanaMuda?.toString() ?? '';
            cubit.jumlahTenagaKerjaSarjanaMagisterController.text = data.jumlahTenagaKerjaSarjanaMagister?.toString() ?? '';
            cubit.jumlahTenagaKerjaSarjanaDoktorController.text = data.jumlahTenagaKerjaSarjanaDoktor?.toString() ?? '';
            
            return FormInput(formKey: _formKey, cubit: cubit);
          } else if (state is BiodataIndustriError) {
            return FormInput(formKey: _formKey, cubit: cubit);
          } else if (state is BiodataIndustriNoData) {
            return FormInput(formKey: _formKey, cubit: cubit);
          }
          return Container();
        });
  }
}

class FormInput extends StatelessWidget {
  const FormInput({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final IsiBiodataIndustriCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IDENTITAS INDUSTRI",
                  style: kRegular.copyWith(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.namaIndustriController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Nama Industri',
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
                      Icons.business_sharp,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Industri tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.namaPimpinanController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Nama Direktur/Pimpinan',
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
                      IconlyBold.profile,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Pimpinan tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.alamatKantorController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Alamat Kantor',
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
                      IconlyBold.location,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat Kantor tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.noTelpFaxController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'No.Telepon/FAX',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/fax_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'No. Telp / FAX tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.contactPersonController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Contact Person',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/contact_person_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Contact Person tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AKTIVITAS",
                  style: kRegular.copyWith(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.bidangUsahaJasaController,
                  maxLines: 3,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Bidang Usaha / Jasa',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/bidang_usaha_jasa_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bidang Usaha / Jasa tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.spesialisasiProduksiJasaController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Spesialisasi Produksi / Jasa',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/spesialisasi_produksi_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Spesialisasi Produksi / Jasa tidak boleh kosong';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.kapasitasProduksiController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Kapasitas Produksi',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/kapasitas_produksi_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.jangkauanPemasaranController,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Jangkauan Pemasaran',
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/jangkauan_pemasaran_icon.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TENAGA KERJA",
                      style: kRegular.copyWith(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                cubit.jumlahTenagaKerjaSdController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'SD',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sd_smp_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller:
                                cubit.jumlahTenagaKerjaSltpController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'SLTP',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sd_smp_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                cubit.jumlahTenagaKerjaSmkController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'SMK/STM/SMEA/SMKK/SMTK',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sma_smk_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller:
                                cubit.jumlahTenagaKerjaSltaController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'SLTA Non SMK',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sma_smk_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cubit
                                .jumlahTenagaKerjaSarjanaMudaController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'Sarjana Muda',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sarjana_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: cubit
                                .jumlahTenagaKerjaSarjanaMagisterController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: 'Sarjana Magister',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF585656)),
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
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/sarjana_icon.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: cubit
                          .jumlahTenagaKerjaSarjanaDoktorController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: 'Doktor',
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
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/doktor_icon.svg',
                            color: primaryColor,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
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
          'Biodata Industri',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil mengisi / mengubah biodata industri tempal PKL anda',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/biodata-industri',
                  ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
