// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_application/common/widget/snackbar.dart';
import 'package:on_audio_query/on_audio_query.dart';



/** -------------------------Setting the Ringtone------------------------------- */
class RingtoneSetter {
  static const platform = const MethodChannel('com.example.myapp/ringtone');
  static Future<bool> setRingtone(SongModel song) async {
    try {
      final bool success =
          await platform.invokeMethod('setRingtone', {'uri': song.uri});
      
      return success;
    } on PlatformException catch (e) {
      print("Failed to set ringtone: '${e.message}'.");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
 void setRingtonePopup(BuildContext context, SongModel song) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,
          title: const Text('Are you sure to set this as Ringtone?',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
               onPressed: () async {
                // code to delete the song
                
                bool success = false;
                try {
                  await RingtoneSetter.setRingtone(song);
                  // provider.delete_song(provider.currentSong);
                  success = true;
                } on PlatformException {
                  success = false;
                }
               
                if (success) {
                  showSnackBar(context, "Ringtone set successfully!");
                } else {
                const SnackBar(content: Text("Error"));
                }
             
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }


  /** --------------------------Deleting the song from device-------------------------------- */


class SongDeleter {
  static const platform = const MethodChannel('com.example.myapp/ringtone');
  static Future<bool> deleteSong(SongModel song) async {
    try {
      print('Deleting song with URI: ${song.uri}');
      final bool success =
          await platform.invokeMethod('deleteSong', {'uri': song.uri});
      print('method called successfully');
      return success;
    } on PlatformException catch (e) {
      print("Failed to delete song: '${e.message}'.");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

  // function to show the alert dialog for the delete the song
  void deleteSongPopup(BuildContext context, SongModel song) {
   
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,
          title: const Text('Are you sure to Delete this Song?',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // code to delete the song
                
                bool success = false;
                try {
                     SongDeleter.deleteSong(song);
                  // provider.delete_song(provider.currentSong);
                  success = true;
                } on PlatformException {
                  success = false;
                }
              
                if (success) {
                  showSnackBar(context, 'Song deleted successfully!');
                } else {
                  const SnackBar(content: Text("Error"));
                }
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }