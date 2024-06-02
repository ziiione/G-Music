import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/GenresProvider.dart';

class TimePlayValueGenres extends StatelessWidget {
  const TimePlayValueGenres({
    super.key,
    required this.provider,
  });

  final GenresProvider provider;

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
