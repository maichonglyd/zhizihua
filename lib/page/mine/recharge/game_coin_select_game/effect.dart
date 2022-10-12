import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_select_channel/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCoinSelectGameState> buildEffect() {
  return combineEffects(<Object, Effect<GameCoinSelectGameState>>{
    GameCoinSelectGameAction.action: _onAction,
    GameCoinSelectGameAction.searchGame: _searchGame,
    GameCoinSelectGameAction.selectGameChannel: _selectGameChannel,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<GameCoinSelectGameState> ctx) {}

void _selectGameChannel(Action action, Context<GameCoinSelectGameState> ctx) {
  println("_selectGameChannel");
  Game game = action.payload;
  GameService.getGamesByGameName(game.gameName).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        showModalBottomSheet(
            context: ctx.context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: 244,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 79,
                      width: 360,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            child: HuoNetImage(
                              imageUrl: game.icon,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  getText(name: 'textSelectRechargeGamePlatform'),
                                  style: TextStyle(
                                      color: AppTheme.colors.textColor,
                                      fontSize: 15),
                                ),
                                Text(
                                  getText(name: 'textWhatIsDiscountPlatform'),
                                  style: TextStyle(
                                      color: Color(0xFF07A0F8), fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: data.data.list.map((channel) {
                          return channel.cpsInfo != null
                              ? Container(
                                  height: 82,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.pop(ctx.context, channel);
//                                    ctx.dispatch(GameCoinRechargeActionCreator.updateGame(game));
                                    },
                                    child: buildChannelItem(channel, ctx),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffe5e5e5)))),
                                )
                              : Container();
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).then((data) {
          println("pop");
          Navigator.pop<Game>(ctx.context, data);
        });
      }
    } else {
      //更新err
//      Navigator.pop(ctx.context);
      showToast(getText(name: 'toastGetFailed'));
    }
  });
}

Widget buildChannelItem(Game game, Context<GameCoinSelectGameState> ctx) {
  return Container(
    height: 90,
    child: Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          child: HuoNetImage(
            imageUrl: game.icon,
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            game.cpsInfo.channelName == null ? "" : game.cpsInfo.channelName,
            style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
          ),
        )),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            "${getText(name: 'textNextRecharge')}${game.rate * 10}${getText(name: 'textDiscount')}",
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor3),
          ),
        ),
        Container(
          child: Text(
            "${getText(name: 'textFirstRecharge')}${game.rate * 10}${getText(name: 'textDiscount')}",
            style: TextStyle(fontSize: 12, color: Color(0xFFF35A58)),
          ),
        )
      ],
    ),
  );
}

void _searchGame(Action action, Context<GameCoinSelectGameState> ctx) {
  GameService.searchGame(
          ctx.state.textEditingController.text, action.payload, 20)
      .then((data) {
    if (data.code == 200) {
      ctx.dispatch(
          GameCoinSelectGameActionCreator.updateGameList(data.data.list));
    }
  });
}

void _onAction(Action action, Context<GameCoinSelectGameState> ctx) {}
