import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/view.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexTabTitleState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 45,
    color: Colors.white,
    margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 0),
    child: Row(
      children: <Widget>[
//        Container(
//          height: 15,
//          width: 5,
//          margin: EdgeInsets.only(right: 7),
//          decoration: BoxDecoration(
//              color: AppTheme.colors.themeColor,
//              borderRadius: BorderRadius.all(Radius.circular(3))),
//        ),
        Expanded(
          child: Text(getText(name: 'textWholeGame'),
              style: commonTextStyle(
                  AppTheme.colors.textColor, 20, FontWeight.w600)),
        ),
      ],
    ),
  );
}
