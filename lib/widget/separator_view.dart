import 'package:flutter/material.dart';

/*
虚线
 */
class SeparatorView extends StatelessWidget {
  final double height;
  final Color color;
  bool isHorizontal = true;
  int dashCount = 30;
  SeparatorView(
      {this.height = 1,
      this.color = Colors.white,
      this.isHorizontal = true,
      this.dashCount = 30});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = isHorizontal ? 10.0 : 1.0;
        final dashHeight = isHorizontal ? 1.0 : 10.0;

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: isHorizontal ? Axis.horizontal : Axis.vertical,
        );
      },
    );
  }
}
