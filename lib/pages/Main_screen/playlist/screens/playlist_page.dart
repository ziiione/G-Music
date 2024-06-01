import 'package:flutter/material.dart';
import 'package:g_application/pages/Main_screen/playlist/screens/PlaylistDetail.dart';
import '../../../../common/Provider/SongProvider.dart';
import '../widget/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../common/Provider/playlistProvider.dart';
import '../popupmenu.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  int? rowCount;

@override
void initState() {
  super.initState();
  fetchRowCount();
}

void fetchRowCount() async {
  rowCount = await Provider.of<SongProvider>(context, listen: false).getRowCount();
  setState(() {});
}
  @override
  Widget build(BuildContext context) {
      final provider=Provider.of<playlistProvider>(context);
    return   Column(
                children: [
                  ListTile(
                    title: Text(
                      'Playlist (${provider.playlists.length+2})',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          // code to create the playlist
                          PlaylistPopup(context);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white.withOpacity(0.7),
                        )),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics:const BouncingScrollPhysics(),
                      itemCount: provider.playlists.length + 2,
                      itemBuilder: (context, index) {
                        if (index < 2) {
                          // return your static ListTile widgets based on the index
                          return buildStaticListTile(index, context,rowCount);
                        } else {
                          var item = provider.playlists[index - 2];
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            onTap: () {
                              // code to navigate to the playlist detail page
                              Navigator.pushNamed(context, PlaylistDetail.routeName,
                                  arguments: {'playlist': item});

                            },
                            leading: QueryArtworkWidget(
                                quality: 100,
                                artworkBorder: BorderRadius.circular(100),
                                artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                artworkFit: BoxFit.cover,
                                keepOldArtwork: true,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset('assets/images/music_symbol1.png'),
                                ),
                                id: item.id,
                                type: ArtworkType.PLAYLIST),
                            title: Text(
                              item.playlist,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${item.numOfSongs} songs',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: PopupMenuBottom(
                              playlistModel: item,
                              playlistName: item.playlist,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // PlayerHome()
                ],
              );
            
  }
}