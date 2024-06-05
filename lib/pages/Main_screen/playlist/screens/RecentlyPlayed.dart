import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/SongProvider.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Recentlyplayed extends StatefulWidget {
  const Recentlyplayed({super.key});
  static const routeName = '/recent_played_songs';

  @override
  State<Recentlyplayed> createState() => _RecentlyplayedState();
}

class _RecentlyplayedState extends State<Recentlyplayed> {
  @override
  Widget build(BuildContext context) {
   
    final provider = Provider.of<SongProvider>(context, listen: false);
    final ValueNotifier<bool> playing = ValueNotifier(provider.isplaying);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recently Played',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: provider.queryAllRows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  leading: QueryArtworkWidget(
                    quality: 100,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(25),
                    artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Image.asset('assets/images/music_symbol2.png'),
                    id: item['albumId'],
                    type: ArtworkType.ALBUM,
                  ),
                  title: Consumer<SongProvider>(
                      builder: (context, provider, child) {
                    return Text('${item['title']}',
                        maxLines: 1, style: const TextStyle(color: Colors.white));
                  }),
                  subtitle: Consumer<SongProvider>(
                      builder: (context, provider, child) {
                    return Text('${item['artist']}',
                        maxLines: 1, style: const TextStyle(color: Colors.grey));
                  }),
                  trailing: Consumer<SongProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if ((provider.currentSong!.albumId == item['albumId']) &&
                            (provider.currentSong!.artist == item['artist']) &&
                            (provider.currentSong!.title == item['title']))
                          ValueListenableBuilder<bool>(
                            valueListenable: playing,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return MiniMusicVisualizer(
                                color: Colors.white,
                                width: 4,
                                height: 18,
                                radius: 2,
                                animate: value,
                              );
                            },
                          ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              // provider.deleteAll();
                            });
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        )
                      ],
                    );
                  }),
                );
              },
            );
          }),
    );
  }
}
