import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameCoinRechargeRecordState state, Dispatch dispatch,
    ViewService viewService) {
  List<Widget> items = List();
  items.add(buildHead(state, dispatch, viewService));
  state.records.forEach((record) {
    items.add(buildItem(record, dispatch, viewService));
  });

  return Scaffold(
      appBar: AppBar(
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
        title: huoTitle(getText(name: 'textRechargeHistory')),
        centerTitle: true,
        elevation: 0,
      ),
      body: state.refreshHelper.getEasyRefresh(ListView(children: items),
          onRefresh: () {
        dispatch(GameCoinRechargeRecordActionCreator.getRecords(1));
      }, loadMore: (page) {
        dispatch(GameCoinRechargeRecordActionCreator.getRecords(page));
      }, controller: state.refreshHelperController));
}

Widget buildHead(GameCoinRechargeRecordState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        state.isShowHead
            ? Container(
                padding: EdgeInsets.all(15),
                child: Container(
                  child: Text(
                    getText(name: 'textRechargeSuccessTip'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor),
                  ),
                ),
              )
            : Container(),
        GestureDetector(
          onTap: () {
            dispatch(GameCoinRechargeRecordActionCreator.switchHead());
          },
          child: Container(
            height: 35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  state.isShowHead ? getText(name: 'textRetract') : getText(name: 'textSeeGuide'),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor),
                ),
                Image.asset(
                  state.isShowHead
                      ? "images/ng_more_icon_up.png"
                      : "images/uni_ic_more_down_yellow.png",
                  height: 11,
                  width: 11,
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildItem(Record record, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(top: 10, right: 15, left: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 42,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                record.gameName,
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
              ),
              Text(
                "ID：${record.username}",
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
              )
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildTextLine(getText(name: 'textGamePlatformColon'), record.cps_name),
        buildTextLine(getText(name: 'textRechargePriceColon'), "${record.money}${getText(name: 'textPriceSymbol')}"),
        buildTextLine(getText(name: 'textPayWayColon'), record.payway),
        buildTextLine(getText(name: 'textOrderIdColon'), record.orderId),
        Container(
          height: 1,
          margin: EdgeInsets.only(top: 8),
          color: AppTheme.colors.lineColor,
        ),
        Container(
          height: 41.5,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${AppUtil.formatDate2(record.createTime)}",
                style: TextStyle(
                    fontSize: 12, color: AppTheme.colors.textSubColor2),
              ),
              GestureDetector(
                onTap: () {
                  dispatch(GameCoinRechargeRecordActionCreator.rechargeAgain(
                      record));
                },
                child: Container(
                  height: 24,
                  width: 74,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppTheme.colors.themeColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.5))),
                  child: Text(
                    getText(name: 'textRechargeAgain'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textColor),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildTextLine(String title, String content) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
        ),
        Text(
          content,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
        ),
      ],
    ),
  );
}
