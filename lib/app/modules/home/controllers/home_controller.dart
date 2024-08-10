import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quranringkas/app/contants/colour.dart';
import 'package:quranringkas/app/data/db/markah_db.dart';
import 'package:quranringkas/app/data/model/juz.dart';
import 'package:quranringkas/app/data/model/surah.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../general/appThemes.dart';
import '../../../general/getStorageKey.dart';

class HomeController extends GetxController {
  // RxBool isDark = false.obs;
  final Uri _url = Uri.parse('https://spektrumku.com');
  final Uri _url2 =
      Uri.parse('https://play.google.com/store/apps/details?id=com.spektrumku');

  late final GetStorage _getStorage;
  var isDarkMode = false.obs;

  void onInit() {
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _getStorage = GetStorage();
    isDarkMode.value = _getStorage.read(GetStorageKey.IS_DARK_MODE);
  }

  void changeTheme(BuildContext context) {
    final theme =
        Get.isDarkMode ? AppThemes.lightThemeData : AppThemes.darkThemeData;
    ThemeSwitcher.of(context).changeTheme(theme: theme);
    if (_getStorage.read(GetStorageKey.IS_DARK_MODE)) {
      _getStorage.write(GetStorageKey.IS_DARK_MODE, false);
      isDarkMode.value = false;
    } else {
      _getStorage.write(GetStorageKey.IS_DARK_MODE, true);
      isDarkMode.value = true;
    }
  }

  // void changeThemeMode() async {
  //   Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
  //   isDark.toggle();

  //   Get.find<HomeController>().update();

  //   final box = GetStorage();

  //   if (Get.isDarkMode) {
  //     await box.remove("themeDark");
  //   } else {
  //     await box.write("themeDark", true);
  //   }
  // }

  Future<void> goUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> goUrl2() async {
    if (!await launchUrl(_url2,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  List<Surah> datasurah = [];

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1",
    );

    if (dataLastRead.isEmpty) {
      // tidak ada data
      return null;
    } else {
      // ada datanya
      return dataLastRead.first;
    }
  }

  DatabaseManager database = DatabaseManager.instance;

  void hapusMarkah(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");

    update();
    Get.back();
    Get.snackbar("Berhasil", "Markah berhasil dihapus akh..",
        colorText: darkblue);
  }

  Future<List<Map<String, dynamic>>> getMarkah() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark = await db.query(
      "bookmark",
      where: "last_read = 0",
      orderBy: "number_surah",
    );
    return allBookmark;
  }

  Future<List<Surah>> allsurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      datasurah = data.map((e) => Surah.fromJson(e)).toList();
      return datasurah;
    }
  }
  // Future<List<Surah>> allsurah() async {
  //   String data = await rootBundle.loadString("assets/json/surah.json");
  //   // print(data);
  //   return surahFromJson(data);
  // }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      String data = await rootBundle.loadString("assets/json/juz/$i.json");

      Map<String, dynamic> alldata =
          (json.decode(data) as Map<String, dynamic>)["data"];
      // print(alldata);
      Juz juz = Juz.fromJson(alldata);
      allJuz.add(juz);
    }
    return allJuz;
  }
}
