import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/inviewnotifier/video_widget_up.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSpecialHeadState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.only(left: 14, right: 14, top: 12),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(GameSpecialHeadActionCreator.gotoGameDetails(
                int.parse(state.gameSpecial.gameId)));
          },
          child: state.gameSpecial.videoUrl != null &&
                  state.gameSpecial.videoUrl != ""
              ? Container(
                  width: double.infinity,
                  height: 151.0,
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      String videoId = state.videoType + "#0";
                      return InViewNotifierWidget(
                        id: videoId,
                        builder: (BuildContext context, bool isInView,
                            Widget child) {
                          return ClipRRect(
                            child: VideoWidget2(
                              play: isInView,
                              url: state.gameSpecial.videoUrl,
                              videoType: videoId,
                              gameId:
                                  AppUtil.stringToNum(state.gameSpecial.gameId),
                              isShowVolume: VideoUtil.getOpenVolume(),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          );
                        },
                      );
                    },
                  ),
                )
              : state.gameSpecial.image.isNotEmpty
                  ? Container(
                      height: 151,
                      width: 360,
                      child: ClipRRect(
                        child: new HuoNetImage(
                          imageUrl: state.gameSpecial.image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    )
                  : Container(),
        ),
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}
