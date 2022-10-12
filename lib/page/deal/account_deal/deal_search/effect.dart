import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/repository/deal_history_repository.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<DealSearchState> buildEffect() {
  return combineEffects(<Object, Effect<DealSearchState>>{
    GameSearchAction.action: _onAction,
    GameSearchAction.select: _select,
    GameSearchAction.clear: _clear,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<DealSearchState> ctx) {}

void _clear(Action action, Context<DealSearchState> ctx) {
  DealHistoryRepo.delete().then((data) {
    DealHistoryRepo.getDealHistorys().then((data) {
      ctx.dispatch(GameSearchActionCreator.updateHistory(data));
    });
  });
}

void _select(Action action, Context<DealSearchState> ctx) {
  String key = ctx.state.contentController.text;

  if (key.isNotEmpty) {
    //保存记录
    DealHistoryRepo.insert(new DealHistory(ctx.state.contentController.text))
        .then((data) {
      //更新记录
      DealHistoryRepo.getDealHistorys().then((data) {
        ctx.dispatch(GameSearchActionCreator.updateHistory(data));
      });
    });

    //请求搜索
    DealService.searchDealGoods(1, 10, ctx.state.contentController.text)
        .then((data) {
      if (data.code == 200) {
        if (data.data.list.length > 0) {
          ctx.dispatch(
              GameSearchActionCreator.updateDealGoodsList(data.data.list));
        } else {
          showToast(getText(name: 'toastSearchNoResult'));
        }
      }
    });
  } else {
    showToast(getText(name: 'toastKeywordNull'));
  }
}

void _init(Action action, Context<DealSearchState> ctx) {
  DealHistoryRepo.getDealHistorys().then((data) {
    ctx.dispatch(GameSearchActionCreator.updateHistory(data));
  });
}
