import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameNewNoticeState> buildEffect() {
  return combineEffects(<Object, Effect<GameNewNoticeState>>{
    Lifecycle.initState: _init,
    GameNewNoticeAction.action: _onAction,
    GameNewNoticeAction.getData: _getData,
    GameNewNoticeAction.gameSubscribe: _gameSubscribe,
  });
}

void _onAction(Action action, Context<GameNewNoticeState> ctx) {
}

void _init(Action action, Context<GameNewNoticeState> ctx) {
  _getIndexData(action, ctx);
}

void _getData(Action action, Context<GameNewNoticeState> ctx) {
  int page = action.payload;
  GameService.getSpecialListGame(ctx.state.specialId, page, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.games;
      if (1 == page) {
        newData = data.data.list;
        ctx.state.refreshController.refreshCompleted();
      } else {
        newData.addAll(data.data.list);
        ctx.state.refreshController.loadComplete();
      }
      ctx.state.page += 1;
      ctx.dispatch(GameNewNoticeActionCreator.updateData(newData));
    }
  });
}

void _gameSubscribe(Action action, Context<GameNewNoticeState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }

  num gameId = action.payload;
  GameService.subscribe(gameId).then((data) {
    if (data.code == 200) {
      _getIndexData(action, ctx);
    }
  });
}

void _getIndexData(Action action, Context<GameNewNoticeState> ctx) {
  GameService.getSpecialListGame(ctx.state.specialId, 1, 10).then((data) {
    if (data.code == 200) {
      ctx.state.page = 2;
      ctx.dispatch(GameNewNoticeActionCreator.updateData(data.data.list));
    }
  });
}
