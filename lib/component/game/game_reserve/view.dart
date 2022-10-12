import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_appbar.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameReserveState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> items = [buildHead(viewService)];
  state.games.forEach((game) {
    items.add(buildItem(game, dispatch, viewService));
  });

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: HuoAppBar(title: getText(name: 'textNewGame'), isShowBack: true),
    body: state.refreshHelper.getEasyRefresh(
      ListView(
        children: items,
      ),
      controller: state.refreshHelperController,
      onRefresh: () {
        dispatch(GameReserveActionCreator.getData(1));
      },
      loadMore: (page) {
        dispatch(GameReserveActionCreator.getData(page));
      },
    ),
  );
}

Widget buildHead(ViewService viewService) {
  return Container(
    height: 258,
    child: Column(
      children: <Widget>[
        Image.asset(
          "images/xy_img_topbanner.png",
          height: 180,
          fit: BoxFit.cover,
        ),
        Container(
          child: Text(
            getText(name: 'textGameBooking'),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 20),
          ),
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
        Text(
          getText(name: 'textGameWillCome'),
          style: TextStyle(color: AppTheme.colors.textSubColor3, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget buildItem(Game game, Dispatch dispatch, ViewService viewService) {
  var colors = [
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
    Color(0xffF35A58),
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
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8, top: 2),
              child: Wrap(
                children: game.tagsArr
                    .sublist(
                        0, game.tagsArr.length > 3 ? 3 : game.tagsArr.length)
                    .asMap()
                    .keys
                    .map((index) => Container(
                          decoration: BoxDecoration(
                              border: new Border.all(
                                  width: 0.5, color: colors[index % 3]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9))),
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 0, bottom: 0),
                          child: Text(game.tagsArr[index % 3],
                              style: TextStyle(
                                color: colors[index % 3],
                                fontSize: 11,
                              )),
                        ))
                    .toList(),
              ),
            ),
            game.tagsArr.length > 3
                ? Container(
                    margin: EdgeInsets.only(left: 8, top: 2),
                    child: Wrap(
                      children: game.tagsArr
                          .sublist(3,
                              game.tagsArr.length > 6 ? 6 : game.tagsArr.length)
                          .asMap()
                          .keys
                          .map((index) => Container(
                                decoration: BoxDecoration(
                                    border: new Border.all(
                                        width: 0.5, color: colors[index % 3]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9))),
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 0, bottom: 0),
                                child: Text(game.tagsArr[index % 3],
                                    style: TextStyle(
                                      color: colors[index % 3],
                                      fontSize: 11,
                                    )),
                              ))
                          .toList(),
                    ),
                  )
                : Container()
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

  return Column(
    children: <Widget>[
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 12),
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
                    imageUrl: game.icon,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  child: Row(
                                    children: <Widget>[
                                      LimitedBox(
                                        child: Text(
                                          game.gameName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff333333),
                                            fontSize: 13,
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
                                      fontSize: 11,
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
                ),
              ),
              GestureDetector(
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
                                color: game.isSubscribe == 2
                                    ? Color(0xff999999)
                                    : AppTheme.colors.themeColor),
                            child: Center(
                              child: Text(
                                game.isSubscribe == 2 ? getText(name: 'textReserved') : getText(name: 'textOrder'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
//                                    color: game.isSubscribe == 2
//                                        ? Color(0xffffffff)
//                                        : Color(0xff333333),
                                    color: Color(0xffffffff),
                                    fontSize: 13),
                              ),
                            )),
                      ),
//                      child: Center(
//                        child: Text(
//                          game.is_subscribe == 2 ? "已预约" : "预约",
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                      width: 55,
//                      height: 55,
                    ),
//                    textStyle: TextStyle(
//                        color: game.is_subscribe == 2
//                            ? Color(0xff333333)
//                            : Color(0xffffffff),
//                        fontSize: 13),
//                    shape: RoundedRectangleBorder(
//                        side: new BorderSide(
//                          style: BorderStyle.solid,
//                          color: game.is_subscribe == 2
//                              ? AppTheme.colors.textSubColor
//                              : AppTheme.colors.themeColor,
//                        ),
//                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
                onTap: () {
                  if (game.isSubscribe == 2) {
                    dispatch(GameReserveActionCreator.cancel(game.gameId));
                  } else {
                    dispatch(GameReserveActionCreator.subscribe(game.gameId));
                  }
                },
              )
            ],
          ),
          onTap: () {
            dispatch(GameReserveActionCreator.gotoGame(game.gameId));
          },
        ),
      ),
      Container(
        height: 1,
        padding: EdgeInsets.only(left: 14, right: 14),
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}
