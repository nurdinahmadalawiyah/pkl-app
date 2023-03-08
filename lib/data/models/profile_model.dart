// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Profile({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.idMahasiswa,
        required this.username,
        required this.nama,
        required this.nim,
        required this.prodi,
        required this.semester,
        required this.email,
        required this.nomorHp,
        required this.createdAt,
        required this.updatedAt,
        required this.namaProdi,
    });

    int idMahasiswa;
    String username;
    String nama;
    String nim;
    int prodi;
    String semester;
    String email;
    String nomorHp;
    DateTime createdAt;
    DateTime updatedAt;
    String namaProdi;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idMahasiswa: json["id_mahasiswa"],
        username: json["username"],
        nama: json["nama"],
        nim: json["nim"],
        prodi: json["prodi"],
        semester: json["semester"],
        email: json["email"],
        nomorHp: json["nomor_hp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        namaProdi: json["nama_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_mahasiswa": idMahasiswa,
        "username": username,
        "nama": nama,
        "nim": nim,
        "prodi": prodi,
        "semester": semester,
        "email": email,
        "nomor_hp": nomorHp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama_prodi": namaProdi,
    };
}
