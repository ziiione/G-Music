import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/ArtistProvider.dart';

class TimePlayValueArtist extends StatelessWidget {
  const TimePlayValueArtist({
    super.key,
    required this.provider,
  });

  final ArtistProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width:
              MediaQuery.of(context).size.width * 0.1,
        ),
        Text(
          provider.currentTime,
          style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        Expanded(child: Container()),
        Text(
          provider.totalTime,
          style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width:
              MediaQuery.of(context).size.width * 0.1,
        ),
      ],
    );
  }
}
