part of '../editorial_screen.dart';

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key, required this.scroller})
      : super(key: key);
  final WonderData data;
  final ScrollController scroller;

  @override
  Widget build(BuildContext context) => MergeSemantics(
        child: DefaultTextColor(
          color: $styles.colors.offWhite,
          child: StaticTextScale(
            child: Column(
              children: [
                Gap($styles.insets.md),
                const Gap(30),

                /// Sub-title row
                SeparatedRow(
                  padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                  separatorBuilder: () => Gap($styles.insets.sm),
                  children: [
                    Expanded(
                      child: Divider(
                        color: data.type.fgColor,
                      ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
                    ),
                    Semantics(
                      header: true,
                      sortKey: const OrdinalSortKey(1),
                      child: Text(
                        data.subTitle.toUpperCase(),
                        style: $styles.text.title2,
                      ).animate().fade(delay: 100.ms),
                    ),
                    Expanded(
                      child: Divider(
                        color: data.type.fgColor,
                      ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
                    ),
                  ],
                ),
                Gap($styles.insets.md),

                /// Wonder title text
                Semantics(
                  sortKey: const OrdinalSortKey(0),
                  child: WonderTitleText(data),
                ),
                Gap($styles.insets.xs),

                /// Region
                Text(
                  data.regionTitle.toUpperCase(),
                  style: $styles.text.title1,
                  textAlign: TextAlign.center,
                ),
                Gap($styles.insets.md),

                /// Compass divider
                ExcludeSemantics(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: $styles.insets.md),
                    child: AnimatedBuilder(
                      animation: scroller,
                      builder: (_, __) => CompassDivider(
                        isExpanded: scroller.position.pixels <= 0,
                        linesColor: data.type.fgColor,
                        compassColor: $styles.colors.offWhite,
                      ),
                    ),
                  ),
                ),
                Gap($styles.insets.sm),

                /// Date
                Text(
                  StringUtils.supplant(
                    $strings.titleLabelDate,
                    {
                      '{fromDate}': StringUtils.formatYr(data.startYr),
                      '{endDate}': StringUtils.formatYr(data.endYr),
                    },
                  ),
                  style: $styles.text.h4,
                  textAlign: TextAlign.center,
                ),
                Gap($styles.insets.sm),
              ],
            ),
          ),
        ),
      );
}
