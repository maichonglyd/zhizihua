import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCardState> buildEffect() {
  return combineEffects(<Object, Effect<GameCardState>>{
    GameCardAction.action: _onAction,
    GameCardAction.getCardGameList: _getCardGameList,
  });
}

void _onAction(Action action, Context<GameCardState> ctx) {}

void _getCardGameList(Action action, Context<GameCardState> ctx) {
  _getGameList(action, ctx, ctx.state.page);
}

void _getGameList(Action action, Context<GameCardState> ctx, int page) {
  GameService.getSpecialListGame(ctx.state.topicId, page, 8)
      .then((data) {
    if (data.code == 200) {
      if (data.data.list.length > 0) {
        var newPage = page + 1;
        switch (ctx.state.type) {
          case NewGameFragmentComponent.typeName:
            ctx.broadcast(NewGameFragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
          case RmbFragmentComponent.typeName:
            ctx.broadcast(RmbFragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
          case HbFragmentComponent.typeName:
            ctx.broadcast(HbFragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
          case BtFragmentComponent.typeName:
            ctx.broadcast(BtFragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
          case ZKFragmentComponent.typeName:
            ctx.broadcast(ZkFragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
          case H5FragmentComponent.typeName:
            ctx.broadcast(H5FragmentActionCreator.getCardGameList(
                ctx.state.topicId, newPage, data.data.list));
            break;
        }
      } else {
        ctx.state.page = 1;
        _getGameList(action, ctx, 1);
      }
    }
  });
}
