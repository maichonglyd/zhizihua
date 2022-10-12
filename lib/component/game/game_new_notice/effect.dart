import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
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
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameNewNoticeState> buildEffect() {
  return combineEffects(<Object, Effect<GameNewNoticeState>>{
    GameNewNoticeAction.action: _onAction,
    GameNewNoticeAction.gameSubscribe: _gameSubscribe,
    GameNewNoticeAction.gotoGameDetail: _gotoGameDetail,
  });
}

void _onAction(Action action, Context<GameNewNoticeState> ctx) {}

void _gameSubscribe(Action action, Context<GameNewNoticeState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }

  num gameId = action.payload;
  GameService.subscribe(gameId).then((data) {
    if (data.code == 200) {
      _updateFragment(action, ctx);
    }
  });
}

void _gotoGameDetail(Action action, Context<GameNewNoticeState> ctx) {
  AppUtil.gotoGameDetail(ctx.context, action.payload).then((value) {
    _updateFragment(action, ctx);
  });
}

void _updateFragment(Action action, Context<GameNewNoticeState> ctx) {
  switch (ctx.state.type) {
    case NewGameFragmentComponent.typeName:
      ctx.broadcast(NewGameFragmentActionCreator.getIndexData());
      break;
    case RmbFragmentComponent.typeName:
      ctx.broadcast(RmbFragmentActionCreator.getIndexData());
      break;
    case HbFragmentComponent.typeName:
      ctx.broadcast(HbFragmentActionCreator.getIndexData());
      break;
    case BtFragmentComponent.typeName:
      ctx.broadcast(BtFragmentActionCreator.getHomeData());
      break;
    case ZKFragmentComponent.typeName:
      ctx.broadcast(ZkFragmentActionCreator.getIndexData());
      break;
    case H5FragmentComponent.typeName:
      ctx.broadcast(H5FragmentActionCreator.getIndexData());
      break;
  }
}
