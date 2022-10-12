import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_community/state.dart';
import 'package:flutter_huoshu_app/component/game/game_datails_comment_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_datails_comment_head/state.dart'
    as game_details_comment_state;
import 'package:flutter_huoshu_app/component/game/game_details_comment_item/component.dart';
import 'package:flutter_huoshu_app/component/game/game_details_comment_item/state.dart'
    as comment_item_state;

import 'package:flutter_huoshu_app/model/game/game_comments.dart'
    as game_comments;

import 'reducer.dart';

class GameCommunityAdapter extends DynamicFlowAdapter<GameCommunityState> {
  GameCommunityAdapter()
      : super(
          pool: <String, Component<Object>>{
            GameCommentHeadComponent.componentName: GameCommentHeadComponent(),
            GameCommentItemComponent.componentName: GameCommentItemComponent(),
          },
          connector: _GameDetailsConnector(),
          reducer: buildReducer(),
        );
}

class _GameDetailsConnector extends ConnOp<GameCommunityState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameCommunityState state) {
    List<ItemBean> itemBeans = <ItemBean>[];
    itemBeans.add(ItemBean(GameCommentHeadComponent.componentName,
        game_details_comment_state.initState(state.starCnt, state.gameId)));
    for (game_comments.Comment comment in state.comments) {
      itemBeans.add(ItemBean(GameCommentItemComponent.componentName,
          comment_item_state.initState(comment, state.gameId)));
    }
    return itemBeans;
  }

  @override
  void set(GameCommunityState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
