import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/at_home_required/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/component.dart';
import 'package:flutter_huoshu_app/component/game/must_play_daily/component.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/component.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_gamespecial/component.dart';
import 'package:flutter_huoshu_app/component/index/index_news/component.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart'
    as top_news_state;
import 'package:flutter_huoshu_app/component/index/index_recommend1/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as row_game_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as select_tab_state;
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_curr_bean.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/bt_game_currency_item/component.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/bt_game_currency_item/state.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/state.dart';

class GameCurrencyListAdapter
    extends DynamicFlowAdapter<GameCurrencyListState> {
  GameCurrencyListAdapter()
      : super(
          pool: <String, Component<Object>>{
            GameCurrItemComponent.componentName: GameCurrItemComponent(),
          },
          connector: _BTListConnector(),
        );
}

class _BTListConnector extends ConnOp<GameCurrencyListState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameCurrencyListState state) {
    List<ItemBean> itemBeans = new List();
    if (state.games != null) {
      for (GameCurrBean game in state.games) {
        itemBeans.add(new ItemBean(
            GameCurrItemComponent.componentName,
            GameCurrItemState()
              ..game = game
              ..isWelfare = false));
      }
    }
    return itemBeans;
  }

  @override
  void set(GameCurrencyListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
