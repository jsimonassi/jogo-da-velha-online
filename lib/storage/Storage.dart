import 'dart:async';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

///Redux chorouu
///Memória persistente do app. Métodos de acesso ao DB Local. (Cache persistente)
class Storage {

  ///Armazenar objeto
  static Future<void> save(String key, Map<String, dynamic> values) async {
    try {
      String jsonObject = jsonEncode(values);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonObject);
    } catch (e) {
      throw FormatException(e != null ? e.toString() : AppMessages.undefinedError);
    }
  }

  ///Resgatar objeto
  static Future<String> retrieve(String key) async {
    //Como não dá pra saber quem chamou, cada model deve implementar seu jsonDecoder
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      throw FormatException(
          e != null ? e.toString() : AppMessages.undefinedError);
    }
  }

  ///Apagar um objeto
  static Future<void> remove(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      throw FormatException(
          e != null ? e.toString() : AppMessages.undefinedError);
    }
  }

  ///Apagar todos os objetos
  static Future<void> clearAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      throw FormatException(
          e != null ? e.toString() : AppMessages.undefinedError);
    }
  }
}
