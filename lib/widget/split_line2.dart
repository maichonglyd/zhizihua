import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';

class SplitLine2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: HuoDimens.lineHeightSmall,
      color: AppTheme.colors.bgColor,
    );
  }
}
