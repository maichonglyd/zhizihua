import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/component/game/game_recommend/component.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/bt_tag_view.dart';
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRecommendState state, Dispatch dispatch, ViewService viewService) {
  int length = state.gameSpecial.gameList.length;
  double height = GameRecommendComponent.getComponentHeight(length);
  return _buildContentView(state, dispatch, viewService, height);
}

Widget _buildContentView(GameRecommendState state, Dispatch dispatch,
    ViewService viewService, double height) {
  int itemCount = state.gameSpecial.gameList.length ~/ 3 +
      (state.gameSpecial.gameList.length % 3 > 0 ? 1 : 0);
  return Container(
    height: height,
    child: Swiper(
      itemCount: itemCount,
      loop: false,
      viewportFraction: 0.88,
      pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 0),
          builder: LongDotSwiperPaginationBuilder(
              color: AppTheme.colors.lineColor,
              activeColor: AppTheme.colors.themeColor,
              size: 4,
              activeWidthSize: 13,
              space: 6,
              activeSize: 6)),
      itemBuilder: (BuildContext context, int index) {
        List<Game> gameList = [];
        int start = index * 3;
        int end = itemCount != index + 1
            ? (index + 1) * 3
            : state.gameSpecial.gameList.length;
        gameList.addAll(state.gameSpecial.gameList.sublist(start, end));
        return _buildWrapItemView(state, dispatch, viewService, gameList);
      },
    ),
  );
}

Widget _buildWrapItemView(GameRecommendState state, Dispatch dispatch,
    ViewService viewService, List<Game> games) {
  List<Widget> widgetList = [];
  for (Game game in games) {
    widgetList.add(GameItemView(
      game,
      contentHeight: GameRecommendComponent.componentItemHeight,
      contentMargin: EdgeInsets.only(right: 16),
    ));
  }
  return Column(
    children: widgetList,
  );
}

Widget _buildItemView(GameRecommendState state, Dispatch dispatch,
    ViewService viewService, Game game) {
  String gameType = '';
  if (null != game.type && game.type.length > 0) {
    for (int i = 0; i < game.type.length; i++) {
      if (i > 2) break;

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
      width: 314,
      height: 76,
      margin: EdgeInsets.only(right: 10, bottom: 8),
      child: Column(
        children: [
          Container(
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
                        child: Container(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            child: HuoNetImage(
                              imageUrl: game.icon ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (1 > game.rate)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _buildDiscountView(
                              "${(game.rate * 10).toStringAsFixed(1)}${getText(name: 'textDiscount')}"),
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
                            gameType + "${game.size}  ${game.downCnt}${getText(name: 'textPlayCnt')}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 8, top: 11),
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
