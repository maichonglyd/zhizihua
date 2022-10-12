import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';

Widget playTogetherView(BuildContext context, Game game, {Function click}) {
  if (null == game) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        HuoLog.e("点击的游戏为空，无法进入群聊");
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          getText(name: 'textPlayTogether'),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  } else {
    // return DownView(
    //     game: game,
    //     type: TYPE_GAME_JOIN_GROUP,
    //     ok: () {
    //       joinGroupChat(context, game);
    //       if (null != click) {
    //         click();
    //       }
    //     });
    return Container();
  }
}

const int gameNewTourListTypeWeekend = 1;
const int gameNewTourListTypeComment = 2;
const int gameNewTourListTypeOrder = 3;
