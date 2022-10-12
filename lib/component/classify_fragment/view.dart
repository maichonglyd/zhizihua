import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/classify/component.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ClassifyFragmentState state, Dispatch dispatch, ViewService viewService) {
  return null == state.tabController
      ? SizedBox()
      : Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              title: TabBar(
                controller: state.tabController,
                labelStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.0,
                ),
                indicator: CommonUnderlineTabIndicator(
                    width: 23,
                    height: 4,
                    borderSide: BorderSide(color: AppTheme.colors.themeColor)),
                labelPadding: EdgeInsets.all(0),
                indicatorColor: AppTheme.colors.themeColor,
                labelColor: AppTheme.colors.textColor,
                unselectedLabelColor: AppTheme.colors.textSubColor,
                tabs: <Widget>[
                  EachTab(
                    text: "分类",
                  ),
                  EachTab(
                    text: "周top10",
                    width: 80,
                    padding: EdgeInsets.all(0),
                  ),
                  EachTab(
                    text: "评分榜",
                  ),
                  EachTab(
                    text: "预约榜",
                  ),
                ],
              )),
          body: TabBarView(
            controller: state.tabController,
            children: <Widget>[
              Container(
                child:
                    viewService.buildComponent(ClassifyComponent.componentName),
              ),
              Container(
                child: viewService.buildComponent("first_game_new_round_list"),
              ),
              Container(
                child: viewService.buildComponent("second_game_new_round_list"),
              ),
              Container(
                child: viewService.buildComponent("third_game_new_round_list"),
              ),
            ],
          ),
        );
}
