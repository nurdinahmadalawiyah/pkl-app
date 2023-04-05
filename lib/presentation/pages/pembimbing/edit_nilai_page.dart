import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';

class EditNilaiPage extends StatelessWidget {
  const EditNilaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Edit Data',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Memiliki integritas yang baik di lingkungan kerja',
                  style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
                  //controller: namaPerusahaanController,
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
      bottomNavigationBar: const ButtonAdd(),
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
  })  : 
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
        },
        style: ElevatedButton.styleFrom(
          primary: tertiaryColor,
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