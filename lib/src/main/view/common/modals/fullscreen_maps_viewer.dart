import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/data/wonder_data.dart';
// import 'package:wonders/ui/common/google_maps_marker.dart';

import 'package:wonders/src/controller.dart' show wondersLogic;
import 'package:wonders/src/model.dart';
import 'package:wonders/src/view.dart';

class FullscreenMapsViewer extends StatelessWidget {
  FullscreenMapsViewer({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  WonderData get data => wondersLogic.getData(type);
  late final startPos =
      CameraPosition(target: LatLng(data.lat, data.lng), zoom: 17);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.hybrid,
          markers: {getMapsMarker(startPos.target)},
          initialCameraPosition: startPos,
          myLocationButtonEnabled: false,
        ),
        const BackBtn().safe(),
      ],
    );
  }
}
