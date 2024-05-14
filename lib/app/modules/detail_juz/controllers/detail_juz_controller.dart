import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quranringkas/app/data/model/juz.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  final player = AudioPlayer();
  Verses? lastVerse;

  void stopAudio(Verses ayat) async {
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

  void resumeAudio(Verses ayat) async {
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

  void pauseAudio(Verses ayat) async {
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

  void playAudio(Verses? ayat) async {
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
}
