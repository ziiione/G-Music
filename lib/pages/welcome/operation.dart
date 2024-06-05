import 'package:shared_preferences/shared_preferences.dart';

//function to save the status of the welcome page
Future<void> saveWelcomePageStatus() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('welcomePageShown', true);
}

//function to get the status of the welcome page
Future<bool> getWelcomePageStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('welcomePageShown') ?? false;
}