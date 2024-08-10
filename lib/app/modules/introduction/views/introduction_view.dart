import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranringkas/app/routes/app_pages.dart';

import '../../../general/appThemes.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Image.asset(
              'assets/pngs/lg1.png',
              width: 100,
              height: 100,
            ),
            Text(
              "Quran\nRingkas",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: yellow,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.offAllNamed(Routes.HOME),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                decoration: BoxDecoration(
                    color: yellow, borderRadius: BorderRadius.circular(30)),
                child: Text('Ngaji kuy',
                    style: GoogleFonts.poppins(
                        color: hitam,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by',
                  style: GoogleFonts.poppins(
                    color: Get.isDarkMode ? putih : darkblue,
                  ),
                  // style: GoogleFonts.poppins(
                  //     fontSize: 14, fontWeight: FontWeight.w600, color: darkblue),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  'assets/pngs/logo-sidetext.png',
                  width: 80,
                  height: 80,
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
