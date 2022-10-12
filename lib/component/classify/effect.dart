import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/component/classify/model/mod.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';
import 'action.dart';
import 'state.dart';

Effect<ClassifyState> buildEffect() {
  return combineEffects(<Object, Effect<ClassifyState>>{
    ClassifyAction.action: _onAction,
    Lifecycle.initState: _init,
    ClassifyAction.onSelectedTabs: _onSelectedTabs,
    ClassifyAction.gotoGameDetails: _gotoGameDetails,
    ClassifyAction.getData: _getData,
    ClassifyAction.getGameList: _getGameList,
    ClassifyAction.jumpToClassifyTab: _jumpToClassifyTab,
  });
}

void _getData(Action action, Context<ClassifyState> ctx) {
  GameService.getGamesType().then((data) {
    if (200 == data.code && data.data.list.length > 0) {
      //这里添加一个全部数据
      if (0 != FragmentConstant.classifySelectTypeId) {
        // data.data.list.insert(0, GameClassifyType(0, "全部", 0, "", 0, false));
        bool isExist = false;
        for (int i = 0; i < data.data.list.length; i++) {
          if (FragmentConstant.classifySelectTypeId == data.data.list[i].typeId) {
            data.data.list[i].isSelected = true;
            isExist = true;
            ctx.dispatch(ClassifyActionCreator.updateLeftTabs(data.data.list, FragmentConstant.classifySelectTypeId));
            break;
          }
        }

        if (!isExist) {
          // data.data.list.insert(0, GameClassifyType(0, "全部", 0, "", 0, true));
          data.data.list[0].isSelected = true;
          ctx.dispatch(ClassifyActionCreator.updateLeftTabs(data.data.list,data.data.list[0].typeId));
        }
      } else {
        // data.data.list.insert(0, GameClassifyType(0, "全部", 0, "", 0, true));
        data.data.list[0].isSelected = true;
        ctx.dispatch(ClassifyActionCreator.updateLeftTabs(data.data.list,data.data.list[0].typeId));
      }
      ctx.dispatch(ClassifyActionCreator.getGameList(1));
    }
  });
}

//获取右边的游戏列表
void _getGameList(Action action, Context<ClassifyState> ctx) {
  GameService.getTypeGameList(ctx.state.selectTypeId, action.payload)
      .then((data) {
    if (data.code == 200) {
      ctx.state.page = action.payload;
      ctx.state.refreshController.loadComplete();
      var newGames = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      ctx.dispatch(ClassifyActionCreator.updateRightGames(newGames));
    }
  }).catchError((data) {
    ctx.state.refreshHelperController.finishRefresh();
    ctx.state.refreshHelperController.finishLoad();
    ctx.state.refreshController.loadComplete();
  });
}

//跳转游戏详情
void _gotoGameDetails(Action action, Context<ClassifyState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": action.payload});
}

void _onSelectedTabs(Action action, Context<ClassifyState> ctx) {
  List<GameClassifyType> mods = new List();
  List<GameClassifyType> tabs = ctx.state.tabs;
  mods.clear();
  int selectTypeId = 0;
  int index = action.payload;

  if (tabs != null && tabs.length > 0) {
    for (int i = 0; i < tabs.length; i++) {
      GameClassifyType tab = tabs[i];
      if (index == i) {
        //当前点击就是选中的
        tab.isSelected = true;
        selectTypeId = tab.typeId;
      } else {
        tab.isSelected = false;
      }
      mods.add(tab);
    }
  }
  ctx.dispatch(ClassifyActionCreator.updateLeftTabs(mods, selectTypeId));
  ctx.dispatch(ClassifyActionCreator.getGameList(1));
}

void _init(Action action, Context<ClassifyState> ctx) {
  ctx.dispatch(ClassifyActionCreator.getData());
}

void _onAction(Action action, Context<ClassifyState> ctx) {}

void _jumpToClassifyTab(Action action, Context<ClassifyState> ctx) {
  int typeId = action.payload;
  for (int i = 0; i < ctx.state.tabs.length; i++) {
    if (typeId == ctx.state.tabs[i].typeId) {
      ctx.dispatch(ClassifyActionCreator.onSelectedTabs(i));
      break;
    }
  }
}
