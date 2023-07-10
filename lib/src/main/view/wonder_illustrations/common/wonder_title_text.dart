// import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/common/string_utils.dart';
// import 'package:wonders/logic/data/wonder_data.dart';

import 'package:wonders/src/controller.dart' show StringUtils;
import 'package:wonders/src/model.dart' show WonderData, WonderType;
import 'package:wonders/src/view.dart';

/// To match designs:
/// - need a line-break after the first line
/// - of/the should be down-sized
/// Accomplished using a set of TextSpans, and a white list of 'small words'
class WonderTitleText extends StatelessWidget {
  const WonderTitleText(this.data, {Key? key, this.enableShadows = false})
      : super(key: key);
  final WonderData data;
  final bool enableShadows;
  @override
  Widget build(BuildContext context) {
    var textStyle = $styles.text.wonderTitle.copyWith(
      color: $styles.colors.offWhite,
    );
    final bool smallText =
        [WonderType.christRedeemer, WonderType.colosseum].contains(data.type);
    if (smallText) {
      textStyle = textStyle.copyWith(fontSize: 56);
    }

    // First, get a list like: ['the\n', 'great wall']
    final title = data.title.toLowerCase();
    // Split on spaces, later, add either a linebreak or a space back in.
    final List<String> pieces = title.split(' ');
    // TextSpan builder, figures out whether to use small text, and adds linebreak or space (or nothing).
    TextSpan buildTextSpan(String text) {
      final smallWords = ['of', 'the'];
      final bool useSmallText = smallWords.contains(text.trim());
      final int i = pieces.indexOf(text);
      final bool addLinebreak = i == 0 && pieces.length > 1;
      final bool addSpace = !addLinebreak && i < pieces.length - 1;
      if (useSmallText == false) {
//        text = StringUtils.capitalize(text);
        text = text.capitalize!;
      }
      return TextSpan(
        text: '$text${addLinebreak ? '\n' : addSpace ? ' ' : ''}',
        style: useSmallText ? textStyle.copyWith(fontSize: 20) : textStyle,
      );
    }

    final List<Shadow> shadows = enableShadows ? $styles.shadows.textSoft : [];
    return Hero(
      tag: Text('wonderTitle-$title'),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: textStyle.copyWith(shadows: shadows),
          children: pieces.map(buildTextSpan).toList(),
        ),
      ),
    );
  }
}
