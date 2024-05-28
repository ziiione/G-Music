
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to get storage permission and file access permission
Future<bool> requestPermission() async {
  // Request storage permission
  var storagePermissionStatus = await Permission.storage.request();
  if (storagePermissionStatus.isGranted) {
    // Storage permission granted, request file access permission
    var fileAccessPermissionStatus = await Permission.manageExternalStorage.request();
    if (fileAccessPermissionStatus.isGranted) {

      // File access permission granted
      savePermissionStatus();
      return true;
    } else {
      // File access permission denied

      return false;
    }
  } else {
   // Storage permission denied
    return false;
  }
}
// function to save the status of the permission
Future<void> savePermissionStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('permissionGranted', true);
}

// function to get the status of the permission
Future<bool> getPermissionStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('permissionGranted') ?? false;
}

