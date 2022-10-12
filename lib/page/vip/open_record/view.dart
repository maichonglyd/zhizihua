import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OpenRecordState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: huoTitle(getText(name: 'textOpenHistory')),
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
        elevation: 0,
      ),
      body: state.recordList != null && state.recordList.length > 0
          ? state.refreshHelper.getEasyRefresh(
              ListView(
                children: state.recordList
                    .map((record) => buildItem(record, dispatch, viewService))
                    .toList(),
              ),
              onRefresh: () {
                dispatch(OpenRecordActionCreator.getRecordList(1));
              },
              loadMore: (page) {
                dispatch(OpenRecordActionCreator.getRecordList(page));
              },
              controller: state.refreshHelperController,
            )
          : Container());
}

Widget buildItem(
    RecordMod recordMod, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 135,
    margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            getText(name: 'textOrderInfo'),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.colors.textColor),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            child: Row(
              children: <Widget>[
                Text(
                  "${getText(name: 'textGoodsNameColon')}${recordMod.vipName}",
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                ),
                Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      "${getText(name: 'textPayWayColon')}${recordMod.paywayName}",
                      style: TextStyle(
                          fontSize: 14, color: AppTheme.colors.textSubColor),
                    ))
              ],
            )),
        Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            child: Row(
              children: <Widget>[
                Text(
                  getText(name: 'textBuyTimeColon'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "${AppUtil.formatDate1(recordMod.payTime)}",
                      style: TextStyle(
                          fontSize: 14, color: AppTheme.colors.textSubColor),
                    ))
              ],
            )),
        Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            child: Row(
              children: <Widget>[
                Text(
                  getText(name: 'textDeadlineToColon'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "${AppUtil.formatDate1(recordMod.endTime)}",
                      style: TextStyle(
                          fontSize: 14, color: AppTheme.colors.textSubColor),
                    ))
              ],
            )),
      ],
    ),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD9D9D9), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6))),
  );
}
