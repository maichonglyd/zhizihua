import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GameListState> buildEffect() {
  return combineEffects(<Object, Effect<GameListState>>{
    GameListAction.action: _onAction,
    GameListAction.selectClassify: _selectClassify,
    GameListAction.selectKfType: _selectKfType,
    GameListAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameListState> ctx) {}

void _selectKfType(Action action, Context<GameListState> ctx) {
  //更新type
  print("updateType:${action.payload}");
  ctx.state.type = action.payload;
  ctx.dispatch(GameListActionCreator.updateType(action.payload));
  ctx.dispatch(GameListActionCreator.getData(1));
}

void _selectClassify(Action action, Context<GameListState> ctx) {
  //更新tagid
  ctx.dispatch(GameListActionCreator.updateClassify(
      action.payload["type"], action.payload["tagId"]));
  ctx.dispatch(GameListActionCreator.getData(1));
}

void _init(Action action, Context<GameListState> ctx) {
  ctx.dispatch(GameListActionCreator.getData(1));
}

void _getData(Action action, Context<GameListState> ctx) {
  var requestData = {};
  //公共参数
  requestData["page"] = action.payload;
  requestData["offset"] = 10;
  print("type:${ctx.state.type}");

  switch (ctx.state.type) {
    case GameListState.TYPE_HT:
      //手游板块,这里后台返回一个新的字段来判断
//      requestData["is_bt"] = 2;
//      requestData["is_rate"] = 2;
      requestData["is_mobile"] = 2;
      break;
    case GameListState.TYPE_BT:
      requestData["is_bt"] = 2;
      break;
    case GameListState.TYPE_ZK:
      requestData["is_rate"] = 2;
      break;
    case GameListState.TYPE_H5:
      requestData["classify"] = 5;
      break;
    case GameListState.TYPE_ALL:
      break;
  }

  switch (ctx.state.pageType) {
    case GameListState.TYPE_PAGE_KF:
      requestData['server_type'] = ctx.state.kfType;
      GameService.getGameService(requestData).then((data) {
        var newData = ctx.state.refreshHelperController
            .controllerRefresh(data.data.list, ctx.state.games, action.payload);
        ctx.dispatch(GameListActionCreator.updateGameList(newData));
      });
      break;
    case GameListState.TYPE_PAGE_RANK:
      requestData['down_sort'] = 1; //用下载版的数据
      GameService.getGameListByType(requestData).then((data) {
        var newData = ctx.state.refreshHelperController
            .controllerRefresh(data.data.list, ctx.state.games, action.payload);
        ctx.dispatch(GameListActionCreator.updateGameList(newData));
      });
      break;
    case GameListState.TYPE_PAGE_CLASSIFY:
      if (ctx.state.tagId != 0) requestData["type_id"] = ctx.state.tagId;
      GameService.getGameListByType(requestData).then((data) {
        var newData = ctx.state.refreshHelperController
            .controllerRefresh(data.data.list, ctx.state.games, action.payload);
        ctx.dispatch(GameListActionCreator.updateGameList(newData));
      });
      break;
  }
}
