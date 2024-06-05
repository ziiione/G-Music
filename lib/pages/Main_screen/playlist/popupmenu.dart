import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../common/Provider/playlistProvider.dart';

class PopupMenuBottom extends StatelessWidget {
  final String playlistName;
  final PlaylistModel playlistModel;
  const PopupMenuBottom({super.key, required this.playlistName,required this.playlistModel});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert, color: Colors.white.withOpacity(0.7)),
      color: Colors.white,
      onSelected: (value) {
        if (value == 1) {
          rename(context, playlistName,playlistModel);

        } else if (value == 2) {
          Provider.of<playlistProvider>(context, listen: false)
              .deletePlaylist(playlistName);
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<int>(
            value: 1,
            child: Text('Rename'),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text('Delete'),
          ),
        ];
      },
    );
  }
}

//showing the popup to rename the playlist
void rename(BuildContext context, String playlistName, PlaylistModel playlistModel) {
  TextEditingController playlistNameController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rename Playlist'),
        content: TextField(
          controller: playlistNameController,
          decoration: const InputDecoration(hintText: 'Enter Playlist Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<playlistProvider>(context,listen: false )
                  .renamePlaylist(playlistModel.playlist, playlistNameController.text);
              Navigator.pop(context);
            },
            child: const Text('Rename'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}