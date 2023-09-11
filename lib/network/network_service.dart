import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/RandomColorModel.dart';
import '../models/RandomNameModel.dart';
import '../models/RandomUserModel.dart';
import '../utils/api_urls.dart';
import '../utils/services/sharedPrefrence.dart';


class NetworkService {

  Future<RandomNameModel> fetchName() async {
    final response = await http
        .get(Uri.parse(Urls.base_url + Urls.randomName));

    if (response.statusCode == 200) {

      return RandomNameModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load names');
    }
  }


  Future<String?> fetchRandomColor() async {
    final response = await http
        .get(Uri.parse(Urls.base_url + Urls.randomColor));
    Map<String, dynamic> value = json.decode(response.body);

    if (response.statusCode == 200) {
      var color = value['hex_value'];
      print("Color from api ${color}");
      SharedPrefrence().setColor(color);

    } else {
      throw Exception('Failed to load colors');
    }
  }

  Future<RandomUserModel> fetchUser() async {
    final response = await http
        .get(Uri.parse(Urls.base_url + Urls.randomName));
    Map<String, dynamic> value = json.decode(response.body);
    if (response.statusCode == 200) {
      var firsName = value['first_name'];
      var lastName = value['last_name'];
      var  conCateName=firsName+lastName;
      SharedPrefrence().setName(conCateName);
      return RandomUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load names');
    }
  }

}
