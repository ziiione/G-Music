import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SfreadialgaugeAlbum extends StatelessWidget {
  const SfreadialgaugeAlbum({
    super.key,
    required this.provider,
  });

  final AlbumProvider provider;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 1,
      enableLoadingAnimation: true,
      axes: [
        RadialAxis(
          useRangeColorForAxis: true,
          startAngle: 280,
          endAngle: 150,
          canRotateLabels: false,
          interval: 0.1,
          isInversed: false,
          maximum: 1,
          minimum: 0,
          showAxisLine: true,
          showLabels: true,
          showTicks: true,
          labelFormat: '{value}',
          ranges: [
            GaugeRange(
                startValue: 0,
                endValue: 1,
                color: Colors.white),
            GaugeRange(
                startValue: provider.sound_volume,
                endValue: 1,
                color: Colors.grey)
          ],
          pointers: [
            MarkerPointer(
              color: Colors.white,
              value: provider.sound_volume,
              onValueChanged: (newValue) {
                provider.change_volume(newValue);
              },
              enableAnimation: true,
              enableDragging: true,
              markerType: MarkerType.circle,
              markerWidth: 20,
              markerHeight: 20,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              horizontalAlignment: GaugeAlignment.center,
              widget: NewWidget(provider: provider),
            )
          ],
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.provider,
  });

  final AlbumProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.19,
      height: MediaQuery.of(context).size.height * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: QueryArtworkWidget(
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkBorder: BorderRadius.circular(8),
          artworkClipBehavior: Clip.antiAliasWithSaveLayer,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset('assets/images/music_symbol.png', fit: BoxFit.cover),
          ),
          id: provider.currentSong!.albumId!,
          keepOldArtwork: true,
          type: ArtworkType.ALBUM,
        ),
      ),
    );
  }
}