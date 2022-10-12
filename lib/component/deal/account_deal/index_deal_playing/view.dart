import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealPlayingState state, Dispatch dispatch, ViewService viewService) {
  int count = 2;
  if (state.playedGame.length == 1) {
    count = 1;
  }
  if (state.playedGame.length == 2) {
    count = 2;
  }
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        buildNextTitleItem(getText(name: 'textPlayRecently'), dispatch),
        Container(
          height: 81,
          margin: EdgeInsets.only(left: 14, right: 14),
          child: Row(
            children: state.playedGame
                .sublist(0, count)
                .map((playedGame) => buildPlayingGameItem(playedGame, dispatch, viewService))
                .toList(),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SplitLine()
      ],
    ),
  );
}

Widget buildPlayingGameItem(PlayedGame playedGame, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      dispatch(DealPlayingActionCreator.gotoDealShopList(playedGame));
    },
    child: Container(
      width: 166,
      child: Row(
        children: <Widget>[
          SizedBox.fromSize(
            size: Size(55, 55),
            child: ClipRRect(
              child: new HuoNetImage(
                imageUrl: playedGame.gameIcon,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(11)),
            ),
          ),
          Container(
            width: 110,
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  playedGame.gameName,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.colors.textColor,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                Text(
                  getText(name: 'textAccountOnSale', args: [playedGame.accountCnt]),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildNextTitleItem(String title, Dispatch dispatch) {
  return Container(
    height: 45,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Row(
      children: <Widget>[
        Container(
          height: 15,
          width: 5,
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
        Expanded(
          child: Text(title,
              style: commonTextStyle(
                  AppTheme.colors.textColor, HuoTextSizes.second_title)),
        ),
        GestureDetector(
          child: Text(getText(name: 'textWholeGame'),
              style: commonTextStyle(
                  AppTheme.colors.textSubColor, HuoTextSizes.game_title_sub)),
          onTap: () {
            dispatch(DealPlayingActionCreator.gotoAllPlayingPage());
          },
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size) {
  return TextStyle(color: color, fontSize: size);
}
