import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    NewGameTipState state, Dispatch dispatch, ViewService viewService) {
  if (state.games == null || state.games.length == 0) {
    return Container();
  }
  return Container(
    height: 210,
    padding: EdgeInsets.only(left: 14, right: 14, top: 0),
    margin: EdgeInsets.only(bottom: 10, top: 4),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Container(
          height: 45,
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(getText(name: 'textNewGameNotice'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontSize: HuoTextSizes.title,
                        fontWeight: FontWeight.w600)),
              ),
//              Icon(
//                Icons.arrow_forward_ios,
//                size: 12,
//              )
            ],
          ),
        ),
        Expanded(
            child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: state.games.length > 0
                  ? buildItem(Color(0xffFF9356), Color(0xffFF5D45),
                      state.games[0], viewService)
                  : Container(),
            ),
            Expanded(
              flex: 1,
              child: state.games.length > 1
                  ? buildItem(Color(0xff2DE089), Color(0xff0BC3B0),
                      state.games[1], viewService)
                  : Container(),
            ),
            Expanded(
              flex: 1,
              child: state.games.length > 2
                  ? buildItem(Color(0xffF1DE36), Color(0xffE9B600),
                      state.games[2], viewService)
                  : Container(),
            )
          ],
        ))
      ],
    ),
  );
}

Widget buildItem(
    Color startColor, Color endColor, Game game, ViewService viewService) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 138,
            width: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    startColor,
                    endColor,
                  ]),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                      child: HuoNetImage(
                        imageUrl: game.icon,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(game.gameName,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HuoTextSizes.second_title,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1, left: 2, right: 2),
                  child: Text(
                      (game.singleTag != null && game.singleTag.length > 0)
                          ? game.singleTag[0]
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HuoTextSizes.game_tag_sub,
                          fontWeight: FontWeight.normal)),
                ),
                Container(
                  width: 55,
                  height: 27,
                  margin: EdgeInsets.only(top: 9),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text((game.rate * 10).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.colors.themeColor,
                              fontSize: HuoTextSizes.content,
                              fontWeight: FontWeight.bold)),
                      Text(getText(name: 'textDiscount'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.colors.themeColor,
                              fontSize: HuoTextSizes.game_title_sub,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, game);
    },
  );
}
