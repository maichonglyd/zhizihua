import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/mine/integral_record/expend/component.dart';
import 'package:flutter_huoshu_app/component/mine/integral_record/income/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IntegralRecordState state, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: huoTitle(getText(name: 'textGold')),
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
            controller: state.tabController,
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 16.0,
            ),
            indicator: CommonUnderlineTabIndicator(
                insets: EdgeInsets.only(left: 35, right: 35),
                borderSide:
                    BorderSide(width: 4.0, color: AppTheme.colors.themeColor)),
            indicatorColor: AppTheme.colors.themeColor,
            labelColor: AppTheme.colors.textColor,
            unselectedLabelColor: AppTheme.colors.textSubColor,
            tabs: <Widget>[
              EachTab(
                text: getText(name: 'textIncomeHistory'),
              ),
              EachTab(
                text: getText(name: 'textConsumeHistory'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: state.tabController,
          children: <Widget>[
            viewService.buildComponent(IntegralIncomeComponent.componentName),
            viewService.buildComponent(IntegralExpendComponent.componentName),
          ],
        ),
      ));
}
