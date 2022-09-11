part of '../editorial_screen.dart';

class _LargeSimpleQuote extends StatelessWidget {
  const _LargeSimpleQuote({Key? key, required this.text, required this.author})
      : super(key: key);
  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: $styles.insets.lg, vertical: $styles.insets.xl),
        child: Column(children: [
          FractionalTranslation(
            translation: const Offset(0, .5),
            child: Text(
              '“',
              style: $styles.text.quote1.copyWith(
                color: $styles.colors.accent1,
                fontSize: 90,
                height: .7,
              ),
            ),
          ),
          Text(
            text,
            style: $styles.text.quote2,
            textAlign: TextAlign.center,
          ),
          Gap($styles.insets.md),
          Text(
            '- $author',
            style:
                $styles.text.quote2Sub.copyWith(color: $styles.colors.accent1),
          ),
        ]),
      ),
    );
  }
}