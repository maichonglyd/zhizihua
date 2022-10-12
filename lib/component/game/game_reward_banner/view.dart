import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRewardBannerState state, Dispatch dispatch, ViewService viewService) {
  return _buildContentView(state, dispatch, viewService, 288);
}

Widget _buildContentView(GameRewardBannerState state, Dispatch dispatch,
    ViewService viewService, double height) {
  return Container(
    height: height,
    child: Swiper(
      itemCount: state.bannerList.length,
      loop: true,
      viewportFraction: 0.85,
      scale: 0.9,
      autoplay: false,
      autoplayDelay: 6000,
      pagination: SwiperPagination(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 28, top: 10),
          builder: LongDotSwiperPaginationBuilder(
              color: AppTheme.colors.lineColor,
              activeColor: AppTheme.colors.themeColor,
              size: 4,
              activeWidthSize: 13,
              space: 6,
              activeSize: 6)),
      itemBuilder: (BuildContext context, int index) {
        return _buildItemView(state, dispatch, viewService, index);
      },
    ),
  );
}

Widget _buildItemView(GameRewardBannerState state, Dispatch dispatch,
    ViewService viewService, int index) {
  GameBannerItem item = state.bannerList[index];
  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailById(viewService.context, item.game.gameId);
    },
    child: Container(
      width: 300,
      child: Stack(
        children: [
          ClipRRect(
            child: HuoNetImage(
              imageUrl: item.image ?? '',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          if (null != item.game)
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
              margin: EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x72000000), Color(0x00000000)],
                ),
              ),
              child: Container(
                height: 46,
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      margin: EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: HuoNetImage(
                          imageUrl: item.game.icon ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              item.game.gameName ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Text(
                            "${item.game.size} ${item.game.downCnt}${getText(name: 'textPlayTogetherCnt')}",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: Text(
                            "+${item.game.cplMoney}${getText(name: 'textPriceSymbol')}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          getText(name: 'textReward'),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
