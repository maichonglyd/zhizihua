import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_datails_comment_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_datails_comment_head/state.dart'
    as game_details_comment_state;
import 'package:flutter_huoshu_app/component/game/game_details_comment_item/component.dart';
import 'package:flutter_huoshu_app/component/game/game_details_comment_item/state.dart'
    as comment_item_state;
import 'package:flutter_huoshu_app/component/game/game_details_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/game_details_images/component.dart';
import 'package:flutter_huoshu_app/component/game/game_details_images/state.dart'
    as game_details_images_state;
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'package:flutter_huoshu_app/model/game/game_comments.dart'
    as game_comments;

import 'reducer.dart';

class GameDetailsAdapter extends DynamicFlowAdapter<GameDetailsComponentState> {
  GameDetailsAdapter()
      : super(
          pool: <String, Component<Object>>{
            GameDetailsImagesComponent.componentName:
                GameDetailsImagesComponent(),
            GameCommentHeadComponent.componentName: GameCommentHeadComponent(),
            GameCommentItemComponent.componentName: GameCommentItemComponent(),
          },
          connector: _GameDetailsConnector(),
          reducer: buildReducer(),
        );
}

class _GameDetailsConnector
    extends ConnOp<GameDetailsComponentState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameDetailsComponentState state) {
    List<ItemBean> itemBeans = <ItemBean>[
      if (state.images != null && state.images.length > 0)
        new ItemBean(
            GameDetailsImagesComponent.componentName,
            game_details_images_state.initState(
                state.images,
                state.news,
                state.desc,
                state.videoPlayerController,
                state.scrollController,
                state.hasVolume,
                state.isBt,
                state.vipDescription,
                state.activityNews,
                state.gameList)),
      // new ItemBean(GameCommentHeadComponent.componentName,
      //     game_details_comment_state.initState(state.starCnt, state.gameId)),
    ];
    // for (game_comments.Comment comment in state.comments) {
    //   itemBeans.add(new ItemBean(GameCommentItemComponent.componentName,
    //       comment_item_state.initState(comment)));
    // }
    return itemBeans;
  }

  @override
  void set(GameDetailsComponentState state, List<ItemBean> items) {
//    for (ItemBean item in items) {
//      if (GameDetailsImagesComponent.componentName == item.type) {
//        state.gameDetailsImagesState = item.data;
//        continue;
//      }
//    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
