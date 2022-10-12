import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealFilterState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 55,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              dispatch(PropDealFilterActionCreator.gotoSelectGame());
            },
            child: state.playedGame != null
                ? buildGameItem(111, state.playedGame.gameName, dispatch)
                : buildItem(111, getText(name: 'textSelectGame'), state, viewService),
          ),
        ),

        Container(
          height: 16,
          width: 1,
          color: Color(0xFFA8A8A8),
          margin: EdgeInsets.only(left: 10, right: 10),
        ),
//        GestureDetector(
//          onTap: () {
//            dispatch(PropDealFilterActionCreator.showServers());
//          },
//          child: buildItem(
//              82, state.curServer == null ? S.of(viewService.context).textDistrictService : state.curServer.serverName, viewService),
//        ),
//        buildItem(62,"系统"),
        Expanded(
          child: GestureDetector(
            key: state.anchorKey,
            onTap: () {
              int type = (state.sortType % 3) + 1;
              dispatch(PropDealFilterActionCreator.updateSortType(type));
              dispatch(PropDealFilterActionCreator.selectSortType());
            },
            child: buildItem(82, getText(name: 'textPrice'), state, viewService),
          ),
        ),
      ],
    ),
  );
}

Widget buildGameItem(double width, String text, Dispatch dispatch) {
  return Container(
    height: 30,
    padding: EdgeInsets.only(left: 7, right: 7),
    decoration: BoxDecoration(
        color: AppTheme.colors.themeColor,
        borderRadius: BorderRadius.all(Radius.circular(2))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            dispatch(PropDealFilterActionCreator.deleteGame());
            dispatch(PropDealFilterActionCreator.updateGameList());
          },
          child: Image.asset(
            "images/huosdk_yy_close.png",
            width: 16,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 13),
        )
      ],
    ),
  );
}

Widget buildItem(double width, String text, PropDealFilterState state, ViewService viewService) {
  print("======buildItem ${state.sortType}");
  String imgStr = "";
  Widget imgWidget = SizedBox();
  if (text == getText(name: 'textPrice')) {
    if (1 == state.sortType) {
      imgStr = "images/icon_n_selected.png";
    } else {
      imgStr = "images/icon_n_drop_down.png";
    }
  } else {
    imgStr = "images/icon_n_drop_down.png";
  }
  imgWidget = Image.asset(
    imgStr,
    width: 12,
  );
  if (text == getText(name: 'textPrice') && 2 == state.sortType) {
    imgWidget = Transform.rotate(
        angle: pi,
        child: Image.asset(
          imgStr,
          width: 12,
        )
    );
  }
  return Container(
    height: 30,
    padding: EdgeInsets.only(left: 7, right: 7),
    decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(2))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
        ),
        imgWidget,
      ],
    ),
  );
}
