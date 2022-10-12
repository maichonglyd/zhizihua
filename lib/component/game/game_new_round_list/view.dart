import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/bt_tag_view.dart';
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/little_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameNewRoundListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: state.refreshHelper.getEasyRefresh(
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildItemView(state, dispatch, viewService, index);
        },
        itemCount: state.gameList.length,
      ),
      onRefresh: () {
        dispatch(GameNewRoundListActionCreator.getData(1));
      },
      loadMore: (page) {
        dispatch(GameNewRoundListActionCreator.getData(page));
      },
      controller: state.refreshHelperController,
    ),
  );
}

Widget _buildItemView(GameNewRoundListState state, Dispatch dispatch,
    ViewService viewService, int index) {
  Game game = state.gameList[index];
  String gameType = '';
  if (null != game.type && game.type.length > 0) {
    for (int i = 0; i < game.type.length; i++) {
      gameType += game.type[i];
      if (i != game.type.length - 1) {
        gameType += '·';
      } else {
        gameType += '  ';
      }
    }
  }
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      AppUtil.gotoGameDetailById(viewService.context, game.gameId);
    },
    child: Container(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              children: [
                buildRankView(index, textColor: AppTheme.colors.themeColor),
                Expanded(
                  child: GameItemView(game, contentHeight: 84, showSplitView: false, gameIconWidth: 60, contentMargin: EdgeInsets.only(left: 13),),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppTheme.colors.lineColor,
            margin: EdgeInsets.only(left: 0, top: 10, right: 0),
          ),
        ],
      ),
    ),
  );
}
