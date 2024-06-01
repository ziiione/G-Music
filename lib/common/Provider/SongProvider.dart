// ignore_for_file: slash_for_doc_comments, avoid_print

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../database/databaseHelper.dart';

class SongProvider extends ChangeNotifier {
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

/**   --------------------------some getter of the app --------------------------------- */
  String get currentTime => _currentTime;
  String get totalTime => _totalTime;

  /** --------------------------Database Operation------------------------------------------ */

  //function to get last played song from the database
  Future<Map<String, dynamic>> getLastPlayedSong() async {
    final Map<String, dynamic> rows = await databasehelper.getLastPlayedSong();
    if (rows.isNotEmpty) {
      currentSong = _songs.firstWhere(
        (element) =>
            (element.title == rows['title']) &&
            (element.artist == rows['artist']) &&
            (element.album == rows['album']) &&
            (element.albumId == rows['albumId']),
      );
      return rows;
    } else {
      return {};
    }
  }

  //function to query all the rows of the database
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await databasehelper.queryAllRows();
  }

  //get the no of rows in the database
  Future<int?> getRowCount() async {
    return await databasehelper.getRowCount();
  }

  /**    --------------------------------Song Operation------------------------------------------------------------- */

  //function to play the song
  void play_song(SongModel song) async {
    try {
      currentSong = song;
      await player.setAudioSource(AudioSource.uri(Uri.parse(song.uri!)));
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

  //function to play the next song
  void next_song(SongModel song) async {
    if(is_shuffling){
      
      final random = Random().nextInt(_songs.length-1);
      play_song(_songs[random]);    
    }else{
      final index = _songs.indexOf(song);
    if (index == _songs.length - 1) {
      play_song(_songs[0]);
    } else {
      play_song(_songs[index + 1]);
    }
    }  
  }

  //function to play the previous song
  void previous_song(SongModel song) async {
    if(is_shuffling){
      final random = Random().nextInt(_songs.length-1);
      play_song(_songs[random]);}
    else{
    final index = _songs.indexOf(song);
    if (index == 0) {
      play_song(_songs[_songs.length - 1]);
    } else {
      play_song(_songs[index - 1]);
    }}
  }

  //function to rewind 10 seconds
 void rewind() async {
  if (player.position <= const Duration(seconds: 10)) {
    await player.seek(Duration.zero);
  } else {
    await player.seek(player.position - const Duration(seconds: 10));
  }
}
  //function to fast forward 10 seconds
  void fast_forward() async {
  Duration newPosition = player.position + const Duration(seconds: 10);
  if (newPosition >= player.duration!) {
    await player.seek(player.duration);
  } else {
    await player.seek(newPosition);
  }
}

  /** ---------------------------------Song Setting------------------------------------------------------------- */

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

  /** ---------------------------------Song Loading------------------------------------------------------------- */
  Future<void> Load_song() async {
    _songs = await audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
    );
    notifyListeners();
  }

  //function to get all the songs
  List<SongModel> getSongs() {
    return [..._songs];
  }

  /** ---------------------------------Song Filtering------------------------------------------------------------- */

  //function to get the album songs
  List<SongModel> getAlbumSongs(AlbumModel album) {
    return _songs.where((song) => song.albumId == album.id).toList();
  }

  //function to get the artist songs
  List<SongModel> getArtistSongs(ArtistModel artist) {
    return _songs.where((song) => song.artist == artist.artist).toList();
  }

  //function to get the genre songs
  List<SongModel> getGenreSongs(GenreModel genre) {
    return _songs.where((song) => song.genre == genre.genre).toList();
  }

  /** ---------------------------------Permission------------------------------------------------------------- */

//function to get the storage permission
  Future<void> storagePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      Load_song();
    } else {
      SystemNavigator.pop();
    }
  }
}
