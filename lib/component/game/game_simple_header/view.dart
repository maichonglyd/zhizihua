import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/page/game/game_kaifu/page.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSimpleHeaderState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 10, bottom: 8, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          height: 15,
          decoration: BoxDecoration(
            color: AppTheme.colors.themeColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              state.gameSpecial.topicName,
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (state.showMore)
          GestureDetector(
            onTap: () {
              switch (state.moreButtonAction) {
                case GameSimpleHeaderState.jumpToDefault:
                  dispatch(GameSimpleHeaderActionCreator.gotoSpecialList());
                  break;
                case GameSimpleHeaderState.jumpToKaiFu:
                  AppUtil.gotoPageByName(
                      viewService.context, KaifuGamePage.pageName);
                  break;
                case GameSimpleHeaderState.jumpToStrategy:
                  AppUtil.gotoPageByName(
                      viewService.context, ActivityNewsPage.pageName);
                  break;
              }
            },
            child: Text("${getText(name: 'textLookMore')}>",
                style: TextStyle(
                    color: AppTheme.colors.textSubColor, fontSize: 14)),
          ),
      ],
    ),
  );
}
