import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

import 'action.dart';
import 'state.dart';

Widget buildView(
    IntegralIncomeState state, Dispatch dispatch, ViewService viewService) {
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
                  getText(name: 'textComeForm'),
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
          children: state.goldRecords.map((goldRecord) {
            return buildItem(goldRecord);
          }).toList(),
        ),
        onRefresh: () {
          //刷新数据
          dispatch(IntegralIncomeActionCreator.getGoldRecord(1));
        },
        loadMore: (page) {
          //加载数据
          dispatch(IntegralIncomeActionCreator.getGoldRecord(page));
        },
        controller: state.controller,
      )),
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
                  AppUtil.formatDate2(goldRecord.createTime),
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
                  "+${goldRecord.integral}",
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
