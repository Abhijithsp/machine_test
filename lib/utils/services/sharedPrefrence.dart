import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefrence {


  Future<bool> setName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("name", name);
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? '';
  }

  Future<bool> setColor(String color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("color", color);
  }

  Future<String> getColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("color") ?? '';
  }

  Future<bool> ClearName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("name");
  }

  Future<bool> ClearColor(String color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("color");
  }
}
