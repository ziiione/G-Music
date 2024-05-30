// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:g_application/pages/Main_screen/Audio/screen/AudioPlay.dart';
import '../../../../common/utils/bottomSheet.dart';
import '/pages/getting_permission/permission.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../common/Provider/SongProvider.dart';
import '../../../../common/utils/image_artwork.dart';
import '../widget/widget.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});

  static const routeName = '/audio_player';

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 0), () async {
      var status = await Permission.storage.request();

      if (status.isGranted) {
        await Provider.of<SongProvider>(context, listen: false)
            .storagePermission();
        setState(() {});
      } else {
        //code to handle the permission denied case
        Navigator.pushReplacementNamed(context, permission_page.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // row Header of the audio player page which contains shuffle button ,the number of songs  next and previous button
            const RowHeader(),

            // list of songs
            Expanded(
              child: ListView.builder(
                  itemCount: provider.getSongs().length,
                  itemBuilder: (context, index) {
                    final real = provider.getSongs()[index];
                    return ListTile(
                      onTap: () {
                        provider.stop_Song();
                        provider.play_song(real);
                        Navigator.pushNamed(context, Audioplay.routeName);
                      },
                      leading: album_image(
                          id: real.albumId!, type: ArtworkType.ALBUM),
                      title: Text(real.title,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text('${real.artist}',
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if ((provider.currentSong != null) &&
                              (provider.currentSong!.id == real.id))
                            ValueListenableBuilder<bool>(
                              valueListenable: provider.isPlayingNotifier,
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return Mini_music_visualizer(value:  value,);
                              },
                            ),
                          IconButton(
                            onPressed: () {
                              buttomsheet(context, real);
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}

