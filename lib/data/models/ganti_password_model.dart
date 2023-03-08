// To parse this JSON data, do
//
//     final gantiPassword = gantiPasswordFromJson(jsonString);

import 'dart:convert';

GantiPassword gantiPasswordFromJson(String str) => GantiPassword.fromJson(json.decode(str));

String gantiPasswordToJson(GantiPassword data) => json.encode(data.toJson());

class GantiPassword {
    GantiPassword({
        required this.message,
    });

    String message;

    factory GantiPassword.fromJson(Map<String, dynamic> json) => GantiPassword(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
