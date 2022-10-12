import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameHotThisWeekendState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoPageByName(viewService.context, GameSpecialPagePage.pageName,
          arguments: {
            "title": state.gameSpecial.topicName,
            "specialId": state.gameSpecial.topicId
          });
    },
    child: Container(
      width: 330,
      height: 160,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          ClipRRect(
            child: HuoNetImage(
              imageUrl: state.gameSpecial.image ?? '',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.only(left: 10, bottom: 13),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0xCC000000)],
              ),
            ),
            child: Text(
              state.gameSpecial.desc,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    ),
  );
}
