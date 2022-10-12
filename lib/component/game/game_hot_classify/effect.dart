import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/action.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';
import 'action.dart';
import 'state.dart';

Effect<GameHotClassifyState> buildEffect() {
  return combineEffects(<Object, Effect<GameHotClassifyState>>{
    GameHotClassifyAction.action: _onAction,
    GameHotClassifyAction.gotoClassify: _gotoClassify,
  });
}

void _onAction(Action action, Context<GameHotClassifyState> ctx) {
}

void _gotoClassify(Action action, Context<GameHotClassifyState> ctx) {
  FragmentConstant.classifySelectTypeId = action.payload;
  ctx.broadcast(HomeActionCreator.switchToClassify(action.payload));
  ctx.broadcast(ClassifyActionCreator.jumpToClassifyTab(action.payload));
}
