import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quranringkas/app/general/appThemes.dart';

import 'getStorageKey.dart';

class AppColors {
  var kPrimaryTextColor = GetStorage().read(GetStorageKey.IS_DARK_MODE)
      ? putih
      : lightblue;
  var kSecondaryTextColor = GetStorage().read(GetStorageKey.IS_DARK_MODE)
      ? putih
      : lightblue;
  var kBlackColor = Colors.black;
}
