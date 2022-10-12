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
    GameCoinSelectGameState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> items = state.games.map((game) {
    return buildItem(game, dispatch, viewService);
  }).toList();
  return Scaffold(
    appBar: AppBar(
      titleSpacing: 0,
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
      title: Container(
          width: 243,
          height: 32,
          padding: EdgeInsets.only(
            left: 8,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFF0F2F5),
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Color(0xFFADADAD),
                size: 23,
              ),
              Expanded(
                child: TextField(
                  controller: state.textEditingController,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textSearchGame'),
                    hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor, fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 5, bottom: 14),
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      color: AppTheme.colors.textColor,
                      fontSize: 14),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (text) {
                    dispatch(GameCoinSelectGameActionCreator.searchGame(1));
                  },
                ),
              ),
            ],
          )),
      actions: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 14),
            child: MaterialButton(
              minWidth: 40,
              onPressed: () {
                dispatch(GameCoinSelectGameActionCreator.searchGame(1));
              },
              child: Text(getText(name: 'textSearch')),
              padding: EdgeInsets.all(0),
            ))
      ],
    ),
    body: ListView(
      children: items,
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
                height: 70,
                width: 70,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: game.icon,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                            fontSize: 15,
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
              Container(
                child: Material(
                  color: Colors.white,
                  child: Text("${game.rate * 10}${getText(name: 'textLowestDiscount')}"),
                  textStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          onTap: () {
            dispatch(GameCoinSelectGameActionCreator.selectGameChannel(game));
//              dispatch(BTGameItemActionCreator.onAction());
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
