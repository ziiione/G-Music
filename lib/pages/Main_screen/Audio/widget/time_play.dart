import 'package:flutter/material.dart';
import '../../../../common/Provider/SongProvider.dart';


class time_play_value extends StatelessWidget {
  const time_play_value({
    super.key,
    required this.provider,
  });

  final SongProvider provider;

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
