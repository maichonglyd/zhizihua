import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(IndexEmptyBottomState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(top: ScreenService.height / 40, bottom: ScreenService.height / 40),
    alignment: Alignment.center,
    child: Text(
      "- 我也是有底线的 -",
      style: TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 16),
    ),
  );
}
