import 'package:extended_text/extended_text.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/component/game/game_first_round/component.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/im/text_span_builder.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/inviewnotifier/video_widget_up.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/multi_click_button.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameFirstRoundState state, Dispatch dispatch, ViewService viewService) {
  double height = 0;
  List<Widget> widgetList = [];
  for (int i = 0; i < state.games.length; i++) {
    height += GameFirstRoundComponent.getComponentItemHeight(1);
    widgetList.add(_buildNotifierListItem(
        state, dispatch, viewService, state.games[i], i));
  }

  return Container(
    width: double.infinity,
    height: height,
    child: Column(
      children: widgetList,
    ),
  );
}

Widget _buildNotifierListItem(GameFirstRoundState state, Dispatch dispatch,
    ViewService viewService, Game game, int index) {
  String gameType = '';
  if (null != game.type && game.type.length > 0) {
    for (int i = 0; i < game.type.length; i++) {
      gameType += game.type[i];
      if (i != game.type.length - 1) {
        gameType += '·';
      } else {
        gameType += '  ';
      }
    }
  }

  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, game);
    },
    child: Container(
      height: 246,
      margin: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    child: HuoNetImage(
                      imageUrl: game.icon,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          game.gameName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppTheme.colors.textColor,
                          ),
                        ),
                        Container(
                          height: 4,
                        ),
                        Text(
                          gameType + "${game.size}  ${game.downCnt}${getText(name: 'textPlayCnt')}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.colors.textSubColor),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "images/ic_pfstar_red.png",
                          height: 17,
                          width: 17,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            game.startCnt.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.colors.themeColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        getText(name: 'textNumberRating', args: [game.startMemCnt ?? 0]),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.themeColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              game.videoUrl != null && game.videoUrl != ""
                  ? Container(
                      width: double.infinity,
                      height: 186.0,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          String videoId = state.videoType + "#${index}";
                          return InViewNotifierWidget(
                            id: videoId,
                            builder: (BuildContext context, bool isInView,
                                Widget child) {
                              return ClipRRect(
                                child: VideoWidget2(
                                  play: isInView,
                                  url: game.videoUrl,
                                  videoType: videoId,
                                  gameId: game.gameId,
                                  isShowVolume: VideoUtil.getOpenVolume(),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Container(
                      height: 186,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 5),
                      child: new AspectRatio(
                        aspectRatio: 66 / 32, //横纵比 长宽比  3:2
                        child: ClipRRect(
                            child: new HuoNetImage(
                              imageUrl: game.appHotImage ?? game.pcHomeImgStyle2 ?? '',
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ),
                    ),
//              game != null && game.isSdk == 2
//                  ? _buildApplyGroup(viewService, dispatch, game)
//                  : Container()
            ],
          ),
        ],
      ),
    ),
  );
}

//添加群聊功能
//Widget _buildApplyGroup(ViewService viewService, dispatch, Game game) {
//  TextSpanBuilder _spanBuilder = TextSpanBuilder();
//  return Container(
//    height: 58,
//    alignment: Alignment.centerLeft,
//    decoration: BoxDecoration(
//        color: AppTheme.colors.groupColor,
//        borderRadius: BorderRadius.only(
//            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
//    child: Row(
//      children: <Widget>[
//        game != null && game.chatMem != null && game.chatMem.length > 0
//            ? FlutterMarquee(
//          //做成跑马灯的形式
//            children: game.chatMem
//                .asMap()
//                .keys
//                .map((index) => Row(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(left: 10, right: 10),
//                  child: ClipOval(
//                      child: Image.network(
//                        game.chatMem[index].icon,
//                        width: 30,
//                        height: 30,
//                        fit: BoxFit.cover,
//                      )),
//                ),
//                Container(
//                  height: 33,
//                  width: 132,
//                  alignment: Alignment.centerLeft,
//                  padding: EdgeInsets.only(left: 10, right: 10),
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius:
//                      BorderRadius.all(Radius.circular(6))),
//                  child: ExtendedText(
//                    game.chatMem[index].speak,
//                    maxLines: 1,
//                    overflow: TextOverflow.ellipsis,
//                    specialTextSpanBuilder: _spanBuilder,
//                    style: TextStyle(
//                        fontSize: 12,
//                        color: AppTheme.colors.textColor),
//                  ),
//                ),
//              ],
//            ))
//                .toList(),
//            onChange: (index) {},
//            onRoll: (index) {
//              // state.activityIndex = index;
//            },
//            animationDirection: AnimationDirection.t2b,
//            duration: 5)
//            : Container(),
//        Expanded(
//          child: Container(),
//        ),
//        Container(
//          margin: EdgeInsets.only(left: 15, right: 15),
//          child: Stack(
//            children: <Widget>[
//              ClickButton(
//                child: Container(
//                  height: 27,
//                  width: 70,
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                      color: AppTheme.colors.themeColor,
//                      borderRadius: BorderRadius.all(Radius.circular(14))),
//                  child: Text(
//                    "一起玩",
//                    style: TextStyle(fontSize: 12, color: Colors.white),
//                  ),
//                ),
//                onClick: () {
//                  joinGroupChat(viewService.context, game);
//                },
//              )
//            ],
//          ),
//        )
//      ],
//    ),
//  );
//}
