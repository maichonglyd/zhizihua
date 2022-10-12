import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineCurrRecordState state, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: huoTitle(getText(name: 'textGameCoin')),
        leading: new IconButton(
          icon: Image.asset(
            "images/icon_toolbar_return_icon_dark.png",
            width: 40,
            height: 44,
          ),
          onPressed: () {
            Navigator.pop(viewService.context);
          },
        ),
        bottom: TabBar(
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.0,
          ),
          indicator: CommonUnderlineTabIndicator(
              height: 4,
              width: 24,
              insets: EdgeInsets.only(left: 40, right: 40),
              borderSide:
                  BorderSide(width: 4.0, color: AppTheme.colors.themeColor)),
          labelPadding: EdgeInsets.all(0),
          indicatorColor: AppTheme.colors.themeColor,
          labelColor: AppTheme.colors.textColor,
          unselectedLabelColor: AppTheme.colors.textSubColor,
          tabs: <Widget>[
            EachTab(
              text: getText(name: 'textGetHistory'),
            ),
            EachTab(
              text: getText(name: 'textUserHistory'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Container(
            child: viewService.buildComponent("take_record"),
          ),
          Container(
            child: viewService.buildComponent("use_record"),
          ),
//          Container(
//            child: viewService.buildComponent("couponExpired"),
//          ),
        ],
      ),
    ),
  );
}
