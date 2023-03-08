// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
    UpdateProfile({
        required this.message,
        required this.data,
    });

    String message;
    Data data;

    factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
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
    };
}
