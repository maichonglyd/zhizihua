import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/inviewnotifier/video_widget_up.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/down/down_view2.dart' as down_view;
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'action.dart';

Widget buildView(
    GameSpecialHeadState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 425,
    padding: EdgeInsets.only(left: 14, right: 14, top: 0),
    margin: EdgeInsets.only(bottom: 0, top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (state.gameSpecial.gameUrl.isNotEmpty) {
              AppUtil.gotoH5Game(viewService.context, state.gameSpecial.gameUrl,
                  state.gameSpecial.direction);
            } else {
              dispatch(GameSpecialActionCreator.gotoGameDetails(
                  state.gameSpecial.game));
            }
          },
          child: state.gameSpecial.videoUrl != null &&
                  state.gameSpecial.videoUrl.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 160,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      String videoId = state.videoType + "#0";
                      return InViewNotifierWidget(
                        id: videoId,
                        builder: (BuildContext context, bool isInView,
                            Widget child) {
                          return ClipRRect(
                            child: VideoWidget2(
                              play: isInView,
                              url: state.gameSpecial.videoUrl,
                              videoType: "${state.videoType}",
                              gameId:
                                  AppUtil.stringToNum(state.gameSpecial.gameId),
                            ),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(5)),
                          );
                        },
                      );
                    },
                  ),
                )
              : state.gameSpecial.image.isNotEmpty
                  ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (state.gameSpecial.gameUrl != null &&
                            state.gameSpecial.gameUrl.isNotEmpty) {
                          AppUtil.gotoH5Game(
                              viewService.context,
                              state.gameSpecial.gameUrl,
                              state.gameSpecial.direction);
                        } else {
                          dispatch(GameSpecialActionCreator.gotoGameDetails(
                              state.gameSpecial.game));
                        }
                      },
                      child: Container(
                        height: 160,
                        width: 360,
                        child: ClipRRect(
                          child: new HuoNetImage(
                            imageUrl: state.gameSpecial.image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    )
                  : Container(),
        ),
        GameItemView(
          state.gameSpecial.game,
          contentMargin: EdgeInsets.all(0),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: state.gameSpecial.gameList != null &&
                        state.gameSpecial.gameList.length > 0
                    ? buildItem(state, state.gameSpecial.gameList[0], dispatch,
                        viewService)
                    : Container(),
              ),
              Expanded(
                flex: 1,
                child: state.gameSpecial.gameList != null &&
                        state.gameSpecial.gameList.length > 1
                    ? buildItem(state, state.gameSpecial.gameList[1], dispatch,
                        viewService)
                    : Container(),
              ),
              Expanded(
                flex: 1,
                child: state.gameSpecial.gameList != null &&
                        state.gameSpecial.gameList.length > 2
                    ? buildItem(state, state.gameSpecial.gameList[2], dispatch,
                        viewService)
                    : Container(),
              )
            ],
          ),
        ))
      ],
    ),
  );
}

Widget buildItem(GameSpecialHeadState state, Game game, Dispatch dispatch,
    ViewService viewService) {
  return GestureDetector(
    onTap: () {
      dispatch(GameSpecialActionCreator.gotoGameDetails(game));
    },
    child: Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: double.maxFinite,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffF8F8F8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  margin: EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 5),
                  child: Text(game.gameName,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: HuoTextSizes.second_title,
                          fontWeight: FontWeight.w600)),
                ),
                state.isZK && (null != game.rate && 1 != game.rate)
                    ? Container(
                        alignment: Alignment.center,
                        width: 55,
                        height: 27,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(HuoDimens.buttonRadius),
                            color: AppTheme.colors.themeColor),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Baseline(
                              baseline: 12,
                              baselineType: TextBaseline.ideographic,
                              child: Text(
                                (game.rate * 10).toStringAsFixed(1).toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: HuoTextSizes.content,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    letterSpacing: 0,
                                    wordSpacing: 0,
                                    textBaseline: TextBaseline.ideographic),
                              ),
                            ),
                            Baseline(
                              baseline: 11,
                              baselineType: TextBaseline.ideographic,
                              child: Text(
                                getText(name: 'textDiscount'),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: HuoTextSizes.game_tag_sub,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    letterSpacing: 0,
                                    wordSpacing: 0,
                                    textBaseline: TextBaseline.alphabetic),
                              ),
                            ),
                          ],
                        ),
                      )
                    : DownView(game: game, type: TYPE_GAME_ITEM),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildGameViewItem(
    GameSpecialHeadState state, Game game, ViewService viewService) {
  if (game == null) {
    return Container();
  }
  var colors = [
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
    Color(0xffF35A58),
    Color(0xffF35A58),
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
  ];
  var colors2 = [
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
    Color(0xffFFF5F5),
    Color(0xffFFF5F5),
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
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
    } else if (game.isBt == 2) {
      finalWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8, top: 2),
            child: Wrap(
              children: game.tagsArr
                  .sublist(0, game.tagsArr.length > 3 ? 3 : game.tagsArr.length)
                  .asMap()
                  .keys
                  .map((index) => Container(
                        decoration: BoxDecoration(
                            color: colors2[index % 6],
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.5))),
                        margin: EdgeInsets.only(right: 5),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 0, bottom: 0),
                        child: Text(game.tagsArr[index % 3],
                            style: TextStyle(
                              color: colors[index % 6],
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
                                  color: colors2[index % 6],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.5))),
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 0, bottom: 0),
                              child: Text(game.tagsArr[index + 3],
                                  style: TextStyle(
                                    color: colors[index % 6],
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
  String sizeString =
      "${game.classify != 5 ? game.size : ""} ${game.classify == 5 || game.type.length <= 0 ? "" : "|"} ${game.type.length > 0 ? game.type[0] : ""}";
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.2,
    child: Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 12, bottom: 12),
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
              state.isWelfare
                  ? Container(
                      child: Material(
                        color: Colors.white,
                        child: SizedBox(
                          child: Center(
                            child: Container(
                                height: HuoDimens.buttonheight,
                                width: HuoDimens.buttonWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        HuoDimens.buttonRadius),
                                    color: AppTheme.colors.themeColor),
                                child: Center(
                                  child: Text(
                                    game.classify == 5
                                        ? getText(name: 'textToPlay')
                                        : getText(name: 'textToDownload'),
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
                  : state.isZK && (null != game.rate && 1 != game.rate)
                      ? Container(
                          alignment: Alignment.center,
                          height: 27,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(HuoDimens.buttonRadius),
                              color: AppTheme.colors.themeColor),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Baseline(
                                baseline: 12,
                                baselineType: TextBaseline.ideographic,
                                child: Text(
                                  (game.rate * 10)
                                      .toStringAsFixed(1)
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: HuoTextSizes.content,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      letterSpacing: 0,
                                      wordSpacing: 0,
                                      textBaseline: TextBaseline.ideographic),
                                ),
                              ),
                              Baseline(
                                baseline: 11,
                                baselineType: TextBaseline.ideographic,
                                child: Text(
                                  getText(name: 'textDiscount'),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: HuoTextSizes.game_tag_sub,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      letterSpacing: 0,
                                      wordSpacing: 0,
                                      textBaseline: TextBaseline.alphabetic),
                                ),
                              ),
                            ],
                          ),
                        )
                      : down_view.DownView2(game: game, type: TYPE_GAME_ITEM),
            ],
          ),
        ),
        Container(
          //padding: EdgeInsets.only(left: 14, right: 14),
          child: Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
        )
      ],
    ),
  );
}
