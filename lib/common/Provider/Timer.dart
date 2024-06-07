import 'dart:async';

import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';
import 'package:g_application/common/Provider/ArtistProvider.dart';
import 'package:g_application/common/Provider/GenresProvider.dart';
import 'package:g_application/common/Provider/SongProvider.dart';
import 'package:g_application/common/Provider/playlistProvider.dart';
import 'package:provider/provider.dart';

class SleepTimer{
  Timer? _timer;
  final BuildContext context;
  Duration _currentDuration = Duration.zero;
  StreamSubscription? _tickerSubscription;

  SleepTimer({required this.context});

  void start(Duration duration) {
    cancelPreviouseTimer();
    print('start');
    _currentDuration = Duration.zero;
    _tickerSubscription = Stream.periodic(Duration(seconds: 1), (x) => x)
        .listen((_) {
      _currentDuration += Duration(seconds: 1);
    
      print('Elapsed time: ${_currentDuration.inSeconds} seconds');
    });
    _timer = Timer(duration, stop);
  
  }

  void cancelPreviouseTimer() {
    _timer?.cancel();
    _timer = null;
    _tickerSubscription?.cancel();
    _tickerSubscription = null;
  }

  void stop() {
    Provider.of<SongProvider>(context, listen: false).stop_Song();
    Provider.of<AlbumProvider>(context, listen: false).stop_Song();
    Provider.of<playlistProvider>(context, listen: false).stop_Song();
    Provider.of<ArtistProvider>(context, listen: false).stop_Song();
    Provider.of<GenresProvider>(context, listen: false).stop_Song();
    _timer?.cancel();
    _timer = null;

    _tickerSubscription?.cancel();
    _tickerSubscription = null;
   
  }

  bool get isRunning => _timer != null;
  //getter to get the current duration
  Duration get currentDuration => _currentDuration;
}