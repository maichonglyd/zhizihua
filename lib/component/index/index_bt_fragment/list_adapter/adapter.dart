import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/gm_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart';

import '../reducer.dart';

class IndexBtFragmentAdapter extends DynamicFlowAdapter<IndexBtFragmentState> {
  IndexBtFragmentAdapter()
      : super(
          pool: <String, Component<Object>>{
            BtFragmentComponent.componentName: BtFragmentComponent(),
            HtFragmentComponent.componentName: HtFragmentComponent(),
            ZKFragmentComponent.componentName: ZKFragmentComponent(),
            JpFragmentComponent.componentName: JpFragmentComponent(),
            GmFragmentComponent.componentName: GmFragmentComponent(),
            H5FragmentComponent.componentName: H5FragmentComponent(),
            GlFragmentComponent.componentName: GlFragmentComponent(),
            HbFragmentComponent.componentName: HbFragmentComponent(),
            RmbFragmentComponent.componentName: RmbFragmentComponent(),
            NewGameFragmentComponent.componentName: NewGameFragmentComponent(),
          },
          connector: _IndexBtFragmentAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _IndexBtFragmentAdapterConnector
    extends ConnOp<IndexBtFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(IndexBtFragmentState state) {
    return state.itemBeanList;
  }

  @override
  void set(IndexBtFragmentState state, List<ItemBean> items) {
    state.itemBeanList = items;
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
