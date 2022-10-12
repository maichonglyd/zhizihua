import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRankState state, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
      length: AppConfig.hasH5 ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: huoTitle(getText(name: 'textRankingList')),
            bottom: TabBar(
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
              ),
              indicator: CommonUnderlineTabIndicator(
                  height: 3,
                  insets: EdgeInsets.only(left: 40, right: 40),
                  borderSide: BorderSide(
                      width: 4.0, color: AppTheme.colors.themeColor)),
              labelPadding: EdgeInsets.all(0),
              indicatorColor: AppTheme.colors.themeColor,
              labelColor: AppTheme.colors.textColor,
              unselectedLabelColor: AppTheme.colors.textSubColor,
              tabs: <Widget>[
                EachTab(
                  text: getText(name: 'textBtList'),
                ),
                EachTab(
                  text: getText(name: 'textHandList'),
                ),
                if (AppConfig.hasH5)
                  EachTab(
                    text: getText(name: 'textH5List'),
                  ),
              ],
            )),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: viewService.buildComponent("game_list_bt"),
            ),
            Container(
              child: viewService.buildComponent("game_list_zk"),
            ),
            if (AppConfig.hasH5)
              Container(
                child: viewService.buildComponent("game_list_h5"),
              ),
          ],
        ),
      ));
}
