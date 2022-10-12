import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/redux_connector/global_connector.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner;
import 'package:flutter_huoshu_app/component/index/index_fragment/state.dart';

import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as index_top_tab;
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game;
import 'package:flutter_huoshu_app/component/index/index_pager/component.dart';
import 'package:flutter_huoshu_app/component/index/index_pager/state.dart'
    as index_view_pager;
import 'reducer.dart';

class IndexFragmentAdapter extends DynamicFlowAdapter<IndexFragmentState> {
  IndexFragmentAdapter()
      : super(
          pool: <String, Component<Object>>{
            'index_banner': IndexBannerComponent(),
            'index_top_tab': IndexTopTabComponent(),
            'index_row_game': IndexRowGameComponent(),
//            'index_page': IndexViewPagerComponent()
          },
          connector: _IndexFragmentConnector(),
          reducer: buildReducer(),
        );
}

class _IndexFragmentConnector
    extends ConnOp<IndexFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(IndexFragmentState state) {
    List<ItemBean> datas = [];
    if (state.imageVOs?.isNotEmpty == true) {
//      datas.add(new ItemBean("index_banner",
//          index_banner.initState(state.imageVOs)..copyGlobalFrom(state)));
    }
    // datas.add(new ItemBean("index_top_tab", index_top_tab.initState()));
    datas.add(new ItemBean("index_row_game", index_row_game.initState()));
//    datas.add(new ItemBean("index_page", index_view_pager.initState()));

    return datas;
  }

  @override
  void set(IndexFragmentState state, List<ItemBean> subState) {
    super.set(state, subState);
  }
}
