import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_new_banner/component.dart';
import 'package:flutter_huoshu_app/component/game/game_new_banner/state.dart'
    as game_new_banner;
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/component.dart';
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/state.dart'
    as index_empty_bottom;
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_util.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';

import 'reducer.dart';
import '../state.dart';

class NewGameAdapter extends DynamicFlowAdapter<NewGameFragmentState> {
  NewGameAdapter()
      : super(
          pool: getSpecialGameComponentPool({
            IndexBannerComponent.componentName: IndexBannerComponent(),
            GameNewBannerComponent.componentName: GameNewBannerComponent(),
            IndexEmptyBottomComponent.componentName:
                IndexEmptyBottomComponent(),
          }),
          connector: _NewGameConnector(),
        );
}

class _NewGameConnector extends ConnOp<NewGameFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(NewGameFragmentState state) {
    List<ItemBean> itemBeans = [];

    if (null != state.homeData && null != state.homeData.homeTopper) {
      itemBeans.add(new ItemBean(GameNewBannerComponent.componentName,
          game_new_banner.initState(state.homeData.homeTopper.list)));
    }

    itemBeans.addAll(getSpecialGameList(NewGameFragmentComponent.typeName,
        state.videoType, state.homeData, state.cardPage, state.switchSelectIndex, state.indexSelectTabState));

    itemBeans.add(ItemBean(IndexEmptyBottomComponent.componentName,
        index_empty_bottom.initState(null)));
    return itemBeans;
  }

  @override
  void set(NewGameFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
