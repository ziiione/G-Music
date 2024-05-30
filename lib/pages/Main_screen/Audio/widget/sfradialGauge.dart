import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../common/Provider/SongProvider.dart';
import '../../../../common/utils/image_artwork.dart';

class Sfradialgauge extends StatelessWidget {
  const Sfradialgauge({
    super.key,
    required this.provider,
  });

  final SongProvider provider;

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