import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JPGameItemState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 250,
              width: double.maxFinite,
              child: HuoNetImage(
                imageUrl: state.game.appHotImage,
                fit: BoxFit.fill,
              ),
//              child: new AspectRatio(
//                aspectRatio: 72 / 50, //横纵比 长宽比  3:2
//                child: HuoNetImage(
//                  imageUrl: state.game.appHotImage,
//                  fit: BoxFit.fill,
//                ),
//              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00000000),
                      Color(0x80000000),
                    ]),
              ),
              height: 250,
            )
          ],
        ),
        Align(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(state.game.gameName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                margin: EdgeInsets.only(top: 6, bottom: 8, left: 15, right: 15),
                child: Text(state.game.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Color(0xE6ffffff), fontSize: 13)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: DownView(game: state.game, type: TYPE_GAME_ITEM),
              ),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
              )
            ],
          ),
        )
      ],
    ),
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, state.game);
    },
  );
}
