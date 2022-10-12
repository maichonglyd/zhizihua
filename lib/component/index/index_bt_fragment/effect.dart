import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/message/message_list/page.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';

import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<IndexBtFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<IndexBtFragmentState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    IndexBtFragmentAction.showMenu: _showMenu,
    IndexBtFragmentAction.gotoMessage: _gotoMessage,
    IndexBtFragmentAction.gotoSearch: _gotoSearch,
    IndexBtFragmentAction.getMsgCount: _getMsgCount,
    IndexBtFragmentAction.upInitInfo: _upInitInfo,
    IndexBtFragmentAction.gotoDownload: _gotoDownload,
  });
}

bool isInit = false;

void _init(Action action, Context<IndexBtFragmentState> ctx) {
//share sdk 初始化数据
  if (InitInfoUtil.loadStatus == LoadStatus.success) {
    InitInfoUtil.getInitInfo().then((initInfo) {
      List<Mod> tabs = List();
      if (initInfo.data.list != null) {
        isInit = true;
        _createController(initInfo, ctx, tabs);
      }
    });
  }
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController = new TabController(
    initialIndex: 0,
    length: ctx.state.tabs.length,
    vsync: tickerProvider,
  );
  ctx.dispatch(IndexBtFragmentActionCreator.createController(tabController));

//  var scrollController = new ScrollController();
//  ctx.dispatch(
//      IndexBtFragmentActionCreator.createScrollController(scrollController));
//  scrollController.addListener(() {
//    bool isShowBackTop = scrollController.position.pixels >= 800;
//    ctx.dispatch(IndexBtFragmentActionCreator.isShowBackTop(isShowBackTop));
//  });

  UserService.getMsgCount().then((data) {
    if (data['code'] == 200) {
      ctx.dispatch(
          IndexBtFragmentActionCreator.updateMsgCount(data['data']['count']));
    }
  });
}

void _dispose(Action action, Context<IndexBtFragmentState> ctx) {
  if (ctx.state.scrollController != null) {
    ctx.state.scrollController.dispose();
  }
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}

void _createController(
    InitInfo initInfo, Context<IndexBtFragmentState> ctx, List<Mod> tabs) {
  tabs.addAll(initInfo.data.list);

//  List<Mod> tabsTest = List();
//  tabsTest.addAll( initInfo.data.list);
//  Mod mod = new Mod("自定义专栏","自定义专栏","自定义专栏");
//  tabsTest.add(mod);
//  tabsTest.add(mod);
//  tabs.clear();
//  tabs.addAll(tabsTest);
//  HuoLog("tabs123: " + tabs.toString());

  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController = new TabController(
    initialIndex: 0,
    length: tabs.length,
    vsync: tickerProvider,
  );

  //这里要更新每个component角标
  tabController.addListener(() {
    //监听tabController,每次要更新一下状态值,这里每次切换都得重新刷新数据,这里的逻辑后面需要优化
    var type = tabs[tabController.index].type;

    String videoType = ctx.state.videoType + "#${tabController.index}";
    HuoVideoManager.setViewActive(videoType);
    LoginControl.saveTabType(type);
    HuoLog.d("${type}");
//    if (type == "bt" || type == "h5" || type == "rate") {
//      LoginControl.saveTabType(type);
//    }
  });
  ctx.dispatch(IndexBtFragmentActionCreator.updateHomeTabs(
      homeTabs: tabs, index: tabController.index));
  HuoLog.d("homeTabs: " + tabs.toString());
  ctx.dispatch(IndexBtFragmentActionCreator.createController(tabController));
}

void _gotoDownload(Action action, Context<IndexBtFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DownLoadManagePage.pageName,
      arguments: null);
}

void _gotoMessage(Action action, Context<IndexBtFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MessageListPage.pageName).then((data) {
    ctx.dispatch(IndexBtFragmentActionCreator.getMsgCount());
  });
}

void _gotoSearch(Action action, Context<IndexBtFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameSearchPage.pageName);
}

void _getMsgCount(Action action, Context<IndexBtFragmentState> ctx) {
  UserService.getMsgCount().then((data) {
    if (data['code'] == 200) {
      ctx.dispatch(
          IndexBtFragmentActionCreator.updateMsgCount(data['data']['count']));
    }
  });
}

//初始化在这里完成
void _upInitInfo(Action action, Context<IndexBtFragmentState> ctx) {
  InitInfo initInfo = action.payload;
  List<Mod> tabs = List();
  if (initInfo.data.list != null) {
    _createController(initInfo, ctx, tabs);
  }
}

void _showMenu(Action action, Context<IndexBtFragmentState> ctx) {
  showMenu(
      context: ctx.context,
      position: RelativeRect.fromLTRB(171, 70, 0, 0),
      items: <PopupMenuItem<String>>[
        PopupMenuItem(
          height: 47,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("images/n_navbar_download_icon_dark.png"),
                  size: 44,
                ),
                Text(
                  getText(name: 'textDownload'),
                  style: TextStyle(color: AppTheme.colors.textColor),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          height: 47,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ImageIcon(
                  AssetImage("images/n_navbar_messagebox_icon.png"),
                  size: 44,
                ),
                Text(
                  getText(name: 'textInformation'),
                  style: TextStyle(color: AppTheme.colors.textColor),
                )
              ],
            ),
          ),
        ),
      ]);
}
