import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';
import 'package:flutter_huoshu_app/page/activity/activity_details/page.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameRebateState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  widgetList.add(_buildFirstItemView(state, dispatch, viewService));
  widgetList.addAll(state.rebateGames
      .map((value) => _buildItemView(state, dispatch, viewService, value))
      .toList());
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      title: huoTitle(getText(name: 'textRechargeRebate')),
      centerTitle: true,
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
    ),
    body: state.refreshHelper.getEasyRefresh(
      ListView(
        children: widgetList,
      ),
      controller: state.refreshHelperController,
      emptyWidget: _buildFirstItemView(state, dispatch, viewService),
      onRefresh: () {
        dispatch(GameRebateActionCreator.getData(1));
      },
      loadMore: (page) {
        dispatch(GameRebateActionCreator.getData(page));
      },
    ),
  );
}

Widget _buildFirstItemView(
    GameRebateState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15),
    child: Column(
      children: [
        Container(
          height: 69,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getText(name: 'textRechargeActivityEveryDay'),
                          style: TextStyle(
                              color: AppTheme.colors.textColor, fontSize: 15),
                        ),
                        Container(
                          width: 45,
                          height: 15,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: LinearGradient(colors: [
                              Color(0xfff35a58),
                              Color(0xffff9666),
                            ]),
                          ),
                          child: Text(
                            getText(name: 'textAutoWelfare'),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        getText(name: 'textRechargeMaxWelfare'),
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor2, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 30,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  getText(name: 'textNoApplication'),
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor2, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
      ],
    ),
  );
}

Widget _buildItemView(GameRebateState state, Dispatch dispatch,
    ViewService viewService, New news) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      if (news.url != null && news.url.isNotEmpty) {
        AppUtil.gotoH5Web(viewService.context, news.url, title: getText(name: 'textInformationDetails'));
        return;
      }
      AppUtil.gotoPageByName(viewService.context, ActivityDetailsPage.pageName,
          arguments: {
            "newsId": news.newsId,
            "type": 2,
            "gameId": news.gameId
          });
    },
    child: Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Container(
            height: 69,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            news.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          news.postTitle ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor2,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.themeColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    getText(name: 'textApply'),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
        ],
      ),
    ),
  );
}
