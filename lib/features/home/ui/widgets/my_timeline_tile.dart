import 'package:flutter/material.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/features/home/ui/widgets/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final Widget eventCard;

  const MyTimelineTile({
    super.key,
    required this.isFirst,
    required this.isPast,
    required this.isLast,
    required this.eventCard,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isPast ? ColorsManager.vibrantPink : ColorsManager.softPink,
      ),
      indicatorStyle: IndicatorStyle(
        width: 50,
        color: isPast ? ColorsManager.vibrantPink : ColorsManager.softPink,
        iconStyle: IconStyle(
          iconData: Icons.done,
          color: isPast ? ColorsManager.white : ColorsManager.softPink,
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.only(left: 20), // Adjust as needed
        child: MyEventCard(
          isPast: isPast,
          child: eventCard,
        ),
      ),
    );
  }
}
