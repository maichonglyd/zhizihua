import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/view.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import '../../../model/game/game_bean.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCardState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  for (int i = 0; i< state.gameSpecial.gameList.length; i++) {
    if (i < 8) {
      widgetList.add(_buildItemView(state, dispatch, viewService, state.gameSpecial.gameList[i]));
    }
  }

  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    child: Column(
      children: [
        Wrap(
          spacing: 29,
          runSpacing: 20,
          children: widgetList,
        ),
        GestureDetector(
          onTap: () {
            dispatch(GameCardActionCreator.getCardGameList());
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: 5),
                  child: Image.asset("images/icon_change.png", fit: BoxFit.fill,),
                ),
                Text(
                  getText(name: 'textChangeNew'),
                  style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 13, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildItemView(
    GameCardState state, Dispatch dispatch, ViewService viewService, Game game) {
  String singleTag = (game.singleTag != null && game.singleTag.length > 0)
      ? game.singleTag[0]
      : "";
  List<String> singleTagList = List();
  if (singleTag.isEmpty) {
  } else {
    List<String> singleTagData = singleTag.split("|");
    singleTagList = singleTagData;
  }

  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailById(viewService.context, game.gameId);
    },
    child: Container(
      width: 60,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 60,
                child: ClipRRect(
                  child: HuoNetImage(
                    imageUrl: game.icon ?? '',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
              ),
              singleTagList.length > 0
                  ? ClipPath(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 5),
                  height: 19,
                  width: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffFF5E46),
                        Color(0xffFF5E46),
                      ]),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10))),
                  child: Text(
                    singleTagList.length > 0
                        ? singleTagList[0]
                        : singleTag,
                    style: TextStyle(
                      fontSize: HuoTextSizes.game_tag_sub,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.start,
                  ),
                ),
                clipper: MyClipper(),
              )
                  : Container(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              game.gameName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
            ),
          )
        ],
      ),
    ),
  );
}
