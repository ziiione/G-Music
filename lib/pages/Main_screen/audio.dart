import 'package:flutter/material.dart';

class Audio extends StatelessWidget {
  const Audio({super.key});
  static const routeName = '/audio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio'),
      ),
      body: const Center(
        child: Text('Audio'),
      ),
    );
  }
}