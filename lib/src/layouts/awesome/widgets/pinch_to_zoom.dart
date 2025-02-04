import 'package:camerawesome/src/orchestrator/sensor_config.dart';
import 'package:flutter/material.dart';

class PinchToZoom extends StatefulWidget {
  final SensorConfig sensorConfig;
  final Widget child;

  const PinchToZoom({
    super.key,
    required this.sensorConfig,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return _PinchToZoomState();
  }
}

class _PinchToZoomState extends State<PinchToZoom> {
  double _previousZoomScale = 0;
  double _zoomScale = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (_) {
        _previousZoomScale = _zoomScale + 1;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        double result = _previousZoomScale * details.scale - 1;
        if (result < 1 && result > 0) {
          _zoomScale = result;
          widget.sensorConfig.setZoom(_zoomScale);
        }
      },
      child: widget.child,
    );
  }
}
