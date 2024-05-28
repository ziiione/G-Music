
import 'package:permission_handler/permission_handler.dart';

// Function to get storage permission and file access permission
Future<bool> requestPermission() async {
  // Request storage permission
  var storagePermissionStatus = await Permission.storage.request();
  if (storagePermissionStatus.isGranted) {
    // Storage permission granted, request file access permission
    var fileAccessPermissionStatus = await Permission.manageExternalStorage.request();
    if (fileAccessPermissionStatus.isGranted) {
      // File access permission granted
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
