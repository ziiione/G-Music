// function to show the popup menu button for input of playlist name
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/Provider/SongProvider.dart';
import '../../../../common/Provider/playlistProvider.dart';

void PlaylistPopup(BuildContext context) {
    TextEditingController controller = TextEditingController();
  //  final ui = Provider.of<Ui_changer>(
  //     context,
  //     listen: false,
  //   );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xff121212),
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
                borderSide:
                    BorderSide(color: Colors.white),
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

                if (controller.text.isNotEmpty) {
                  Provider.of<playlistProvider>(
                    context,
                    listen: false
                  ).createPlaylist(controller.text);

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

// showing the list tile of the song in the playlist

ListTile buildStaticListTile(int index, BuildContext context, int? rowCount) {
  String title;
  IconData icon;
  Widget subtitle;
  String noOfSongs='22';
  
  switch (index) {
    case 0:
      title = 'Favourites';
      icon = Icons.favorite;
      subtitle = Text(
        '${noOfSongs} songs',
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
      );
      break;
   
    case 1:
      title = 'Recently Played';
      icon = Icons.playlist_add;
     subtitle =Text('$rowCount songs',style: TextStyle(color: Colors.white.withOpacity(0.7),),);
      break;
 
    default:
      title = '';
      icon = Icons.favorite_border;
      subtitle = Text(
        '20 songs',
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
      );
  }

  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    leading: Icon(
      icon,
      color: index == 0 ? Colors.red : Colors.white.withOpacity(0.7),
    ),
    subtitle: subtitle,
    onTap: () {
      // Navigator.pushNamed(context, recent_played_songs.routeName);
    },
  );
}
