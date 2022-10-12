import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StopGameState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textStopServingGame')),
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
          children: state.list
              .map((value) =>
                  _buildItemView(state, dispatch, viewService, value))
              .toList(),
        ),
        controller: state.refreshHelperController,
        onRefresh: () {
          dispatch(StopGameActionCreator.getData(1));
        },
        loadMore: (page) {
          dispatch(StopGameActionCreator.getData(page));
        },
      ),
    ),
  );
}

Widget _buildItemView(StopGameState state, Dispatch dispatch,
    ViewService viewService, TurnGameStopBean bean) {
  return Container(
    height: 74,
    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 8),
          child: ClipRRect(
            child: HuoNetImage(
              imageUrl: bean.icon ?? '',
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
                child: Text(
                  bean.name ?? '',
                  style: TextStyle(
                      color: AppTheme.colors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  getText(name: 'textCumulativeRecharge', args: [bean.cumulativeRecharge]),
                  style: TextStyle(
                    color: AppTheme.colors.textSubColor2,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (TurnGameStopStatus.never == bean.intoStatus) {
              dispatch(StopGameActionCreator.showApplyDialog(bean));
            }
          },
          child: Container(
            width: 60,
            height: 30,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: TurnGameStopStatus.never == bean.intoStatus
                  ? AppTheme.colors.themeColor
                  : AppTheme.colors.textSubColor3,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              getTurnGameStopStatusText(bean.intoStatus),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    ),
  );
}
