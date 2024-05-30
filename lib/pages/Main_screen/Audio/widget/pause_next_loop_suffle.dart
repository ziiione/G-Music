import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../common/Provider/SongProvider.dart';

class pause_next_loop_suffle extends StatefulWidget {
  const pause_next_loop_suffle({
    Key? key,
   
  }) : super(key: key);

  @override
  _pause_next_loop_suffleState createState() => _pause_next_loop_suffleState();
}

class _pause_next_loop_suffleState extends State<pause_next_loop_suffle> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  provider.loop_song();
                },
                icon: Icon(
                  Icons.repeat,
                  color: provider.is_looping
                      ? Colors.red
                      : Colors.white,
                  size: 34,
                )),
            InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  provider.previous_song(provider.currentSong!);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.black,
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        width: 20,
                        color: Colors.white,
                      )),
                )),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  provider.isplaying
                      ? provider.pause_Song()
                      : provider.resume_Song();
                });
                provider.isplaying
                    ? provider.pause_Song()
                    : provider.resume_Song();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: provider.isplaying
                      ? SvgPicture.asset(
                          'assets/icons/pause.svg',
                          width: 25,
                        )
                      : SvgPicture.asset(
                          'assets/icons/play.svg',
                          width: 25,
                        ),
                ),
              ),
            ),
            InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  provider.next_song(provider.currentSong!);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 23,
                      child: SvgPicture.asset(
                        'assets/icons/next.svg',
                        width: 20,
                        color: Colors.white,
                      )),
                )),
            IconButton(
                onPressed: () {
                  provider.shuffle_song();
                },
                icon: Icon(
                  Icons.shuffle,
                  color: provider.is_shuffling
                      ? Colors.red
                      : Colors.white,
                  size: 34,
                )),
          ],
        );
      },
    );
  }
}