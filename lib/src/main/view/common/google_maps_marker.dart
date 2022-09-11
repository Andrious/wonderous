import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonders/src/main/view/common/assets.dart';

Marker getMapsMarker(LatLng position) => Marker(
      markerId: const MarkerId('0'),
      position: position,
      icon: AppBitmaps.mapMarker,
      anchor: const Offset(.5, .7),
    );
