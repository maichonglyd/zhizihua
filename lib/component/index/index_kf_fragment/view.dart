import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    KfFragmentState state, Dispatch dispatch, ViewService viewService) {
  double totalWidth = 270;
  return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            leading: Container(
              padding: EdgeInsets.all(0),
              width: 30,
              height: 30,
              child: new IconButton(
                icon: Image.asset(
                  "images/icon_toolbar_return_icon_dark.png",
                  width: 40,
                  height: 44,
                ),
                onPressed: () {
                  Navigator.pop(viewService.context);
                },
              ),
            ),
            titleSpacing: 0,
            title: Container(
              height: 28,
              width: totalWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: state.tabList.asMap().keys.map((index) {
                  return _buildTabViewItem(state, dispatch, viewService, index);
                }).toList(),
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
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
                  text: getText(name: 'textTodayService'),
                ),
                EachTab(
                  text: getText(name: 'textFutureService'),
                ),
                EachTab(
                  text: getText(name: 'textHistoryService'),
                ),
              ],
            )),
        body: null == state.tabList || state.tabList.length < 1
            ? Container()
            : TabBarView(
                children: <Widget>[
                  Container(
                    child: viewService.buildComponent("today_kf_game_list"),
                  ),
                  Container(
                    child: viewService.buildComponent("new_kf_game_list"),
                  ),
                  Container(
                    child: viewService.buildComponent("old_kf_game_list"),
                  ),
                ],
              ),
      ));
}

Widget _buildTabViewItem(KfFragmentState state, Dispatch dispatch,
    ViewService viewService, int index) {
  double totalWidth = 270;
  var tab = state.tabList[index];
  return GestureDetector(
    onTap: () {
      dispatch(KfFragmentActionCreator.switchIndex(index));
    },
    child: Container(
      alignment: Alignment.center,
      height: 28,
      width: totalWidth / state.tabList.length,
      decoration: BoxDecoration(
          color: state.index == index
              ? AppTheme.colors.themeColor
              : Color(0xFFEEEEEE),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular((0 == index) ? 14 : 0),
              right: Radius.circular(
                  (state.tabList.length - 1 == index) ? 14 : 0))),
      child: Text(
        tab.name,
        style: TextStyle(
            color: state.index == index
                ? Colors.white
                : AppTheme.colors.textSubColor2,
            fontSize: 12),
      ),
    ),
  );
}
