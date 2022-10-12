import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_game_detail/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_gift/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TurnGameState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  widgetList.add(_buildHeaderView(state, dispatch, viewService));
  widgetList.add(_buildTitleView());
  widgetList.addAll(state.list.map((value) => _buildItemView(state, dispatch, viewService, value)).toList());
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textTurnGameCenter')),
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
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.colors.bgColor,
      child: state.refreshHelper.getEasyRefresh(
        ListView(
          children: widgetList,
        ),
        controller: state.refreshHelperController,
        onRefresh: () {
          dispatch(TurnGameActionCreator.getData(1));
        },
        loadMore: (page) {
          dispatch(TurnGameActionCreator.getData(page));
        },
      ),
    ),
  );
}

Widget _buildHeaderView(
    TurnGameState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    height: 130,
    alignment: Alignment.topRight,
    padding: EdgeInsets.only(right: 15, top: 15),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          'images/pic_turn_game_header_bg.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            AppUtil.gotoH5Web(viewService.context, AppConfig.baseUrl + 'switchgame/rich_text/rule', title: getText(name: 'textTurnGameRules'));
          },
          child: Container(
            width: 60,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Text(
              getText(name: 'textRuleDes'),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            AppUtil.gotoPageByName(viewService.context, TurnGiftPage.pageName);
          },
          child: Container(
            width: 60,
            height: 22,
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Text(
              getText(name: 'textMyGift'),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTitleView() {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
    child: Text(
      getText(name: 'textTransferToGameRecommendedByPlatform'),
      style: TextStyle(
          color: AppTheme.colors.textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildItemView(TurnGameState state, Dispatch dispatch,
    ViewService viewService, TurnGameBean bean) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoPageByName(viewService.context, TurnGameDetailPage.pageName,
          arguments: {'activityId': bean.activityId});
    },
    child: Container(
      height: 105,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.only(right: 10, top: 12, bottom: 12),
                  child: ClipRRect(
                    child: HuoNetImage(
                      imageUrl: bean.game.icon ?? '',
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          bean.game.name ?? '',
                          style: TextStyle(
                              color: AppTheme.colors.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '${bean.game.starCnt}${getText(name: 'textGrade')}',
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 11),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              AppUtil.gameTypeTransport(bean.game.type, '·', 2),
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 11),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '${bean.game.userCnt}${getText(name: 'textPlayCnt')}',
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getText(name: 'textTravelRights'),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 11),
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.colors.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'images/icon_coupon_gold.png',
                      width: 15,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(left: 7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.colors.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'images/icon_gift_gold.png',
                      width: 15,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${getText(name: 'textHighest')}${getText(name: 'textCurrencySymbol')} ',
                        style: TextStyle(
                            color: AppTheme.colors.themeColor, fontSize: 11),
                      ),
                      TextSpan(
                        text: bean.highestReward.toString(),
                        style: TextStyle(
                            color: AppTheme.colors.themeColor, fontSize: 20),
                      ),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
