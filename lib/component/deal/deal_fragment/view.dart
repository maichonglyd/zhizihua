import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealFragmentState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      title: Container(
        height: 33,
        width: 157,
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                dispatch(DealFragmentActionCreator.switchIndex(0));
              },
              child: Container(
                alignment: Alignment.center,
                height: 33,
                width: 157 / 2,
                decoration: BoxDecoration(
                    color: state.index == 0
                        ? AppTheme.colors.themeColor
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(30))),
                child: Text(
                  getText(name: 'textAccountDeal'),
                  style: TextStyle(
                      color: state.index == 0
                          ? Colors.white
                          : AppTheme.colors.textSubColor2,
                      fontSize: 12),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                dispatch(DealFragmentActionCreator.switchIndex(1));
              },
              child: Container(
                alignment: Alignment.center,
                height: 33,
                width: 157 / 2,
                decoration: BoxDecoration(
                    color: state.index == 1
                        ? AppTheme.colors.themeColor
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(30))),
                child: Text(
                  getText(name: 'textPropsMall'),
                  style: TextStyle(
                      color: state.index == 1
                          ? Colors.white
                          : AppTheme.colors.textSubColor2,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      leading: state.showBack
          ? IconButton(
              icon: Image.asset(
                "images/icon_toolbar_return_icon_dark.png",
                width: 40,
                height: 44,
              ),
              onPressed: () {
                Navigator.pop(viewService.context);
              },
            )
          : SizedBox(),
      actions: <Widget>[
//        if (state.index == 0)
        Center(
          child: IconButton(
              icon: new ImageIcon(
                AssetImage("images/icon_n_question.png"),
                size: 24,
                color: AppTheme.colors.textSubColor,
              ),
              onPressed: () {
                dispatch(DealFragmentActionCreator.gotoDealNotice());
              }),
        ),
        Container(
          height: 44,
          width: 44,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          child: IconButton(
              icon: new ImageIcon(
                AssetImage("images/icon_n_search_black.png"),
                size: 24,
                color: AppTheme.colors.textSubColor,
              ),
              onPressed: () {
                dispatch(
                    DealFragmentActionCreator.gotoSearch(state.index == 0));
              }),
        ),
      ],
    ),
    body: TabBarView(
      controller: state.tabController,
      children: <Widget>[
        viewService.buildComponent(IndexDealFragment.componentName),
        viewService.buildComponent(PropDealFragment.componentName),
      ],
    ),
  );
}
