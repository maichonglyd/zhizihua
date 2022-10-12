import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/deal_sell_list_fragment/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MySellListState state, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: huoTitle(getText(name: 'textSellDetail')),
            centerTitle: true,
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
            elevation: 0,
            bottom: TabBar(
              controller: state.tabController,
              labelStyle:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                  text: getText(name: 'textWhole'),
                ),
                EachTab(
                  text: getText(name: 'textOnSale'),
                ),
                EachTab(
                  text: getText(name: 'textHasSold'),
                ),
              ],
            )),
        body: TabBarView(
          controller: state.tabController,
          children: <Widget>[
            viewService.buildComponent("DealAllSellList"),
            viewService.buildComponent("DealSellingList"),
            viewService.buildComponent("DealSoldList"),
          ],
        ),
      ));
}
