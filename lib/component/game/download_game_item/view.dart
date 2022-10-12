import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/down/down_view2.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget buildView(
    DownloadGameItemState state, Dispatch dispatch, ViewService viewService) {
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
  if (state.game != null) {
    if (state.game.serverId != null) {
      finalWidget = Container(
        margin: EdgeInsets.only(left: 10, top: 4),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "${AppUtil.formatDate2(state.game.startTime)} ",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 11),
            ),
            TextSpan(
                text: "${state.game.serverName}",
                style: TextStyle(color: Color(0xFFFF7A3D), fontSize: 11)),
          ]),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    } else if (state.game.isBt == 2) {
      finalWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (state.game.singleTag != null && state.game.singleTag.length > 0)
              ? Container(
                  margin: EdgeInsets.only(left: 8, top: 2),
                  child: Wrap(
                    children: state.game.singleTag
                        .sublist(
                            0,
                            state.game.singleTag.length > 6
                                ? 6
                                : state.game.singleTag.length)
                        .asMap()
                        .keys
                        .map((index) => Container(
                              decoration: BoxDecoration(
                                  color: colors2[index % 6],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.5))),
                              margin:
                                  EdgeInsets.only(right: 5, top: 1, bottom: 1),
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 0, bottom: 0),
                              child: Text(state.game.singleTag[index],
                                  style: TextStyle(
                                      color: colors[index % 6],
                                      fontSize: 11,
                                      height: 1.3)),
                            ))
                        .toList(),
                  ),
                )
              : Container(),
        ],
      );
    } else if (state.isH5 == true) {
      finalWidget = Container(
        margin: EdgeInsets.only(left: 10, top: 4),
        child: Row(
          children: <Widget>[
            Image.asset(
              "images/icon_smalldianzan_normal.png",
              height: 15,
              width: 15,
            ),
            Container(
              margin: EdgeInsets.only(top: 1, left: 1, right: 8),
              child: Text(
                '1000',
                style: TextStyle(
                    fontSize: 11, color: AppTheme.colors.textSubColor2),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              "images/icon_smallzhuangfa_normal.png",
              height: 15,
              width: 15,
            ),
            Container(
              margin: EdgeInsets.only(top: 1, left: 1),
              child: Text(
                '1000',
                style: TextStyle(
                    fontSize: 11, color: AppTheme.colors.textSubColor2),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      //显示描述文字
      finalWidget = Container(
        margin: EdgeInsets.only(left: 10, top: 4),
        child: Text(
          state.game.oneWord ?? "",
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 11),
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }
  String sizeString =
      "${state.game.classify != 5 ? state.game.size : ""} ${state.game.classify == 5 || state.game.type.length <= 0 ? "" : "|"} ${state.game.type.length > 0 ? state.game.type[0] : ""}";

  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.2,
    child: Column(
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
                      imageUrl: state.game.icon,
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
                                            state.game.gameName ?? "",
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
//                          child: SizedBox(
//                            child: Center(
//                              child: Text(
//                                state.game.classify == 5 ? "去玩" : "申请\n福利",
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                            width: 55,
//                            height: 55,
//                          ),
                          child: SizedBox(
                            child: Center(
                              child: Container(
                                  height: HuoDimens.buttonheight1,
                                  width: HuoDimens.buttonWidth1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          HuoDimens.buttonRadius),
                                      color: AppTheme.colors.themeColor),
                                  child: Center(
                                    child: Text(
                                      state.game.classify == 5 ? getText(name: 'textToPlay') : getText(name: 'textToDownload'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: HuoColors.textBtTextColor,
                                          fontSize: 13),
                                    ),
                                  )),
                            ),
                          ),
//                          textStyle: TextStyle(color: Colors.red, fontSize: 13),
//                          shape: RoundedRectangleBorder(
//                              side: new BorderSide(
//                                style: BorderStyle.solid,
//                                color: Colors.red,
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      )
                    : state.isZK && 1 != state.game.rate
                        ? Container(
                            alignment: Alignment.center,
                            height: 27,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            margin: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    HuoDimens.buttonRadius),
                                color: AppTheme.colors.themeColor),
//                            decoration: BoxDecoration(
//                                gradient: LinearGradient(colors: [
//                                  Color(0xfff35a58),
//                                  Color(0xffff9666),
//                                ]),
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Baseline(
                                  baseline: 12,
                                  baselineType: TextBaseline.ideographic,
                                  child: Text(
                                    (state.game.rate * 10)
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
                        : DownView2(
                            game: state.game,
                            type: TYPE_GAME_ITEM,
                            isReserved: state.isReserved,
                            isFromDownloadManagerPage: state.isDown),
              ],
            ),
            onTap: () {
//              dispatch(BTGameItemActionCreator.onAction());
              dispatch(DownloadGameItemActionCreator.gotoGameDetails(state.game));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
        )
      ],
    ),
    secondaryActions: <Widget>[
      if (state.isDown)
//        IconSlideAction(
//          caption: '删除',
//          color: Color(0xffB3B3B3),
//          onTap: () {
//            dispatch(BTGameItemActionCreator.deleteGame());
//          },
//        )
        GestureDetector(
          child: Container(
            height: double.maxFinite,
            color: Color(0xffB3B3B3),
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textDeleteN'),
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            dispatch(DownloadGameItemActionCreator.deleteGame());
          },
        )
    ],
  );
}
