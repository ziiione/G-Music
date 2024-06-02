import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';

class SliderControlAlbum extends StatelessWidget {
  const SliderControlAlbum({
    super.key,
    required this.provider,
  });

  final AlbumProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        IconButton(
          icon: const Icon(
            Icons.replay_10,
            color: Colors.white,
            size: 34,
          ),
          onPressed: () {
            provider.rewind();
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1.0,
            child: Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              value: provider.sliderValue,
              onChanged: (value) {
                provider.sliderValue = value;
                provider.change_duration(value);
              },
              min: 0,
              max: provider.sliderMaxVAlue,
            ),
          ),
        ),
    
        IconButton(
          icon: const Icon(
            Icons.forward_10,
            color: Colors.white,
            size: 34,
          ),
          onPressed: () {
            provider.fast_forward();
          },
        ),
      ],
    );
  }
}