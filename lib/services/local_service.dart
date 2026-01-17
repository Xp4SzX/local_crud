import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mahasiswa.dart';

class LocalService {
  static const key = 'mahasiswa';

  Future<List<Mahasiswa>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map((e) => Mahasiswa.fromJson(jsonDecode(e))).toList();
  }

  Future<void> tambah(Mahasiswa m) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.add(jsonEncode(m.toJson()));
    await prefs.setStringList(key, list);
  }

  Future<void> hapus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.removeAt(index);
    await prefs.setStringList(key, list);
  }
}
