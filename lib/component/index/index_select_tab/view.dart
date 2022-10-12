import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexSelectTabState state, Dispatch dispatch, ViewService viewService) {
  return null != state.tabController
      ? Container(
          height: 45,
          color: Colors.white,
          margin: EdgeInsets.only(left: 10),
          child: new TabBar(
            controller: state.tabController,
            isScrollable: true,
            labelStyle: TextStyle(
                fontSize: HuoTextSizes.title, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: HuoTextSizes.second_title,
            ),
            indicator: CommonUnderlineTabIndicator(
                height: 0,
                insets: EdgeInsets.only(left: 40, right: 40),
                borderSide:
                    BorderSide(width: 4.0, color: AppTheme.colors.themeColor)),
            labelPadding: EdgeInsets.only(right: 10),
            indicatorColor: AppTheme.colors.themeColor,
            labelColor: AppTheme.colors.textColor,
            unselectedLabelColor: AppTheme.colors.textSubColor,
            tabs: state.tabs
                .asMap()
                .keys
                .map((index) => EachTab(
                      padding: EdgeInsets.all(0),
                      text: state.tabs[index],
                    ))
                .toList(),
          ))
      : Container();
}
