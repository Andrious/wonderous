part of '../timeline_screen.dart';

/// A vertically aligned stack of dots that represent global events
/// The event closest to the [selectedYr] param will be visible selected
class _EventMarkers extends StatefulWidget {
  const _EventMarkers(this.selectedYr, {Key? key, required this.onEventChanged})
      : super(key: key);

  final void Function(TimelineEvent? event) onEventChanged;
  final int selectedYr;

  @override
  State<_EventMarkers> createState() => _EventMarkersState();
}

class _EventMarkersState extends State<_EventMarkers> {
  int get startYr => wondersLogic.timelineStartYear;

  int get endYr => wondersLogic.timelineEndYear;

  late final int _totalYrs = endYr - startYr;

  TimelineEvent? selectedEvent;

  /// Normalizes a given year to a value from 0 - 1, based on start and end yr.
  double _calculateOffsetY(int yr) => (yr - startYr) / _totalYrs;

  /// Loops through the global events, and does a px-based check to see whether
  /// one of them should be selected  (as oppose to year-based proximity).
  /// This ensures consistent UX at different zoom levels.
  void _updateSelectedEvent(double maxPxHeight) {
    const double minDistance = 10;
    TimelineEvent? closestEvent;
    double closestDistance = double.infinity;
    // Convert current yr to a px position
    final double currentYearPx =
        _calculateOffsetY(widget.selectedYr) * maxPxHeight;
    for (final e in timelineLogic.events) {
      // Convert both the event.yr to px, and compare with currentYearPx
      final double eventPx = _calculateOffsetY(e.year) * maxPxHeight;
      final double d = (eventPx - currentYearPx).abs();
      // Keep the closest event that is within minDistance
      if (d <= minDistance && d < closestDistance) {
        closestEvent = e;
        closestDistance = d;
      }
    }
    // Dispatch if event has actually changed since last time
    if (closestEvent != selectedEvent) {
      scheduleMicrotask(() => widget.onEventChanged(closestEvent));
    }
    selectedEvent = closestEvent;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoringSemantics: false,
      child: LayoutBuilder(builder: (_, constraints) {
        /// Figure out which event is "selected"
        _updateSelectedEvent(constraints.maxHeight);

        /// Create a marker for each event
        final List<Widget> markers = timelineLogic.events.map((event) {
          final offsetY = _calculateOffsetY(event.year);
          return _EventMarker(offsetY,
              isSelected: event == selectedEvent,
              semanticLabel: '${event.year}: ${event.description}');
        }).toList();

        /// Stack of fractionally positioned markers
        return FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 75),
            child: SizedBox(
              width: 20,
              child: Stack(children: markers),
            ),
          ),
        );
      }),
    );
  }
}

/// A dot that represents a single global event.
/// Animated to a selected state which is is larger in size.
class _EventMarker extends StatelessWidget {
  const _EventMarker(
    this.offset, {
    Key? key,
    required this.isSelected,
    required this.semanticLabel,
  }) : super(key: key);
  final double offset;
  final bool isSelected;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1 + offset * 2),
      child: Semantics(
        label: semanticLabel,
        child: Container(
          alignment: Alignment.center,
          height: 30,
          child: AnimatedContainer(
            width: isSelected ? 6 : 2,
            height: isSelected ? 6 : 2,
            curve: Curves.easeOutBack,
            duration: $styles.times.med,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: $styles.colors.accent1,
              boxShadow: [
                BoxShadow(
                    color:
                        $styles.colors.accent1.withOpacity(isSelected ? .5 : 0),
                    spreadRadius: 3,
                    blurRadius: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
