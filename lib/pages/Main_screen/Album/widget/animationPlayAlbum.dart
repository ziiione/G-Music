import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';
import 'package:siri_wave/siri_wave.dart';

class AnimationPlayAlbum extends StatelessWidget {
  const AnimationPlayAlbum({
    super.key,
    required this.provider,
    required this.controller,
    required this.controller2,
  });

  final AlbumProvider provider;
  final IOS7SiriWaveformController controller;
  final IOS7SiriWaveformController controller2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        provider.isplaying
            ? SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.05,
                width: double.infinity,
                child: SiriWaveform.ios7(
                  controller: controller,
                  options: const IOS7SiriWaveformOptions(
                    height: 180,
                    width: 360,
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.05,
                width: double.infinity,
                child: SiriWaveform.ios7(
                  controller: controller2,
                  options: const IOS7SiriWaveformOptions(
                    height: 180,
                    width: 360,
                  ),
                ),
              ),
      ],
    );
  }
}