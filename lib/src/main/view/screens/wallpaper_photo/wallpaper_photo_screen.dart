import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
// import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/data/wonder_data.dart';
// import 'package:wonders/ui/common/app_icons.dart';
// import 'package:wonders/ui/common/controls/checkbox.dart';
// import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
// import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration.dart';
// import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
// import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';
//
import 'package:wonders/src/controller.dart'
    show $strings, wallpaperLogic, wondersLogic;
//
import 'package:wonders/src/model.dart' show WonderData, WonderType;
//
import 'package:wonders/src/view.dart';

///
class WallpaperPhotoScreen extends StatefulWidget {
  ///
  const WallpaperPhotoScreen({Key? key, required this.type}) : super(key: key);

  ///
  final WonderType type;

  @override
  State<WallpaperPhotoScreen> createState() => _WallpaperPhotoScreenState();
}

class _WallpaperPhotoScreenState extends State<WallpaperPhotoScreen> {
  final GlobalKey _containerKey = GlobalKey();
  Widget? _illustration;

  bool _showTitleText = true;
  Timer? _photoRetryTimer;

  @override
  void dispose() {
    _photoRetryTimer?.cancel();
    super.dispose();
  }

  Future<void> _handleTakePhoto(BuildContext context, String wonderName) async {
    final boundary = _containerKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary != null) {
      await wallpaperLogic.save(this, boundary,
          name: '${wonderName}_wallpaper');
    }
  }

  Future<void> _handleSharePhoto(
      BuildContext context, String wonderName) async {
    final boundary = _containerKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    await wallpaperLogic.share(context, boundary,
        name: '${wonderName}_wallpaper', wonderName: wonderName);
  }

  void _handleTextToggle(bool? isActive) {
    setState(() => _showTitleText = isActive ?? !_showTitleText);
  }

  @override
  Widget build(BuildContext context) {
    final WonderData wonderData = wondersLogic.getData(widget.type);
    final WonderIllustrationConfig bgConfig = WonderIllustrationConfig.bg(
      enableAnims: false,
      enableHero: false,
    );
    const WonderIllustrationConfig fgConfig = WonderIllustrationConfig(
      enableAnims: false,
      enableHero: false,
      enableBg: false,
    );
    final Color fgColor = wonderData.type.bgColor; //.withOpacity(.5);

    _illustration = RepaintBoundary(
      key: _containerKey,
      child: ClipRect(
        child: Stack(
          children: [
            // Background - apply additional filter to make moon brighter
            WonderIllustration(
              widget.type,
              config: bgConfig,
            ),

            // Clouds
            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: .5,
              child: AnimatedClouds(
                wonderType: wonderData.type,
                opacity: 1,
                enableAnimations: false,
              ),
            ),

            // Wonder illustration
            WonderIllustration(
              widget.type,
              config: fgConfig,
            ),

            // Foreground gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    fgColor.withOpacity(0),
                    fgColor.withOpacity(fgColor.opacity * .75),
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),

            // Title text
            if (_showTitleText)
              BottomCenter(
                child: Transform.translate(
                  offset: Offset(0, -$styles.insets.xl * 2),
                  child: WonderTitleText(wonderData, enableShadows: true),
                ),
              ),
          ],
        ),
      ),
    );

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            backgroundBlendMode: BlendMode.color, color: Colors.blue),
        child: _illustration ?? Container(),
      ),
      TopCenter(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all($styles.insets.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BackBtn.close(
                    bgColor: $styles.colors.offWhite,
                    iconColor: $styles.colors.black,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 16),
                  child: CircleIconBtn(
                    icon: defaultTargetPlatform == TargetPlatform.iOS
                        ? AppIcons.share_ios
                        : AppIcons.share_android,
                    bgColor: $styles.colors.offWhite,
                    color: $styles.colors.black,
                    onPressed: () =>
                        _handleSharePhoto(context, wonderData.title),
                    semanticLabel: $strings.wallpaperSemanticSharePhoto,
                    size: 44,
                  ),
                ),
                CircleIconBtn(
                  icon: AppIcons.download,
                  onPressed: () => _handleTakePhoto(context, wonderData.title),
                  semanticLabel: $strings.wallpaperSemanticTakePhoto,
                  size: 64,
                ),
              ],
            ),
          ),
        ),
      ),
      BottomCenter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleCheckbox(
                active: _showTitleText,
                label: $strings.wallpaperCheckboxShowTitle,
                onToggled: _handleTextToggle),
            Gap($styles.insets.xl),
          ],
        ),
      ),
    ]);
  }
}
