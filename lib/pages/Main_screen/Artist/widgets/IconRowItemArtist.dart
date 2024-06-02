import 'package:flutter/material.dart';
import 'package:g_application/common/utils/screen/Equalizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../common/utils/bottomSheet.dart';


class IconRowItemArtist extends StatelessWidget {
  const IconRowItemArtist({
    required this.song,
    super.key,
  });
 final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EqualizerPage.routeName);
            },
            icon: const Icon(
              Icons.equalizer,
              color: Colors.white,
              size: 34,
            )),
        IconButton(
            onPressed: () {
              playlist_bottom_sheet(context,song);
            },
            icon: const Icon(
              Icons.playlist_add,
              color: Colors.white,
              size: 34,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 34,
            )),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.library_music,
              color: Colors.white,
              size: 34,
            )),
        InkWell(
            child: IconButton(
                onPressed: () async {
                  //get the absolute path of the song from uri
                  // final filePath =
                  //     await LecleFlutterAbsolutePath.getAbsolutePath(
                  //         uri: provider.currentSong.uri.toString());
    
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AudioTrimmerView(
                  //             file: File(filePath!))));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 34,
                ))),
      ],
    );
  }
}
