import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'app/general/appThemes.dart';
import 'app/general/getStorageKey.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final _getStorage = GetStorage();
  bool isDarkMode = _getStorage.read(GetStorageKey.IS_DARK_MODE) ?? false;
  _getStorage.write(GetStorageKey.IS_DARK_MODE, isDarkMode);
  WakelockPlus.enable();
  setInterruptionFilter();

  runApp(ThemeProvider(
    initTheme: isDarkMode ? AppThemes.darkThemeData : AppThemes.lightThemeData,
    child: Builder(
      builder: (context) => GetMaterialApp(
        title: "quran ringkas",
        initialRoute: Routes.INTRODUCTION,
        getPages: AppPages.routes,
        theme: ThemeModelInheritedNotifier.of(context)
            .theme, // Menggunakan ThemeModelInheritedNotifier.of(context)
        darkTheme: AppThemes.darkThemeData,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRightWithFade,
      ),
    ),
  ));
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