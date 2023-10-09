import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreHelper {
  writeTheData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  Future<dynamic> readTheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  deleteTheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clearTheData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> saveColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('color', color.value);
  }

  Future<Color> readColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int colorValue = prefs.getInt('color') ?? Colors.blue.value;
    return Color(colorValue);
  }

  /* Future<dynamic> writeLoginResponse(String key, LoginData logindata) async {
    final prefs = await SharedPreferences.getInstance();
    String modelDataJson = json.encode(logindata); // Convert the data to JSO
    await prefs.setString(key, modelDataJson);
    return prefs.get(key);
  } */

  /* Future<LoginData> readLogin(String key) async {
    var loginData = LoginData();
    final prefs = await SharedPreferences.getInstance();

    String? modelDataJson = prefs.getString(key);

    if (modelDataJson != null) {
      Map<String, dynamic> modelData = json.decode(modelDataJson);
      loginData = LoginData.fromJson(modelData);
      return loginData ;
      
    }
    return loginData;
  } */
}
