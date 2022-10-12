import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

Widget buildView(
    IntegralExpendState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        height: 44,
        color: Color(0xFFFDEEEE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  getText(name: 'textTime'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Center(
                child: Text(
                  getText(name: 'textExchange'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Center(
                child: Text(
                  getText(name: 'textIntegral'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
      Expanded(
          child: state.refreshHelper.getEasyRefresh(
              ListView(
                  children: state.goldRecords
                      .map((goldRecords) => buildItem(goldRecords))
                      .toList()), onRefresh: () {
        dispatch(IntegralExpendActionCreator.getGoldRecord(1));
      }, loadMore: (page) {
        dispatch(IntegralExpendActionCreator.getGoldRecord(page));
      }, controller: state.controller))
    ],
  );
}

Widget buildItem(gold_record.DataList goldRecord) {
  return Column(
    children: <Widget>[
      Container(
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  AppUtil.formatDate1(goldRecord.createTime),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  goldRecord.iaName,
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "${goldRecord.integral}",
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor2),
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
      Container(
        height: 1,
        margin: EdgeInsets.only(left: 14, right: 14),
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}
