//playlist proivder class
// ignore_for_file: camel_case_types, slash_for_doc_comments

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Database/DatabaseHelper.dart';

class playlistProvider extends ChangeNotifier {
    final audioQuery = OnAudioQuery();
  final databasehelper = DatabaseHelper.instance;
  final player = AudioPlayer();

  bool _isplaying = false;
  bool get isplaying => _isplaying;
  String _currentTime = '0';
  String _totalTime = '0';
  double sliderValue = 0.0;
  double sliderMaxVAlue = 0.0;
  bool is_looping = false;
  bool is_shuffling = false;
  SongModel? currentSong;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<Duration?>? _positionSubscription;

  List<SongModel> _songs = [];
  final ValueNotifier<bool> _isPlayingNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isPlayingNotifier => _isPlayingNotifier;

  double _sound_volume = 0.4;
  double get sound_volume => _sound_volume;
  List<PlaylistModel> _playlists = [];


  List<PlaylistModel> get playlists => _playlists.reversed.toList();

  List<SongModel> get songs => _songs;
  String get currentTime => _currentTime;
  String get totalTime => _totalTime;


/**----------------------------------------playlist play control function--------------------------------- */

  //function to play the song
  void play_song(SongModel song) async {
    try {
      print('--------------------going to play the song-------------------');
      if (currentSong != null && currentSong!.id != song.id) {
        await player.stop();
      }
      print(song.title);
      print(song.album);
      stop_Song();
      currentSong = song;
      await player.setAudioSource(AudioSource.uri(Uri.parse(song.data)));
      player.play();
      _isPlayingNotifier.value = true;

      Map<String, dynamic> row = {
        'title': song.title,
        'artist': song.artist,
        'album': song.album,
        'albumId': song.albumId,
      };
      await databasehelper.insert(row);
      update_time();

      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          next_song(song);
        }
      });

      _isplaying = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

//function to stop the song playing
  void stop_Song() async {
    await player.stop();
    _isplaying = false;
    _isPlayingNotifier.value = false;
    notifyListeners();
  }

  //function to pause the song
  void pause_Song() async {
    await player.pause();

    _isplaying = false;
    _isPlayingNotifier.value = false;
    notifyListeners();
  }

  //function to resume the song
  void resume_Song() async {
    await player.play();
    _isplaying = true;
    _isPlayingNotifier.value = true;
    notifyListeners();
  }

  void next_song(SongModel song) async {
     if(is_shuffling){
      final random = Random().nextInt(_songs.length-1);
      play_song(_songs[random]);}else{
  print(_songs);
    int index=-1;
    for(int i=0;i<_songs.length;i++){
      if((song.albumId==_songs[i].albumId)&&(song.id==_songs[i].id)&&(song.title==_songs[i].title)){
        index=i;
        break;
      }
    }
  
  print(song.data);
  
  print('doing the next song');
  if (index!=-1&& (index<_songs.length)) { // Check if the index is within the valid range
   
    play_song(_songs[(index + 1) % (_songs.length)]);

  }else{
    
    play_song(_songs[0]);
    print('not playing the song');
  }
      }
  
}

  //function to play the previous song
  void previous_song(SongModel song) async {
    if(is_shuffling){
      final random = Random().nextInt(_songs.length-1);
      play_song(_songs[random]);}
    else{
          int index=-1;
    for(int i=0;i<_songs.length;i++){
      if((song.albumId==_songs[i].albumId)&&(song.id==_songs[i].id)&&(song.title==_songs[i].title)){
        index=i;
        break;
      }
    }
    
    if (index == 0) {
      play_song(_songs[_songs.length - 1]);
    } else {
      play_song(_songs[index - 1]);
    }}
  }

  //function to rewind 10 seconds
  void rewind() async {
    await player.seek(player.position - const Duration(seconds: 10));
  }

  //function to fast forward 10 seconds
  void fast_forward() async {
    await player.seek(player.position + const Duration(seconds: 10));
  }
