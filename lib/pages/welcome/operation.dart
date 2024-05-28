import 'package:shared_preferences/shared_preferences.dart';

//function to save the status of the welcome page
Future<void> saveWelcomePageStatus() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('welcomePageShown', true);
}

//function to get the status of the welcome page
Future<bool> getWelcomePageStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('set status of welcome page');
  print(prefs.getBool('welcomePageShown') ?? false);
  return prefs.getBool('welcomePageShown') ?? false;
}