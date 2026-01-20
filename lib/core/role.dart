import 'package:get_storage/get_storage.dart';

class RoleStore {
  static final _box = GetStorage();

  static const _roleKey = 'user_role';

  static void setRole(String role) {
    _box.write(_roleKey, role);
  }

  static String? getRole() {
    return _box.read(_roleKey);
  }

  static void clearRole() {
    _box.remove(_roleKey);
  }
}
