
import 'package:shared_preferences/shared_preferences.dart';


final class Store {
  Store._internal();

  static final Store _instance = Store._internal();

  late SharedPreferences _preferences;

  factory Store() => _instance;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  SharedPreferences get getInstance  {
    return _preferences;
  }

}
