import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PlayingListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textPlayRecently')),
      elevation: 0,
    ),
    body: ListView(
      children: state.playedGames
          .map((playedGame) => buildItem(playedGame, dispatch, viewService))
          .toList(),
    ),
  );
}

Widget buildItem(PlayedGame playedGame, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      dispatch(PlayingListActionCreator.gotoShopList(playedGame));
    },
    child: Container(
      height: 83,
      margin: EdgeInsets.only(left: 14, right: 14),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new HuoNetImage(
              imageUrl: playedGame.gameIcon,
              placeholder: (context, url) => new CircularProgressIndicator(),
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  playedGame.gameName,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.colors.textColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  getText(name: 'textAccountOnSale', args: [playedGame.accountCnt]),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor),
                )
              ],
            ),
          )),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
          )
        ],
      ),
    ),
  );
}
