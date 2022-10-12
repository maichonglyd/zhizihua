import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/game/game_new_tour_list/page.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameHotListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: 176,
    margin: EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            AppUtil.gotoPageByName(
                viewService.context, GameNewTourListPage.pageName,
                arguments: {
                  "tabIndex": 0,
                });
          },
          child: Container(
            width: 160,
            height: 176,
            padding: EdgeInsets.only(top: 20, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("images/pic_weekend_top.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildTextView(getText(name: 'textGameWeekTop'), getText(name: 'textRefreshGameList'), 18),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  AppUtil.gotoPageByName(
                      viewService.context, GameNewTourListPage.pageName,
                      arguments: {
                        "tabIndex": 1,
                      });
                },
                child: Container(
                  width: 160,
                  height: 83,
                  padding: EdgeInsets.only(top: 14, left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/pic_comment_list.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildTextView(getText(name: 'textNewGameCommentList'), getText(name: 'textLookPeopleLike'), 15),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppUtil.gotoPageByName(
                      viewService.context, GameNewTourListPage.pageName,
                      arguments: {
                        "tabIndex": 2,
                      });
                },
                child: Container(
                  width: 160,
                  height: 83,
                  padding: EdgeInsets.only(top: 14, left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/pic_new_game_list.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildTextView(getText(name: 'textNewGameRoundList'), getText(name: 'textFunNotLost'), 15),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildTextView(String title, String content, double fontSize) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
      Text(
        content,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ],
  );
}
