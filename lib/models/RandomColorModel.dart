
class RandomColorModel {
  final int id;
  final String hexValue;
  final  String colorName;

  const RandomColorModel({
    required this.id,
    required this.hexValue,
    required this.colorName,
  });

  factory RandomColorModel.fromJson(Map<String, dynamic> json) {
    return RandomColorModel(
      id: json['id'],
      hexValue: json['hex_value'],
      colorName: json['color_name'],
    );
  }
}


