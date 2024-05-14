import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:quranringkas/app/contants/colour.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  WakelockPlus.enable();
  setInterruptionFilter();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: box.read("themeDark") == null ? themeLight : themeDark,
      // darkTheme: themeDark,
      title: "quranringkas",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}

void setInterruptionFilter() async {
  // Mendapatkan izin akses kebijakan pemberitahuan
  final bool? isNotificationPolicyAccessGranted =
      await FlutterDnd.isNotificationPolicyAccessGranted;

  if (isNotificationPolicyAccessGranted != null &&
      isNotificationPolicyAccessGranted) {
    // Set filter DND sesuai kebutuhan
    await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
  }
}

// await FlutterDnd.setInterruptionFilter(
//       FlutterDnd.INTERRUPTION_FILTER_NONE); 