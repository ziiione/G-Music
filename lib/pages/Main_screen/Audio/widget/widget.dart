// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:provider/provider.dart';
import '../../../../common/Provider/SongProvider.dart';
import '../../../../common/utils/height_width.dart';

//mini music visualizer widget which is used to visualize the music when it is playing
class Mini_music_visualizer extends StatelessWidget {
  const Mini_music_visualizer({
    super.key,
required this.value
  });
 final bool value;

  @override
  Widget build(BuildContext context) {
    return MiniMusicVisualizer(
      color: Colors.white,
      width: 4,
      height: 18,
      radius: 2,
      animate: value,
    );
  }
}


//audio row header of the page which contains shuffle button ,the number of songs  next and previous button
class RowHeader extends StatelessWidget {
  const RowHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SongProvider>(context);
    return SizedBox(
      height: getHeight(context) * 0.025,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: getWidth(context) * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${provider.getSongs().length}',
                    style: const TextStyle(color: Colors.white)),
                InkWell(
                  onTap: () {
                    provider.shuffle_song();
                  },
                  child: Icon(
                      provider.is_shuffling
                          ? Icons.shuffle
                          : Icons.double_arrow,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            width: getWidth(context) * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      if (provider.currentSong != null) {
                        provider.previous_song(provider.currentSong!);
                      } else {
                        return;
                      }
                    },
                    child: const Icon(Icons.skip_previous,
                        color: Colors.white)),
                InkWell(
                    onTap: () {
                      if (provider.currentSong != null) {
                        provider.next_song(provider.currentSong!);
                      } else {
                        return;
                      }
                    },
                    child: const Icon(Icons.skip_next,
                        color: Colors.white)),
                const Icon(Icons.check_circle_outline,
                    color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}