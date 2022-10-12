import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator_radius.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ActivityHomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: SafeArea(
        child: DefaultTabController(
      length: 4,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TabContainer(
              height: 44,
              child: new TabBar(
                labelStyle:
                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(
                  fontSize: 17.0,
                ),
                indicator: CommonUnderlineRadiusTabIndicator(
                    height: 3,
                    width: 25,
                    insets: EdgeInsets.only(left: 25, right: 25),
                    borderSide: BorderSide(
                        width: 4.0, color: AppTheme.colors.themeColor)),
                labelPadding: EdgeInsets.all(0),
                indicatorColor: Colors.transparent,
                labelColor: AppTheme.colors.textColor,
                unselectedLabelColor: AppTheme.colors.textSubColor,
                tabs: <Widget>[
                  EachTab(
                    padding: EdgeInsets.all(0),
                    text: getText(name: 'textStrategy'),
                  ),
                  EachTab(
                    padding: EdgeInsets.all(0),
                    text: getText(name: 'textGift'),
                  ),
                  EachTab(
                    padding: EdgeInsets.all(0),
                    text: getText(name: 'textActivity'),
                  ),
                  EachTab(
                    padding: EdgeInsets.all(0),
                    text: getText(name: 'textNotice'),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              children: <Widget>[
                Container(
                  child: viewService.buildComponent("strategy_fragment"),
                ),
                Container(
                  child: viewService.buildComponent("giftlist_fragment"),
                ),
                Container(
                  child: viewService.buildComponent("activity_fragment"),
                ),
//            viewService.buildComponent("jp_fragment"),
//              Container(),
//              Container(),
                Container(
                  child: viewService.buildComponent("notice_fragment"),
                ),
//            viewService.buildComponent("gm_fragment"),
              ],
            ))
          ],
        ),
      ),
    )),
  );
}
