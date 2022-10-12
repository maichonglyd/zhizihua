import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/inviewnotifier/video_widget_up.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameNewNoticeState state, Dispatch dispatch, ViewService viewService) {
  return _buildContentView(state, dispatch, viewService);
}

Widget _buildContentView(
    GameNewNoticeState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: 242,
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return InViewNotifierWidget(
          id: state.videoType,
          builder: (BuildContext context, bool isInView, Widget child) {
            return Container(
              width: double.infinity,
              height: 242,
              child: Swiper(
                itemCount: state.games.length,
                loop: false,
                viewportFraction: 0.9,
                onIndexChanged: (index) {
                  FragmentConstant.addSpecialGameSelectIndex(state.videoType, index);
                  dispatch(GameNewNoticeActionCreator.onAction());
                },
                itemBuilder: (BuildContext context, int index) {
                  return _buildItemView(
                      state, dispatch, viewService, state.games[index], index, FragmentConstant.getSpecialGameSelectIndex(state.videoType) == index && isInView);
                },
              ),
            );
          },
        );
      },
    ),
  );
}

Widget _buildItemView(GameNewNoticeState state, Dispatch dispatch,
    ViewService viewService, Game game, int index, bool play) {
  return GestureDetector(
    onTap: () {
      dispatch(GameNewNoticeActionCreator.gotoGameDetail(game.gameId));
    },
    child: Container(
      width: 312,
      height: 242,
      margin: EdgeInsets.only(left: 14, right: 0, top: 0, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1), //阴影xy轴偏移量
            blurRadius: 3.0, //阴影模糊程度
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              game.videoUrl != null && game.videoUrl != ""
                  ? Container(
                      width: double.infinity,
                      height: 175.0,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        child: VideoWidget2(
                          play: play,
                          url: game.videoUrl,
                          videoType: state.videoType + "#${index}",
                          gameId: game.gameId,
                          isShowVolume: VideoUtil.getOpenVolume(),
                        ),
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5)),
                      ),
                    )
                  : Container(
                      height: 175,
                      width: double.maxFinite,
                      child: new AspectRatio(
                        aspectRatio: 66 / 32, //横纵比 长宽比  3:2
                        child: ClipRRect(
                            child: new HuoNetImage(
                              imageUrl: game.appHotImage ?? game.pcHomeImgStyle2 ?? '',
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ),
                    ),
            ],
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.only(left: 10, right: 8),
                  child: ClipRRect(
                    child: new HuoNetImage(
                      imageUrl: game.icon,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          game.gameName,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppTheme.colors.textColor,
                          ),
                        ),
                        Container(
                          height: 6,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: getText(name: 'textDateToStartSoon', args: [AppUtil.formatDate14(game.runTime ?? 0)]),
                            style: TextStyle(
                                color: Color(0xFFFF912B), fontSize: 11),
                          ),
                          TextSpan(
                            text: "  ${game.subscribeCnt ?? 0}${getText(name: 'textHasRoundCnt')}",
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor,
                                fontSize: 11),
                          ),
                        ]))
                      ],
                    ),
                  ),
                ),
                1 == game.isSubscribe
                    ? GestureDetector(
                        onTap: () {
                          dispatch(GameNewNoticeActionCreator.gameSubscribe(
                              game.gameId));
                        },
                        child: Container(
                          width: 55,
                          height: 27,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFF4605A),
                                  Color(0xFFFD9064),
                                ]),
                          ),
                          child: Text(
                            getText(name: 'textOrder'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          dispatch(GameNewNoticeActionCreator.gameSubscribe(
                              game.gameId));
                        },
                        child: Container(
                          width: 60,
                          height: 27,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppTheme.colors.lineColor),
                          child: Text(
                            getText(name: 'textReserved'),
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor2,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
              ],
            ),
          )),
        ],
      ),
    ),
  );
}
