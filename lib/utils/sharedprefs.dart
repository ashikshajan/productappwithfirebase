import 'package:shared_preferences/shared_preferences.dart';
import 'package:techware_machinetest/utils/Utils.dart';

class SharedPrefsUtil {
  static const String loggedin = 'loggedin';

  static getBool(String spKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(spKey) // bool loggedIn
        ? prefs.getBool(spKey) //true     //prefs.getBool(spKey)
        : false;
  }

  static Future<bool> getBoolSwitch(String spKey) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(spKey) // bool loggedIn = await loggincheck();
        ? true //prefs.getBool(spKey)
        : false;
  }

  static Future<bool> putBool(String? spKey, bool? value) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Log.print("$value is saved to $spKey");
    return await prefs.setBool(spKey!, value!);
  }

  static Future<String?> getString(String spKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(spKey) ? prefs.getString(spKey) : '';
  }

  static Future<bool> putString(String spKey, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Log.print("$value is saved to $spKey");

    return await prefs.setString(spKey, value!);
  }

  static Future<int?> getInt(String spKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(spKey) // bool loggedIn = await loggincheck();
        ? prefs.getInt(spKey)
        : 0;
  }

  static Future<bool> putInt(String spKey, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Log.print("$value is saved to $spKey");
    return await prefs.setInt(spKey, value);
  }

  static Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(loggedin);

    return true;
  }
}
