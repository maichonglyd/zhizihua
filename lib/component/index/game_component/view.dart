import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SingleGameListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
        itemCount: state.games.length,
        itemBuilder: (BuildContext context, int index) {
          return buildItem(state.games[index], state, dispatch, viewService);
        }),
  );
}

Widget buildItem(Game game, SingleGameListState state, Dispatch dispatch, ViewService viewService) {
  var colors = [
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
    Color(0xffF35A58),
  ];

  var bgColors = [
    Color(0x193D87C2),
    Color(0x19F67C29),
    Color(0x19F35A58),
  ];

  Widget finalWidget = Container();
  if (game != null) {
    if (game.serverId != null) {
      finalWidget = Container(
        margin: EdgeInsets.only(left: 10, top: 4),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "${AppUtil.formatDate2(game.startTime)} ",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 11),
            ),
            TextSpan(
                text: "${game.serverName}",
                style: TextStyle(color: Color(0xFFFF7A3D), fontSize: 11)),
          ]),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    } else {
      if (game.isBt == 2) {
        finalWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Wrap(
                      children: game.singleTag
                          .sublist(
                              0,
                              game.singleTag.length > 6
                                  ? 6
                                  : game.singleTag.length)
                          .asMap()
                          .keys
                          .map((index) => Container(
                                decoration: BoxDecoration(
                                    color: bgColors[index % 3],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3))),
                                margin: EdgeInsets.only(
                                    right: 5, bottom: 2, top: 1),
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 0, bottom: 0),
                                child: Text(game.singleTag[index % 6],
                                    style: TextStyle(
                                      color: colors[index % 3],
                                      fontSize: 9,
                                    )),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        //显示描述文字
        finalWidget = Container(
          margin: EdgeInsets.only(left: 10, top: 4),
          child: Text(
            game.oneWord,
            style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 11),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
    }
  }
  String sizeString =
      "${game.classify != 5 ? game.size : ""} ${game.classify == 5 || game.type.length <= 0 ? "" : "|"} ${game.type.length > 0 ? game.type[0] : ""}";

  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.2,
    child: Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    child: new HuoNetImage(
                      height: 45,
                      width: 45,
                      imageUrl: game.icon,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                ),
                Expanded(
                    child: Center(
//                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
//                                      height: 20,
                                  child: Row(
                                    children: <Widget>[
                                      LimitedBox(
                                        child: Text(
                                          game.gameName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff333333),
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxWidth: 150,
                                      ),
                                      game.isBt != 2 &&
                                              game.rate != null &&
                                              game.rate != 1
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 19,
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              margin: EdgeInsets.only(left: 8),
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color(0xfff35a58),
                                                    Color(0xffff9666),
                                                  ]),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Baseline(
                                                    baseline: 12,
                                                    baselineType: TextBaseline
                                                        .ideographic,
                                                    child: Text(
                                                      (game.rate * 10)
                                                          .toStringAsFixed(1)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: HuoTextSizes
                                                              .game_tag_sub,
                                                          color: Colors.white,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          letterSpacing: 0,
                                                          wordSpacing: 0,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .ideographic),
                                                    ),
                                                  ),
                                                  Baseline(
                                                    baseline: 11,
                                                    baselineType: TextBaseline
                                                        .ideographic,
                                                    child: Text(
                                                      getText(name: 'textDiscount'),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: HuoTextSizes
                                                              .game_tag_sub,
                                                          color: Colors.white,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          letterSpacing: 0,
                                                          wordSpacing: 0,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                                Container(
                                  child: Text(
                                    sizeString,
                                    style: TextStyle(
                                      color: Color(0xff666660),
                                      fontSize: 9,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 4),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                      ),
                      finalWidget,
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                )),
                game.isBt == 2
                    ? Container(
                        child: Material(
                          color: Colors.white,
                          child: SizedBox(
                            child: Center(
                              child: Container(
                                  height: HuoDimens.buttonheight,
                                  width: HuoDimens.buttonWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppTheme.colors.themeColor),
                                  child: Center(
                                    child: Text(
                                      getText(name: 'textDownload'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: HuoColors.textBtTextColor,
                                          fontSize: 13),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        child: Container(
                          child: Material(
                            color: Colors.white,
                            child: SizedBox(
                              child: Center(
                                child: Container(
                                    height: HuoDimens.buttonheight,
                                    width: HuoDimens.buttonWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppTheme.colors.themeColor),
                                    child: Center(
                                      child: Text(
                                        getText(name: 'textDownload'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: HuoColors.textBtTextColor,
                                            fontSize: 13),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          dispatch(
                              SingleGameListActionCreator.getGameListByGameName(
                                  game.gameName));
                        },
                      )
              ],
            ),
            onTap: () {
              dispatch(SingleGameListActionCreator.onAction(game));
            },
          ),
        ),
        Container(
          height: 1,
          padding: EdgeInsets.only(left: 14, right: 14),
          color: AppTheme.colors.lineColor,
        )
      ],
    ),
    secondaryActions: <Widget>[
//      if (state.isDown)
//  GestureDetector(
//    child: Container(
//      height: double.maxFinite,
//      color: Color(0xffB3B3B3),
//      alignment: Alignment.center,
//      child: Text(
//        '删\n除',
//        style: TextStyle(fontSize: 15, color: Colors.white),
//        textAlign: TextAlign.center,
//      ),
//    ),
//    onTap: () {
////      dispatch(BTGameItemActionCreator.deleteGame());
//    },
//  )
    ],
  );
}
