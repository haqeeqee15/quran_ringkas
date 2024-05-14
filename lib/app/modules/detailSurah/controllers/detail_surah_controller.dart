import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quranringkas/app/contants/colour.dart';
import 'package:quranringkas/app/data/db/markah_db.dart';
import 'package:quranringkas/app/data/model/detailsurah.dart';

class DetailSurahController extends GetxController {
  AutoScrollController scrollC = AutoScrollController();
  final player = AudioPlayer();
  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query(
        "bookmark",
        where:
            "surah = ? AND number_surah = ? AND ayat = ? AND juz = ? AND via = 'surah' AND index_ayat = ? AND last_read = 0",
        whereArgs: [
          surah.name!.transliteration!.id,
          surah.number,
          ayat.number!.inSurah,
          ayat.meta!.juz!,
          indexAyat,
        ],
      );
      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }
    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id}",
        "number_surah": surah.number,
        "ayat": ayat.number!.inSurah,
        "juz": ayat.meta!.juz!,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil menambahkan Markah",
          colorText: darkblue);
    } else {
      Get.back();
      Get.snackbar("Gagal", "mungkin akh udah ditambahkan",
          colorText: Colors.red[400]);
    }
    var data = await db.query("bookmark");
    // print(data);
  }

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: e.message.toString());
      // } on PlayerInterruptedException catch (e) {
      //   Get.defaultDialog(
      //       title: "ada yang aneh nih",
      //       middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: "ngga bisa stop audionya");
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: e.message.toString());
      // } on PlayerInterruptedException catch (e) {
      //   Get.defaultDialog(
      //       title: "ada yang aneh nih",
      //       middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: "ngga bisa resume audionya");
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: e.message.toString());
      // } on PlayerInterruptedException catch (e) {
      //   Get.defaultDialog(
      //       title: "ada yang aneh nih",
      //       middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: "ngga bisa pause audionya");
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      // Catching errors at load time
      try {
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "ada yang aneh nih", middleText: e.message.toString());
        // } on PlayerInterruptedException catch (e) {
        //   Get.defaultDialog(
        //       title: "ada yang aneh nih",
        //       middleText: "Connection aborted: ${e.message}");
      } catch (e) {
        Get.defaultDialog(
            title: "ada yang aneh nih",
            middleText: "ngga bisa diputar audionya");
      }
    } else {
      Get.defaultDialog(
          title: "ada yang aneh nih", middleText: "url audio tidak ada nih");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}

// class DetailSurahController extends GetxController {
//   Future<DetailSurah> getDetailSurah(int id) async {
//     try {
//       String jsonString =
//           await rootBundle.loadString("assets/json/surah/$id.json");
//       Map<String, dynamic> data = json.decode(jsonString);

//       return DetailSurah.fromJson(data);
//     } catch (e) {
//       // Handle kesalahan jika terjadi error dalam membaca file atau parsing JSON
//       throw Exception("Failed to load surah details. Error: $e");
//     }
//   }
// }

  // pake lokal
  // Future<DetailSurah> detailsurah(int id) async {
  //   String data = await rootBundle.loadString("assets/json/surah/$id.json");
  //   // print(data);
  //   return detailSurahFromJson(data);
  // }