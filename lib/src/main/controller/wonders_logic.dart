// import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/data/wonder_data.dart';
// import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
// import 'package:wonders/logic/data/wonders_data/christ_redeemer_data.dart';
// import 'package:wonders/logic/data/wonders_data/colosseum_data.dart';
// import 'package:wonders/logic/data/wonders_data/great_wall_data.dart';
// import 'package:wonders/logic/data/wonders_data/machu_picchu_data.dart';
// import 'package:wonders/logic/data/wonders_data/petra_data.dart';
// import 'package:wonders/logic/data/wonders_data/pyramids_giza_data.dart';
// import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';

import 'package:wonders/src/model.dart'
    show
        ChichenItzaData,
        ChristRedeemerData,
        ColosseumData,
        GreatWallData,
        MachuPicchuData,
        PetraData,
        PyramidsGizaData,
        TajMahalData,
        WonderData,
        WonderType;
import 'package:wonders/src/view.dart';

/// A getter for this class
WondersLogic get wondersLogic => WondersLogic();

/// Business logic
class WondersLogic {
  /// The Singleton pattern
  factory WondersLogic() => _this ??= WondersLogic._();
  WondersLogic._();
  static WondersLogic? _this;

  ///
  List<WonderData> all = [];

  ///
  final int timelineStartYear = -3000;

  ///
  final int timelineEndYear = 2200;

  WonderData getData(WonderType value) {
    final WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) {
      throw 'Could not find data for wonder type $value';
    }
    return result;
  }

  void init() {
    all = [
      GreatWallData(),
      PetraData(),
      ColosseumData(),
      ChichenItzaData(),
      MachuPicchuData(),
      TajMahalData(),
      ChristRedeemerData(),
      PyramidsGizaData(),
    ];
  }
}
