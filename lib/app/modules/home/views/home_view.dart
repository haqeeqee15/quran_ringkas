import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quranringkas/app/contants/colour.dart';
import 'package:quranringkas/app/data/model/juz.dart' as juz;
import 'package:quranringkas/app/modules/home/views/tnc.dart';
import 'package:quranringkas/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => controller.changeThemeMode(),
            icon: Obx(
              () => controller.isDark.isTrue
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
            ),
          ),
        ],
        title: Text(
          "Quran Ringkas",
          style: GoogleFonts.poppins(
              color: lightblue, fontSize: 28, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      // Tambahkan GetDrawer di sini
      drawer: Drawer(
        backgroundColor: Get.isDarkMode ? darkblue : putih,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Center(
                    child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/pngs/lg1.png",
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Quran\nRingkas",
                      style: GoogleFonts.poppins(
                          color: lightblue,
                          fontSize: 28,
                          height: 1.15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(
                  "( v  1 . 0 . 8 )",
                  style: GoogleFonts.poppins(
                      color: lightblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                )
              ],
            ))),
            ListTile(
              leading: Icon(
                Icons.volunteer_activism,
                color: yellow,
              ),
              title: Text(
                "Donasi",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Close drawer dan lakukan navigasi atau tindakan lainnya
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.grade, color: yellow),
              title: Text(
                "Nilai Aplikasi!",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                controller.goUrl2();
                // Close drawer dan lakukan navigasi atau tindakan lainnya
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.share_rounded, color: yellow),
              title: Text(
                "Berbagi Aplikasi!",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Share.share('com.spektrumku.Quran_Ringkas');
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support, color: yellow),
              title: Text(
                "Bantuan dan Dukungan",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                controller.goUrl();
                // Close drawer dan lakukan navigasi atau tindakan lainnya
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.description, color: yellow),
              title: Text(
                "Syarat dan Ketentuan",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Get.to(() => TnC());
              },
            ),
            ListTile(
              leading: Icon(Icons.security, color: yellow),
              title: Text(
                "Kebijakan Privasi",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                controller.goUrl();
                // Close drawer dan lakukan navigasi atau tindakan lainnya
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: yellow),
              title: Text(
                "Tentang Kami",
                style: GoogleFonts.poppins(
                    color: lightblue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                controller.goUrl();
                // Close drawer dan lakukan navigasi atau tindakan lainnya
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Assalamu'alaikum",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Get.isDarkMode ? putih : darkblue),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Calon Penghuni Surga",
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Get.isDarkMode ? putih : darkblue),
            ),
            const SizedBox(height: 18),
            GetBuilder<HomeController>(
              builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                future: controller.getLastRead(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              darkblue,
                              lightblue,
                              const Color.fromARGB(255, 13, 189, 212),
                            ],
                            stops: const [0, .8, 1],
                          )),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -30,
                            right: 0,
                            child: Opacity(
                              opacity: .4,
                              child: Container(
                                  width: 170,
                                  height: 170,
                                  child: SvgPicture.asset(
                                      'assets/svgs/quran.svg',
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/book.svg'),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Terakhir Baca',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Lagi ngeloaddd...",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                // SizedBox(height: 30,),
                                Text(
                                  "Lagi ngeloadd... | Lagi ngeloadd ...",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  Map<String, dynamic>? lastRead = snapshot.data;
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            lightblue,
                            darkblue,
                            const Color.fromARGB(255, 13, 189, 212),
                          ],
                          stops: const [0, .8, 1],
                        )),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onLongPress: () {
                          if (lastRead != null) {
                            Get.defaultDialog(
                                backgroundColor: putih,
                                title: "Hapus Terakhir Baca",
                                titleStyle: GoogleFonts.poppins(
                                    color: darkblue,
                                    fontWeight: FontWeight.w600),
                                middleText:
                                    "Anda yakin mau hapus last readnyaa?",
                                middleTextStyle: GoogleFonts.poppins(
                                    color: darkblue,
                                    fontWeight: FontWeight.w600),
                                actions: [
                                  OutlinedButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: putih),
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        c.hapusMarkah(lastRead['id']);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              246, 176, 66, 1.0)),
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: hitam),
                                      ))
                                ]);
                          }
                        },
                        onTap: () {
                          if (lastRead != null) {
                            // print(lastRead);
                            Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                              "name": lastRead["surah"],
                              "number": lastRead["number_surah"],
                              "bookmark": lastRead,
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -30,
                                right: 0,
                                child: Opacity(
                                  opacity: .4,
                                  child: Container(
                                      width: 170,
                                      height: 170,
                                      child: SvgPicture.asset(
                                          'assets/svgs/quran.svg',
                                          fit: BoxFit.contain)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/book.svg'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Terakhir Baca',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      lastRead == null
                                          ? ""
                                          : "${lastRead['surah']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    // SizedBox(height: 30,),
                                    Text(
                                      lastRead == null
                                          ? "belum ada data"
                                          : "Ayat ${lastRead['ayat']} | Juz ${lastRead['juz']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            TabBar(
              dividerHeight: 2,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    "Surah",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Tab(
                  child: Text(
                    "Juz",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Tab(
                  child: Text(
                    "Markah",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                FutureBuilder<List<Surah>>(
                    future: controller.allsurah(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: lightblue,
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("tidak ada data akh.."),
                        );
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                  "name": surah.name.transliteration.id,
                                  "number": surah.number
                                });
                              },
                              leading: Stack(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svgs/nomor-surah.svg'),
                                  SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Center(
                                        child: Text(
                                          "${surah.number}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Get.isDarkMode
                                                ? putih
                                                : darkblue,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              title: Text(
                                surah.name.transliteration.id,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode ? putih : darkblue,
                                    fontSize: 16),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    surah.revelation.id.name,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : lightblue,
                                        fontSize: 10),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: yellow),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${surah.numberOfVerses} Ayat",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : lightblue,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                surah.name.short,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Get.isDarkMode ? lightblue : darkblue,
                                ),
                              ),
                            );
                          }));
                    }),
                FutureBuilder<List<juz.Juz>>(
                    future: controller.getAllJuz(),
                    builder: (context, snapshot) {
                      // print(snapshot.data);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: darkblue,
                            color: yellow,
                          ),
                        );
                      }
                      // if (!snapshot.hasData) {
                      //   return Center(
                      //     child: Text("tidak ada data akh.."),
                      //   );
                      // }
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: ((context, index) {
                            juz.Juz detailJuz = snapshot.data![index];

                            String nameStart =
                                detailJuz.juzStartInfo?.split(" - ").first ??
                                    "";
                            String nameEnd =
                                detailJuz.juzEndInfo?.split(" - ").first ?? "";

                            List<Surah> rawallSurahInJuz = [];
                            List<Surah> allSurahInJuz = [];

                            for (Surah item in controller.datasurah) {
                              rawallSurahInJuz.add(item);
                              if (item.name.transliteration.id == nameEnd) {
                                break;
                              }
                            }

                            for (Surah item
                                in rawallSurahInJuz.reversed.toList()) {
                              allSurahInJuz.add(item);
                              if (item.name.transliteration.id == nameStart) {
                                break;
                              }
                            }

                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                  "juz": detailJuz,
                                  "surah": allSurahInJuz.reversed.toList(),
                                });
                              },
                              leading: Stack(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svgs/nomor-surah.svg'),
                                  SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                      )),
                                ],
                              ),
                              title: Text(
                                "Juz ${detailJuz.juz}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color:
                                        Get.isDarkMode ? lightblue : darkblue),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "${detailJuz.juzStartInfo?.replaceAll(" - ", " : ")}",
                                    style: GoogleFonts.poppins(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : lightblue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                  Text(
                                    " - ",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${detailJuz.juzEndInfo?.replaceAll(" - ", " : ")}",
                                    style: GoogleFonts.poppins(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : lightblue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                "${detailJuz.totalVerses} ayat",
                                style: GoogleFonts.poppins(
                                    color:
                                        Get.isDarkMode ? lightblue : darkblue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }));
                    }),
                GetBuilder<HomeController>(
                  builder: (c) {
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getMarkah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'Anda sedang tidak \n menyimpan bookmark apapun niih...',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                  "name": data["surah"],
                                  "number": data["number_surah"],
                                  "bookmark": data,
                                });
                              },
                              leading: Stack(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svgs/nomor-surah.svg'),
                                  SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Get.isDarkMode
                                                  ? putih
                                                  : darkblue),
                                        ),
                                      )),
                                ],
                              ),
                              title: Text(
                                "${data['surah']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Ayat ${data['ayat']} - Juz ${data['juz']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  c.hapusMarkah(data['id']);
                                },
                                icon: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Get.isDarkMode
                                      ? lightblue
                                      : darkblue, // Change color as needed
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
