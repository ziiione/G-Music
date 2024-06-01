  // function to show the popup menu button for input of playlist name
  import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../Provider/playlistProvider.dart';

void createPlaylistPopup(BuildContext context,SongModel song) {
    TextEditingController controller = TextEditingController();
   

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,
          title: const Text('Create new Playlist',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter the playlist name',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // code to create the playlist

                if (!controller.text.isEmpty) {
                  Provider.of<playlistProvider>(
                    context,
                    listen: false,
                  ).addSongToPlaylist(controller.text, song);

                  Navigator.pop(context);
                } else {
                  return;
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
