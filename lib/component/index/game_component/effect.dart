import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_list.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<SingleGameListState> buildEffect() {
  return combineEffects(<Object, Effect<SingleGameListState>>{
    SingleGameListAction.action: _onAction,
    SingleGameListAction.getData: _getData,
    SingleGameListAction.getGameListByGameName: _getGameListByGameName,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<SingleGameListState> ctx) {
  Game game = action.payload;
  AppUtil.gotoGameDetailOrH5Game(ctx.context, game);
}

void _getData(Action action, Context<SingleGameListState> ctx) {
//  GameService.getLikeGameList(action.payload, 10).then((data) {
//    if (data.code == 200) {
//      var newData = ctx.state.refreshHelperController
//          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
//      ctx.dispatch(SingleGameListActionCreator.updateData(newData));
//    }
//  });
}

void _init(Action action, Context<SingleGameListState> ctx) {
  ctx.dispatch(SingleGameListActionCreator.getData(1));
}

void _getGameListByGameName(Action action, Context<SingleGameListState> ctx) {
  GameService.getGamesByGameName(action.payload).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        _showDownDialog(data, ctx);
      }
    } else {}
  });
}

void _showDownDialog(GameList gameList, Context<SingleGameListState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 211,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          padding: prefix0.EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                height: 47.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  getText(name: 'textSelectDownloadPlatform'),
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.textColor,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: gameList.data.list.map((game) {
                    return game.cpsInfo != null
                        ? Container(
                            height: 82,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 8),
                                  child: HuoNetImage(
                                    imageUrl: game.cpsInfo.image,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        prefix0.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(game.cpsInfo.channelName),
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "images/gm_pic_shou.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              "${game.cpsFirstRate * 10}${getText(name: 'textDiscount')}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFFF35A58)),
                                            ),
                                          ),
                                          Image.asset(
                                            "images/gm_pic_xu.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              "${game.cpsRate * 10}${getText(name: 'textDiscount')}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme
                                                      .colors.textSubColor3),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colors.themeColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: DownView(
                                      game: game, type: TYPE_GAME_DETAILS),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffe5e5e5)))),
                          )
                        : Container();
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      });
}
