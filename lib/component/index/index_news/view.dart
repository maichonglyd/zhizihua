import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexNewsState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(bottom: 8, top: 8),
    child: Row(
      children: <Widget>[
        Container(
          child: Image.asset(
            "images/ic_laba.png",
            width: 15,
            height: 11,
          ),
          margin: EdgeInsets.only(left: 14, right: 5),
        ),
        FlutterMarquee(
            children: state.news
                .map((n) => Text(
                      n.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor2, fontSize: 14),
                    ))
                .toList(),
            onChange: (index) {
//          dispatch(IndexNewsActionCreator.gotoWeb(
//              state.news[index].name,state.news[index].url));
              if (state.news[index] != null) {
                String url = state.news[index].url;
                if (url != null && url.isNotEmpty) {
                  AppUtil.gotoH5Web(viewService.context, url, title: getText(name: 'textAdDetail'));
                  return;
                }
                if (state.news[index].game != null) {
                  AppUtil.gotoGameDetailOrH5Game(
                      viewService.context, state.news[index].game);
                }
              }
              //   showToast(state.news[index]);
            },
            onRoll: (index) {
              // state.activityIndex = index;
            },
            animationDirection: AnimationDirection.t2b,
            duration: 5)
      ],
    ),
  );
}
