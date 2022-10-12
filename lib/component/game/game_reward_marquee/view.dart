import 'package:extended_text/extended_text.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/im/text_span_builder.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRewardMarqueeState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 33,
    margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
    padding: EdgeInsets.only(left: 13, right: 13),
    decoration: BoxDecoration(
      color: AppTheme.colors.bgColor,
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          child: Image.asset(
            "images/icon_laba.png",
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: FlutterMarquee(
              //做成跑马灯的形式
              children: state.list.map((value) {
                String nickname = value.nickname;
                if (value.nickname.isNotEmpty && value.nickname.length > 5) {
                  nickname = '${value.nickname[0]}***${value.nickname[value.nickname.length - 1]}';
                }
                String gameName = value.gameName;
                if (value.gameName.isNotEmpty && value.gameName.length > 7) {
                  gameName = value.gameName.substring(0, 7) + '...';
                }
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 7, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: getText(name: 'textPlayerObtainReward', args: [nickname, gameName]),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 13),
                    ),
                    TextSpan(
                      text: '${value.money}${getText(name: 'textPriceSymbol')}',
                      style: TextStyle(
                          color: AppTheme.colors.themeColor, fontSize: 13),
                    ),
                    TextSpan(
                      text: getText(name: 'textRedPacket'),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 13),
                    ),
                  ])),
                );
              }).toList(),
              onChange: (index) {},
              onRoll: (index) {
              },
              animationDirection: AnimationDirection.t2b,
              duration: 5),
        ),
      ],
    ),
  );
}
