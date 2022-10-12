import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/game/game_strategy_money/page.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameStrategyMoneyState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textMoneyStrategy')),
      centerTitle: true,
      elevation: 0,
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
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 313,
            child: Image.asset(
              "images/pic_strategy_money_bg.png",
              fit: BoxFit.fill,
            ),
          ),
          _buildSelectButtonView(state, dispatch, viewService, state.selectIndex),
          _buildPictureView(state, dispatch, viewService),
        ],
      ),
    ),
  );
}

Widget _buildSelectButtonView(GameStrategyMoneyState state, Dispatch dispatch,
    ViewService viewService, int selectIndex) {
  return Container(
    width: 332,
    height: 40,
    margin: EdgeInsets.only(left: 14, top: 10, right: 14, bottom: 21),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xFFC2A460), width: 1),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildSelectContainer(state, dispatch, viewService,
              selectIndex, GameStrategyMoneyPage.typeStrategyMoneyLevel),
        ),
        Container(
          width: 1,
          color: Color(0xFFC2A460),
        ),
        Expanded(
          flex: 1,
          child: _buildSelectContainer(state, dispatch, viewService,
              selectIndex, GameStrategyMoneyPage.typeStrategyMoneyRecharge),
        ),
        Container(
          width: 1,
          color: Color(0xFFC2A460),
        ),
        Expanded(
          flex: 1,
          child: _buildSelectContainer(state, dispatch, viewService,
              selectIndex, GameStrategyMoneyPage.typeStrategyMoneyShare),
        ),
      ],
    ),
  );
}

Widget _buildSelectContainer(GameStrategyMoneyState state, Dispatch dispatch,
    ViewService viewService, int selectIndex, int type) {
  String text = '';
  switch (type) {
    case GameStrategyMoneyPage.typeStrategyMoneyLevel:
      text = getText(name: 'textLevelReward');
      break;
    case GameStrategyMoneyPage.typeStrategyMoneyRecharge:
      text = getText(name: 'textChargeReward');
      break;
    case GameStrategyMoneyPage.typeStrategyMoneyShare:
      text = getText(name: 'textShareReward');
      break;
  }
  return GestureDetector(
    onTap: () {
      dispatch(GameStrategyMoneyActionCreator.clickButton(type));
    },
    child: Container(
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: type == selectIndex ? Color(0xFFC2A460) : Colors.white,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(
                GameStrategyMoneyPage.typeStrategyMoneyLevel == type ? 20 : 0),
            right: Radius.circular(
                GameStrategyMoneyPage.typeStrategyMoneyShare == type ? 20 : 0)),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: type == selectIndex ? Colors.white : Color(0xFFC2A460),
            fontSize: 14),
      ),
    ),
  );
}

Widget _buildPictureView(
    GameStrategyMoneyState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: 400,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            dispatch(GameStrategyMoneyActionCreator.clickButton((state.selectIndex - 1) % 3));
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 7),
            child: Image.asset(
              "images/huo_icon_back.png",
              width: 12,
              height: 20,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: _buildSwiperView(state, dispatch, viewService),
        ),
        GestureDetector(
          onTap: () {
            dispatch(GameStrategyMoneyActionCreator.clickButton((state.selectIndex + 1) % 3));
          },
          child: Container(
            padding: EdgeInsets.only(left: 7, right: 20),
            child: Image.asset(
              "images/icon_arrow_right.png",
              width: 12,
              height: 20,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSwiperView(
    GameStrategyMoneyState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: 275,
    height: 400,
    child: Swiper(
        itemCount: 3,
        controller: state.swiperController,
        viewportFraction: 1,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl;
          switch (index) {
            case 0:
              imageUrl = "images/pic_strategy_level.png";
              break;
            case 1:
              imageUrl = "images/pic_strategy_rechange.png";
              break;
            case 2:
              imageUrl = "images/pic_strategy_share.png";
              break;
          }
          return Container(
            width: 275,
            height: 400,
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          );
        }),
  );
}
