// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Provider/SongProvider.dart';

class album_image extends StatelessWidget {
  const album_image({
    super.key,
    required this.id,
   required this.type
  });

  final int id;
  final ArtworkType type;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      quality: 100,
      artworkBorder: BorderRadius.circular(25),
      artworkClipBehavior: Clip.antiAliasWithSaveLayer,
      keepOldArtwork: true,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: const CircleAvatar(
        radius: 23,
        child: Icon(Icons.music_note,
            color: Colors.white, size: 40),
      ),
      id: id,
      type: type,
    );
  }
}


class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.provider,
  });

  final SongProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.19,
      height: MediaQuery.of(context).size.height * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: QueryArtworkWidget(
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkBorder: BorderRadius.circular(8),
          artworkClipBehavior: Clip.antiAliasWithSaveLayer,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset('assets/images/cover.jpg', fit: BoxFit.cover),
          ),
          id: provider.currentSong!.albumId!,
          keepOldArtwork: true,
          type: ArtworkType.ALBUM,
        ),
      ),
    );
  }
}
