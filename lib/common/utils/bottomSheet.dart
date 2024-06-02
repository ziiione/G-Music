import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/SongProvider.dart';
import 'package:g_application/common/Provider/playlistProvider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'popup.dart';

//showing the bottom sheet for the song for the song playing option

void buttomsheet(
  BuildContext context, SongModel currentSong
) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black,
                Colors.black.withOpacity(0.9)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          child: Container(
            //  color: Colors.transparent,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: MediaQuery.of(context).size.height * 0.53,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QueryArtworkWidget(
                        id: currentSong.albumId!, type: ArtworkType.ALBUM),
                    Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            " ${currentSong.title}",
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outline,
                          size: 30,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.5),
                ),
                ListTile(
                  onTap: () {
                    Provider.of<SongProvider>(context, listen: false)
                        .shuffle_song();
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.shuffle,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Shuffle',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Provider.of<SongProvider>(context, listen: false)
                        .loop_song();
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.repeat,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Loop',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // code to add the song to playlist
                    Navigator.pop(context);
                    playlist_bottom_sheet(context,currentSong);
                    // playlist_bottom_sheet(
                    //     Provider.of<playlistProvider>(context, listen: false),
                    //     context);
                  },
                  leading: const Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Add to Playlist',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                  
                    // provider.stop_Song();
                    // //code to cut the track
                    // final filePath =
                    //     await LecleFlutterAbsolutePath.getAbsolutePath(
                    //         uri: provider.currentSong.uri.toString());

                    // Navigator.pushNamed(context, AudioTrimmerView.routeName,
                    //     arguments: {'file': File(filePath!)});
                  },
                  leading: const Icon(
                    Icons.content_cut,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Cut track',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    //code to set the song as ringtone

                    // setRingtonePopup(context, provider.currentSong);
                  },
                  leading: const Icon(
                    Icons.vibration,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Set as ringtone',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    //code for delete the song from the device

                    // deleteSongPopup(context);
                  },
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Delete from device',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}



//bottom sheet for the add to playlist

 
  // function to show the modalbottom sheet for adding item in the playlist
  void playlist_bottom_sheet(context,SongModel song) {
  final provider=Provider.of<playlistProvider>(context,listen: false);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black.withOpacity(0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              height: MediaQuery.of(context).size.height * 0.53,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add to Playlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  Divider(
                    height: 1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  ListTile(
                    onTap: () {
                      createPlaylistPopup(context,song);
                    },
                    leading: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Create new playlist',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // itemCount: playlist.playlists.length,
                      itemCount: provider.playlists.length,
                      itemBuilder: (context, index) {
                        final playlist = provider.playlists[index];
                        return Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: ListTile(
                            onTap: () {
                              // playlist.addSongToPlaylist(
                              //     playlist.playlists[index].playlist,
                              //     Provider.of<SongProvier>(context,
                              //             listen: false)
                              //         .currentSong);
                              provider.addSongToPlaylist(playlist.playlist, song);
                              Navigator.pop(context);
                            },
                            leading: Container(
                              width: 40,
                              height: 40,
                              child: QueryArtworkWidget(
                                  quality: 100,
                                  artworkBorder: BorderRadius.circular(30),
                                  artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset('assets/images/cover.jpg'),
                                  ), id: playlist.id, type: ArtworkType.PLAYLIST,),
                            ),
                            title:  Text(
                              // playlist.playlists[index].playlist,
                              playlist.playlist,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }