import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealSelectGameState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textSelectGame')),
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: state.games.map((game) {
            return buildItem(dispatch, viewService, game);
          }).toList(),
        ),
        controller: state.refreshHelperController, onRefresh: () {
      dispatch(PropDealSelectGameActionCreator.getGames(1));
    }, loadMore: (page) {
      dispatch(PropDealSelectGameActionCreator.getGames(page));
    }),
  );
}

Widget buildItem(
    Dispatch dispatch, ViewService viewService, PlayedGame playedGame) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      Navigator.pop(viewService.context, playedGame);
    },
    child: Column(
      children: <Widget>[
        Container(
          height: 83,
          margin: EdgeInsets.only(left: 14, right: 14),
          child: Row(
            children: <Widget>[
              ClipRRect(
                child: new HuoNetImage(
                  imageUrl: playedGame.gameIcon,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
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
                      playedGame.materialCnt != null &&
                              playedGame.materialCnt > 0
                          ? getText(name: 'textNumberPropsToSell', args: [playedGame.materialCnt])
                          : "",
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
        Container(
          height: 1,
          margin: EdgeInsets.only(left: 14, right: 14),
          color: AppTheme.colors.lineColor,
        )
      ],
    ),
  );
}
