// To parse this JSON data, do
//
//     final randomNameModel = randomNameModelFromJson(jsonString);


import 'dart:convert';

class RandomNameModel {
  final int id;
  final String name;

  const RandomNameModel({
    required this.id,
    required this.name,
  });

  factory RandomNameModel.fromJson(Map<String, dynamic> json) {
    return RandomNameModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
