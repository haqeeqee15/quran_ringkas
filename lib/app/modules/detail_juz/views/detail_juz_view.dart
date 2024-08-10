import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:quranringkas/app/general/appThemes.dart';

import '../../../contants/colour.dart';
import '../../../data/model/juz.dart' as juz;
import '../../../data/model/surah.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];
  DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    allSurahInThisJuz.forEach((element) {
      print(element.name.transliteration.id);
    });
    return Scaffold(
      appBar: AppBar(
        foregroundColor: yellow,
        title: Text(
          'JUZ ${detailJuz.juz}',
          style: GoogleFonts.poppins(
              color: lightblue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Container(
              child: Stack(
                children: [
                  Container(
                    height: 257,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              0,
                              .6,
                              1
                            ],
                            colors: [
                              Color.fromARGB(255, 50, 142, 117),
                              Color.fromARGB(255, 112, 192, 253),
                              Color.fromARGB(255, 152, 250, 230),
                            ])),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                          opacity: .1,
                          child: SvgPicture.asset(
                            'assets/svgs/quran.svg',
                            width: 269,
                          ))),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Program ODOJ",
                          style: GoogleFonts.poppins(
                            color: darkblue,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          // "${surah.name!.translation?.id}",
                          "Estimasi waktu yang dihabiskan untuk membaca Juz ${detailJuz.juz} ini kira-kira 42 menit - 60 menit",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: darkblue,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        const Divider(
                          color: Colors.white38,
                          thickness: 2,
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // "${surah.revelation!.id}",
                              "${detailJuz.juzStartInfo?.replaceAll(" - ", " : ")}",
                              style: GoogleFonts.poppins(
                                  color: darkblue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "S/D",
                              style: GoogleFonts.poppins(color: darkblue),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              // "${surah.numberOfVerses} Ayat",
                              "${detailJuz.juzEndInfo?.replaceAll(" - ", " : ")}",
                              style: GoogleFonts.poppins(
                                  color: darkblue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SvgPicture.asset('assets/svgs/bismillah.svg'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              print(index);
              if (detailJuz.verses == null || detailJuz.verses!.isEmpty) {
                return const Center(
                  child: Text("tidak datanya akh..."),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
              if (index != 0) {
                if (ayat.number?.inSurah == 1) {
                  if (controller.index < allSurahInThisJuz.length - 1) {
                    controller.index++;
                  }
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 34, 52, 83),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              SvgPicture.asset('assets/svgs/nomor-surah.svg'),
                              SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: Center(
                                    child: Text(
                                      "${ayat.number?.inSurah}",
                                      style: GoogleFonts.poppins(
                                          color: yellow, fontSize: 10),
                                    ),
                                  )),
                            ],
                          ),
                          Text(
                              "${allSurahInThisJuz[controller.index].name.transliteration.id}",
                              style: GoogleFonts.poppins(
                                  color: lightblue,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600)),
                          GetBuilder<DetailJuzController>(
                            builder: (c) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (ayat.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(ayat);
                                        },
                                        icon: Icon(
                                          Icons.play_arrow_rounded,
                                          color: lightblue,
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (ayat.kondisiAudio == "playing")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(ayat);
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .pause_circle_filled_rounded,
                                                    color: lightblue,
                                                  ),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(ayat);
                                                  },
                                                  icon: Icon(
                                                    Icons.play_arrow,
                                                    color: lightblue,
                                                  ),
                                                ),
                                          IconButton(
                                            onPressed: () {
                                              c.stopAudio(ayat);
                                            },
                                            icon: Icon(
                                              Icons.stop_circle_rounded,
                                              color: lightblue,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat.text?.arab}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.amiri(height: 2.2, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat.translation?.id}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        decorationThickness: 1.0,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: Get.isDarkMode ? lightblue : hitam),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
