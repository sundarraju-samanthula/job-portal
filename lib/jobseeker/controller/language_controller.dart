import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();

  var locale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    String? savedLang = _box.read('lang');

    if (savedLang != null) {
      if (savedLang == 'te') {
        locale.value = const Locale('te', 'IN');
      }
    }

    Get.updateLocale(locale.value);
  }

  void changeToEnglish() {
    locale.value = const Locale('en', 'US');
    Get.updateLocale(locale.value);
    _box.write('lang', 'en');
  }

  void changeToTelugu() {
    locale.value = const Locale('te', 'IN');
    Get.updateLocale(locale.value);
    _box.write('lang', 'te');
  }
}
