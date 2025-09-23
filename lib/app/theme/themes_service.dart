import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping/app/theme/themes_custom.dart';

class ThemeService {
  final storage = GetStorage();

  void getThemeMode() {
    if (storage.read("darkMode") != null) {
      if (isSaveDarkMode() == false) {
        Get.changeTheme(ThemeCustom.lightMode);
      } else {
        Get.changeTheme(ThemeCustom.darkMode);
      }
    } else {
      saveThemeMode(Get.isPlatformDarkMode);
      Get.changeTheme(
          isSaveDarkMode() ? ThemeCustom.darkMode : ThemeCustom.lightMode);
    }
  }

  bool isSaveDarkMode() {
    return storage.read("darkMode") ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    storage.write('darkMode', isDarkMode);
  }

  void changeThemeMode() {
    Get.changeTheme(
        isSaveDarkMode() ? ThemeCustom.lightMode : ThemeCustom.darkMode);
    saveThemeMode(!isSaveDarkMode());
  }
}
