part of '../editorial_screen.dart';

class _AppBar extends StatelessWidget {
  _AppBar(this.wonderType,
      {Key? key, required this.sectionIndex, required this.scrollPos})
      : super(key: key);
  final WonderType wonderType;
  final ValueNotifier<int> sectionIndex;
  final ValueNotifier<double> scrollPos;
  final _titleValues = [
    $strings.appBarTitleFactsHistory,
    $strings.appBarTitleConstruction,
    $strings.appBarTitleLocation,
  ];

  final _iconValues = const [
    'history.png',
    'construction.png',
    'geography.png',
  ];

  ArchType _getArchType() {
    switch (wonderType) {
      case WonderType.chichenItza:
        return ArchType.flatPyramid;
      case WonderType.christRedeemer:
        return ArchType.wideArch;
      case WonderType.colosseum:
        return ArchType.arch;
      case WonderType.greatWall:
        return ArchType.arch;
      case WonderType.machuPicchu:
        return ArchType.pyramid;
      case WonderType.petra:
        return ArchType.wideArch;
      case WonderType.pyramidsGiza:
        return ArchType.pyramid;
      case WonderType.tajMahal:
        return ArchType.spade;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arch = _getArchType();
    return LayoutBuilder(builder: (_, constraints) {
      final bool showOverlay = constraints.biggest.height < 300;
      return Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: $styles.times.fast * .5,
            child: Stack(
              key: ValueKey(showOverlay),
              fit: StackFit.expand,
              children: [
                /// Masked image
                ClipPath(
                  // Switch arch type to Rect if we are showing the title bar
                  clipper: showOverlay ? null : ArchClipper(arch),
                  child: ValueListenableBuilder<double>(
                    valueListenable: scrollPos,
                    builder: (_, value, child) {
                      final double opacity = (.4 + (value / 1500)).clamp(0, 1);
                      return ScalingListItem(
                        scrollPos: scrollPos,
                        child: Image.asset(
                          wonderType.photo1,
                          fit: BoxFit.cover,
                          opacity: AlwaysStoppedAnimation(opacity),
                        ),
                      );
                    },
                  ),
                ),

                /// Colored overlay
                if (showOverlay) ...[
                  ClipRect(
                    child: ColoredBox(
                      color: wonderType.bgColor.withOpacity(.8),
                    ).animate().fade(duration: $styles.times.fast),
                  ),
                ],
              ],
            ),
          ),

          /// Circular Titlebar
          BottomCenter(
            child: ValueListenableBuilder<int>(
              valueListenable: sectionIndex,
              builder: (_, value, __) {
                return _CircularTitleBar(
                  index: value,
                  titles: _titleValues,
                  icons: _iconValues,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
