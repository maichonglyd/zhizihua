import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/activity/activity_details/page.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameFirstNewsState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: 276,
    margin: EdgeInsets.only(left: 15),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemView(state, dispatch, viewService, index);
      },
      itemCount: state.gameSpecial.gameList.length,
    ),
  );
}

Widget _buildItemView(GameFirstNewsState state, Dispatch dispatch,
    ViewService viewService, int index) {
  Game game = state.gameSpecial.gameList[index];
  return GestureDetector(
    onTap: () {
      AppUtil.gotoPageByName(viewService.context, ActivityDetailsPage.pageName,arguments: {"newsId":game.newsId,"type": 3,"gameId": game.gameId});
    },
    child: Container(
      width: 285,
      height: 268,
      margin: EdgeInsets.only(right: 13),
      child: Stack(
        children: [
          Container(
            width: 285,
            height: 268,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 1),
                    blurRadius: 5,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: HuoNetImage(
                          imageUrl: game.newsImage ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.only(top: 100),
                        padding: EdgeInsets.only(left: 10, bottom: 11),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00000000), Color(0xCC000000)],
                          ),
                        ),
                        child: Text(
                          game.gameName ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 108,
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.title ?? '',
                        style: TextStyle(
                            color: AppTheme.colors.textColor, fontSize: 15),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6, bottom: 14),
                        child: Text(
                          game.excerpt ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: getText(name: 'textThisPagePublish'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor2,
                              fontSize: 11),
                        ),
                        TextSpan(
                          text: AppUtil.formatDate13(game.pubTime),
                          style:
                              TextStyle(color: Color(0xFFFF912B), fontSize: 11),
                        ),
                      ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
