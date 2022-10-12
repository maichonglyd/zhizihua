import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'action.dart';
import 'state.dart';

Effect<DealBuyGameListState> buildEffect() {
  return combineEffects(<Object, Effect<DealBuyGameListState>>{
    DealBuyGameListAction.action: _onAction,
    DealBuyGameListAction.selectGame: _selectGame,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<DealBuyGameListState> ctx) {}

void _selectGame(Action action, Context<DealBuyGameListState> ctx) {
  Navigator.of(ctx.context).pop(action.payload);
}

void _init(Action action, Context<DealBuyGameListState> ctx) {
  DealService.getDealGameList().then((data) {
    if (data.code == 200) {
      ctx.dispatch(DealBuyGameListActionCreator.update(data.data.list));
    }
  });
}
