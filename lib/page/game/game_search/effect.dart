import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/repository/game_history_repository.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSearchState> buildEffect() {
  return combineEffects(<Object, Effect<GameSearchState>>{
    GameSearchAction.action: _onAction,
    GameSearchAction.select: _select,
    GameSearchAction.clear: _clear,
    GameSearchAction.getHotSearch: _getHotSearch,
    Lifecycle.initState: _init,
    GameSearchAction.gotoGameDetail: _gotoGameDetail,
  });
}

void _onAction(Action action, Context<GameSearchState> ctx) {}

void _clear(Action action, Context<GameSearchState> ctx) {
  GameHistoryRepo.delete().then((data) {
    GameHistoryRepo.getGameHistorys().then((data) {
      ctx.dispatch(GameSearchActionCreator.updateHistory(data));
    });
  });
}

void _select(Action action, Context<GameSearchState> ctx) {
  String key = ctx.state.contentController.text;

  if (key.isNotEmpty) {
    //保存记录
    GameHistoryRepo.insert(new GameHistory(ctx.state.contentController.text))
        .then((data) {
      //更新记录
      GameHistoryRepo.getGameHistorys().then((data) {
        ctx.dispatch(GameSearchActionCreator.updateHistory(data));
      });
    });

    //请求搜索
    GameService.searchGame(ctx.state.contentController.text, 1, 10)
        .then((data) {
      if (data.code == 200) {
        if (data.data.list.length > 0) {
          ctx.dispatch(GameSearchActionCreator.updateGameList(data.data.list));
        } else {
          showToast(getText(name: 'toastSearchNoResult'));
        }
      }
    });
  } else {
    showToast(getText(name: 'toastKeywordNull'));
  }
}

void _init(Action action, Context<GameSearchState> ctx) {
  GameHistoryRepo.getGameHistorys().then((data) {
    ctx.dispatch(GameSearchActionCreator.updateHistory(data));
  });
  ctx.dispatch(GameSearchActionCreator.getHotSearch());
}

void _gotoGameDetail(Action action, Context<GameSearchState> ctx) {
  AppUtil.gotoGameDetailOrH5Game(ctx.context, action.payload);
}

void _getHotSearch(Action action, Context<GameSearchState> ctx) {
  GameService.getHotSearch().then((data) {
    ctx.dispatch(GameSearchActionCreator.updateHotGameList(data.data.list));
  });
}
