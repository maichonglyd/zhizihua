import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';

class SplitLine extends StatelessWidget {
  double height;

  SplitLine({this.height = 9});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      color: AppTheme.colors.bgColor,
    );
  }
}
