

class RandomUserModel {
  final int id;
  final String first_name;
  final String last_name;

  const RandomUserModel({
    required this.id,
    required this.first_name,
    required this.last_name,
  });

  factory RandomUserModel.fromJson(Map<String, dynamic> json) {
    return RandomUserModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }
}

