import 'package:shared_preferences/shared_preferences.dart';

class Deptclass {
  static const String _itemsKey = 'tasklist';

  // Save the list of departments to SharedPreferences
  static Future<void> saveTask(List<String> tasks,List<String> completeTask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_itemsKey, tasks);
    await prefs.setStringList("completedtask", completeTask);
  }

  // Load the list of departments from SharedPreferences
  static Future<List<String>> loadTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_itemsKey) ?? [];
  }
  static Future<List<String>> completedTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("completedtask") ?? [];
  }

}