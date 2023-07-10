//import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/common/string_utils.dart';
// import 'package:wonders/logic/data/timeline_data.dart';

import 'package:wonders/src/controller.dart'
    show $strings, StringUtils, wondersLogic;
import 'package:wonders/src/model.dart' show GlobalEventsData, TimelineEvent;

///
TimelineLogic get timelineLogic => TimelineLogic();

///
class TimelineLogic {
  ///
  factory TimelineLogic() => _this ??= TimelineLogic._();
  TimelineLogic._();
  static TimelineLogic? _this;

  ///
  List<TimelineEvent> events = [];

  ///
  void init() {
    events = [
      ...GlobalEventsData().globalEvents,
      ...wondersLogic.all.map(
        (w) => TimelineEvent(
          w.startYr,
          StringUtils.supplant($strings.timelineLabelConstruction('{title}'),
              {'{title}': w.title}),
        ),
      )
    ];
  }
}
