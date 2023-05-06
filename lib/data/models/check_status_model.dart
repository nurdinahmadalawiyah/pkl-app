// To parse this JSON data, do
//
//     final checkStatus = checkStatusFromJson(jsonString);

import 'dart:convert';

CheckStatus checkStatusFromJson(String str) => CheckStatus.fromJson(json.decode(str));

String checkStatusToJson(CheckStatus data) => json.encode(data.toJson());

class CheckStatus {
    String message;
    Data data;

    CheckStatus({
        required this.message,
        required this.data,
    });

    factory CheckStatus.fromJson(Map<String, dynamic> json) => CheckStatus(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int idMahasiswa;
    String status;
    String telahKonfirmasi;

    Data({
        required this.idMahasiswa,
        required this.status,
        required this.telahKonfirmasi,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idMahasiswa: json["id_mahasiswa"],
        status: json["status"],
        telahKonfirmasi: json["telah_konfirmasi"],
    );

    Map<String, dynamic> toJson() => {
        "id_mahasiswa": idMahasiswa,
        "status": status,
        "telah_konfirmasi": telahKonfirmasi,
    };
}
