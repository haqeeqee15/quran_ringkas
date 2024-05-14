import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:quranringkas/app/contants/colour.dart';
import 'package:quranringkas/app/data/model/detailsurah.dart' as detail;
import 'package:quranringkas/app/data/model/surah.dart';
import 'package:quranringkas/app/modules/home/controllers/home_controller.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  // final Surah surah = Get.arguments;
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: yellow,
          title: Text(
            'Surah ${Get.arguments["name"]}',
            style: GoogleFonts.poppins(
                color: lightblue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<detail.DetailSurah>(
            future:
                controller.getDetailSurah(Get.arguments["number"].toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("tidak ada data akh.."),
                );
              }

              if (Get.arguments["bookmark"] != null) {
                bookmark = Get.arguments["bookmark"];
                controller.scrollC.scrollToIndex(bookmark!["index_ayat"] + 2,
                    preferPosition: AutoScrollPosition.begin);
              }
              print(bookmark);

              detail.DetailSurah surah = snapshot.data!;

              List<Widget> allAyat = List.generate(
                snapshot.data?.verses?.length ?? 0,
                (index) {
                  detail.Verse? ayat = snapshot.data?.verses?[index];
                  return AutoScrollTag(
                    key: ValueKey(index + 2),
                    index: index + 2,
                    controller: controller.scrollC,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      radius: 100,
                      splashColor: yellow,
                      hoverDuration: Durations.medium3,
                      onDoubleTap: () async {
                        await controller.addBookmark(
                            true, snapshot.data!, ayat, index);
                        homeC.update();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            color: const Color.fromARGB(255, 34, 52, 83),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svgs/nomor-surah.svg'),
                                      SizedBox(
                                          height: 36,
                                          width: 36,
                                          child: Center(
                                            child: Text(
                                              "${ayat!.number?.inSurah}",
                                              style: GoogleFonts.poppins(
                                                  color: yellow, fontSize: 10),
                                            ),
                                          )),
                                    ],
                                  ),
                                  GetBuilder<DetailSurahController>(
                                    builder: (c) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title: "Markah Qur'an",
                                                titleStyle: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600),
                                                middleText:
                                                    "Mau dijadiin apaaa?",
                                                middleTextStyle:
                                                    GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await controller
                                                            .addBookmark(
                                                                true,
                                                                snapshot.data!,
                                                                ayat,
                                                                index);
                                                        homeC.update();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Get.isDarkMode
                                                                      ? putih
                                                                      : darkblue),
                                                      child: Text(
                                                        "Terakhir Baca",
                                                        style: GoogleFonts.poppins(
                                                            color:
                                                                Get.isDarkMode
                                                                    ? darkblue
                                                                    : lightblue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        controller.addBookmark(
                                                            false,
                                                            snapshot.data!,
                                                            ayat,
                                                            index);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromRGBO(
                                                                      246,
                                                                      176,
                                                                      66,
                                                                      1.0)),
                                                      child: Text(
                                                        "Markah",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: hitam,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ))
                                                ]);
                                          },
                                          icon: Icon(
                                            Icons.bookmark_add_rounded,
                                            color: lightblue,
                                          ),
                                        ),
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
                                                  (ayat.kondisiAudio ==
                                                          "playing")
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
                            style: GoogleFonts.amiri(
                                height: 2.2,
                                fontSize: 30,
                                color: Get.isDarkMode ? putih : darkblue),
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
                                color: Get.isDarkMode ? lightblue : artinya),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

              // udh pasti ada datanya
              return ListView(
                controller: controller.scrollC,
                padding: EdgeInsets.all(20),
                children: [
                  AutoScrollTag(
                    key: ValueKey(0),
                    index: 0,
                    controller: controller.scrollC,
                    child: GestureDetector(
                      onTap: () => Get.defaultDialog(
                        backgroundColor: putih.withOpacity(.8),
                        title:
                            "Tafsir Surah ${surah.name!.transliteration?.id}",
                        titleStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: darkblue),
                        titlePadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        content: Container(
                          child: Text(
                            "${surah.tafsir?.id ?? 'tidak ada data tafsir akh'}",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(color: darkblue),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
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
                                children: [
                                  Text(
                                    "${surah.name!.transliteration?.id}",
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
                                    "${surah.name!.translation?.id}",
                                    style: GoogleFonts.poppins(
                                      color: darkblue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Divider(
                                    color: darkblue,
                                    thickness: 2,
                                    height: 32,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${surah.revelation!.id}",
                                        style: GoogleFonts.poppins(
                                            color: darkblue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: darkblue),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${surah.numberOfVerses} Ayat",
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
                  ),
                  AutoScrollTag(
                    key: ValueKey(1),
                    index: 1,
                    controller: controller.scrollC,
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  ...allAyat,
                ],
              );
            }));
  }
}