/**--------------------------song volume control ---------------------------------------------------- */
  //function to change the volume of the song
  void change_volume(double newVolume) async {
    try {
      _sound_volume = newVolume;
      await player.setVolume(newVolume);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //function to update the time of the song
     void update_time() {
    try {
      _durationSubscription = player.durationStream.listen((event) {
        _totalTime = event!.toString().split(".")[0];
        sliderMaxVAlue = event.inSeconds.toDouble();
        notifyListeners();
      });
      _positionSubscription = player.positionStream.listen((event) {
        _currentTime = event.toString().split(".")[0];
        sliderValue = event.inSeconds.toDouble();
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
   @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  //function to change the duration of the song
  void change_duration(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  //function to loop the song
  void loop_song() async {
    is_looping = !is_looping;
    await player.setLoopMode(is_looping ? LoopMode.one : LoopMode.off);
    notifyListeners();
  }

  //function to shuffle the song
  void shuffle_song() async {
    try {
      if (is_shuffling) {
        player.setShuffleModeEnabled(false);
        print('shuffle off');
        is_shuffling = false;
      } else {
        print('shuffle on');
        player.setShuffleModeEnabled(true);
        is_shuffling = true;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /**--------------------------------------------------Playlist Function operation ------------------------------ */
// Function to create the playlist

  Future<void> createPlaylist(String name) async {
    try {
      if (!_playlists.any((element) => element.playlist == name)) {
        await audioQuery.createPlaylist(name);
        _playlists = await audioQuery.queryPlaylists();
        notifyListeners();
      } else {
        print('Playlist already exists');
      }
    } catch (e) {
      print('Failed to create playlist: $e');
    }
  }

  //function to get all the songModel of playlist by it's name
  Future<List<SongModel>> getSongsFromPlaylist(PlaylistModel play) async {
    try {    

    _songs=await audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, play.playlist,sortType: SongSortType.DATE_ADDED,orderType: OrderType.ASC_OR_SMALLER);
  
    return [..._songs];
    } catch (e) {
      print(e);
      print('Failed to get songs from playlist: $e');
      return [];
    }
  }

// function rename the playlist name
   Future<void> renamePlaylist(String oldName, String newName) async {
    try {
      // Check if the playlist with the old name exists
      if (_playlists.any((element) => element.playlist == oldName)) {
        // Get the playlist ID of the old playlist
        int playlistId = _playlists.firstWhere((element) => element.playlist == oldName).id;
        
        // Rename the playlist
        await audioQuery.renamePlaylist(playlistId, newName);
        
        // Refresh the playlists list
        _playlists = await audioQuery.queryPlaylists();
        notifyListeners();

        print('Successfully renamed playlist from $oldName to $newName');
      } else {
        print('Playlist does not exist');
      }
    } catch (e) {
      print('Failed to rename playlist: $e');
    }
  }

//function to add the song to the playlist
Future<void> addSongToPlaylist(String playlistname, SongModel song) async {
  try {
    if (_playlists.any((element) => element.playlist == playlistname)) {
      var playlist = _playlists.firstWhere((element) => element.playlist == playlistname);
      List<SongModel> songsInPlaylist = await getSongsFromPlaylist(playlist);

      if (!songsInPlaylist.any((s) => s.id == song.id)) {
        await audioQuery.addToPlaylist(playlist.id, song.id);
        _playlists = await audioQuery.queryPlaylists();
        notifyListeners();
      }else{
        print('Song already exists in playlist');
      }
    } else {
      await createPlaylist(playlistname);
      _playlists = await audioQuery.queryPlaylists(); // Refresh _playlists
     await addSongToPlaylist(playlistname, song);
      notifyListeners();
    }
  } catch (e) {
    print(e);
  }
}

// function to delete the playlist from it's name
  Future<void> deletePlaylist(String playlistname) async {
    if (_playlists.any((element) => element.playlist == playlistname)) {
      await audioQuery.removePlaylist(_playlists
          .firstWhere((element) => element.playlist == playlistname)
          .id);
      _playlists.removeWhere((element) => element.playlist == playlistname);
      _playlists = await audioQuery.queryPlaylists();
      notifyListeners();
    } else {
      print('Playlist does not exist');
    }
  }

  //function to delete songmodel from the playlist
  Future<void> deleteSongFromPlaylist(String playlistname, SongModel song) async {
    try {
      
      if (_playlists.any((element) => element.playlist == playlistname)) {
        var playlist = _playlists.firstWhere((element) => element.playlist == playlistname);
        List<SongModel> songsInPlaylist = await getSongsFromPlaylist(playlist);

        if (songsInPlaylist.any((s) => s.id == song.id)) {
          await audioQuery.removeFromPlaylist(playlist.id, song.id);
          _playlists = await audioQuery.queryPlaylists();

          _songs.removeWhere((element) => (element.id == song.id) && (element.albumId == song.albumId) && (element.title == song.title) && (element.artist == song.artist) && (element.data == song.data) && (element.duration == song.duration) && (element.album == song.album));
          notifyListeners();
        } else {
          print('Song does not exist in playlist');
        }
      } else {
        print('Playlist does not exist');
      }
    } catch (e) {
      print(e);
    }
  }
/** ---------------------------------------------- loading and permisssion activity and clear song------------------------------ */
  // function to load the playlist
 Future<void>  loadPlaylist() async {
    print('Loading the song of playlist ');
    _playlists = await audioQuery.queryPlaylists();

    print(_playlists);

    print('.............................................................');
    notifyListeners();
    print(_playlists.length);
    print('Loading the song of playlist ');
  }


//function to clear _song list
  void clear_song() {
    _songs.clear();
    notifyListeners();
  }

}

