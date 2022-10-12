import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/component.dart';
import 'package:flutter_huoshu_app/component/classify_fragment/component.dart';
import 'package:flutter_huoshu_app/component/game/game_classify/component.dart';
import 'package:flutter_huoshu_app/component/video/video_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart' as home_state;
import 'view.dart';

import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/component.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/component.dart';

class SingleTickerProviderStfState<HomeState> extends ComponentState<HomeState>
    with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<HomeState> on Component<HomeState> {
  @override
  SingleTickerProviderStfState<HomeState> createState() =>
      SingleTickerProviderStfState<HomeState>();
}

class HomePage extends Page<home_state.HomeState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "HomePage";

  //闪屏页面跳转到游戏详情的标记
  static final int splash_goto_game_detail = -100;

  HomePage()
      : super(
          initState: home_state.initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<home_state.HomeState>(
              slots: <String, Dependent<home_state.HomeState>>{
                'index_fragment':
                    home_state.MineFunListConnector() + IndexFragment(),
                MineFragment.pageName:
                    home_state.MineFragmentConnector() + MineFragment(),
                'bt_fragment':
                    home_state.BtFragmentConnector() + IndexBtFragment(),
                ClassifyFragmentComponent.componentName:
                home_state.ClassifyFragmentConnector() +
                    ClassifyFragmentComponent(),
                'gameclseeify_fragment':
                    home_state.GameClassifyFragmentConnector() +
                        GameClassifyComponent(),
                'deal_fragment':
                    home_state.DealFragmentConnector() + DealFragment(),
                VideoComponent.componentName:
                    home_state.VideoFragmentConnector() + VideoComponent(),
              }),
//          middleware: <Middleware<HomeState>>[
////            logMiddleware(tag: 'ToDoListPage'),
//          ],
        );
}
