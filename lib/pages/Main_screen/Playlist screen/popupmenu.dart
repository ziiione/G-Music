import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/Provider/playlistProvider.dart';

class PopupMenuBottom extends StatelessWidget {
  final String playlistName;
  const PopupMenuBottom({super.key, required this.playlistName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert, color: Colors.white.withOpacity(0.7)),
      color: Colors.white,
      onSelected: (value) {
        if (value == 1) {
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