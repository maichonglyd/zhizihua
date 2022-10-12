import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_select/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/game/game_player_recharge_list/page.dart';
import 'package:flutter_huoshu_app/page/game/game_strategy_money/page.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRewardSelectState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemView(state, dispatch, viewService, GameRewardSelectComponent.typeStrategyMoney),
        _buildItemView(state, dispatch, viewService, GameRewardSelectComponent.typePlayerList),
      ],
    ),
  );
}

Widget _buildItemView(GameRewardSelectState state, Dispatch dispatch,
    ViewService viewService, int type) {
  String icon;
  String name;
  Color bgColor;
  Color textColor;
  Function() click;
  switch (type) {
    case GameRewardSelectComponent.typeStrategyMoney:
      icon = "images/icon_strategy.png";
      name = getText(name: 'textMoneyStrategy');
      bgColor = Color(0xFFFFF0F0);
      textColor = Color(0xFFF35A58);
      click = () {
        AppUtil.gotoPageByName(viewService.context, GameStrategyMoneyPage.pageName);
      };
      break;
    case GameRewardSelectComponent.typePlayerList:
      icon = "images/icon_trophy.png";
      name = getText(name: 'textPlayerList');
      bgColor = Color(0xFFFFF4E5);
      textColor = Color(0xFFFF8500);
      click = () {
        AppUtil.gotoPageByName(viewService.context, GamePlayerRechargeListPage.pageName);
      };
      break;
  }
  return GestureDetector(
    onTap: () {
      if (null != click) {
        click();
      }
    },
    child: Container(
      width: 159,
      height: 46,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Text(
              name,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
          )
        ],
      ),
    ),
  );
}
