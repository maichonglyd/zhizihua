import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/bt_tag_view.dart';
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSpecialPageState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  if (null != state.topicData) {
    widgetList.add(_buildHeaderView(state, dispatch, viewService));
    widgetList.add(_buildImageBottomText(state, dispatch, viewService));
  }
  if (null != state.games && state.games.length > 0) {
    for (Game game in state.games) {
      widgetList.add(GameItemView(
        game,
        contentMargin: EdgeInsets.only(left: 10, right: 20),
      ));
    }
  }
  return Scaffold(
    appBar: AppBar(
      title: huoTitle(state.title),
      centerTitle: true,
      elevation: 0,
    ),
    body: state.refreshHelper.getEasyRefresh(
      ListView(
        children: widgetList,
      ),
      onRefresh: () {
        dispatch(GameSpecialPageActionCreator.getSpecialListGame(1));
      },
      loadMore: (page) {
        dispatch(GameSpecialPageActionCreator.getSpecialListGame(page));
      },
      controller: state.refreshHelperController,
    ),
  );
}

Widget _buildHeaderView(
    GameSpecialPageState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailById(viewService.context, state.topicData.gameId);
    },
    child: Container(
      width: double.infinity,
      height: 174,
      child: HuoNetImage(
        imageUrl: state.topicData.image ?? '',
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget _buildImageBottomText(
    GameSpecialPageState state, Dispatch dispatch, ViewService viewService) {
  return null != state.topicData && state.topicData.desc.isNotEmpty
      ? Container(
          color: AppTheme.colors.lineColor,
          padding: EdgeInsets.all(12),
          child: Text(
            state.topicData.desc,
            style: TextStyle(color: AppTheme.colors.themeColor, fontSize: 11),
          ),
        )
      : SizedBox();
}

Widget _buildItemView(GameSpecialPageState state, Dispatch dispatch,
    ViewService viewService, Game game) {
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
      width: double.infinity,
      height: 74,
      margin: EdgeInsets.only(
        left: 8,
        right: 15,
      ),
      child: Column(
        children: [
          Container(
            height: 63,
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Container(
                  width: 68,
                  height: 63,
                  margin: EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: HuoNetImage(
                          width: 60,
                          height: 60,
                          imageUrl: game.icon ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (1 > game.rate)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _buildDiscountView(
                              "${(game.rate * 10).toStringAsFixed(1)}折"),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.gameName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppTheme.colors.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            gameType + "${game.size}  ${game.downCnt}人在玩",
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor,
                                fontSize: 11),
                          ),
                        ),
                        shouldShowBtTag(game.btTags, game.isBt)
                            ? buildBtTagView(game.btTags)
                            : Text(
                                game.oneWord,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.colors.textSubColor,
                                    fontSize: 11),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(bottom: 1),
            color: AppTheme.colors.bgColor,
          )
        ],
      ),
    ),
  );
}

Widget _buildDiscountView(String discount) {
  return Container(
    width: 40,
    height: 18,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF4605A),
            Color(0xFFFD9064),
          ]),
    ),
    child: Text(
      discount,
      style: TextStyle(
          color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
    ),
  );
}
