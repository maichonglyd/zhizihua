import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_record.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RebateRecordListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      title: huoTitle(getText(name: 'textApplyHistory')),
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
        children: state.records.map((record) => buildItem(record, viewService)).toList(),
      ),
      controller: state.refreshHelperController,
      onRefresh: () {
        dispatch(RebateRecordListActionCreator.getRecords(1));
      },
      loadMore: (page) {
        dispatch(RebateRecordListActionCreator.getRecords(page));
      },
    ),
  );
}

Widget buildItem(RebateRecord records, ViewService viewService) {
  return Column(
    children: <Widget>[
      SplitLine(),
      Container(
        height: 109,
        width: 360,
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${getText(name: 'textApplyRebateColon')}${records.amount}${getText(name: 'textPriceSymbol')}",
              style:
                  TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
            ),
            Text(
              "${getText(name: 'textRechargeTimeColon')}${AppUtil.formatDate2(records.applyTime)}",
              style:
                  TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
            ),
            Text(
              "${getText(name: 'textGameNameColon')}${records.gameName}",
              style:
                  TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${getText(name: 'textOrderIdColon')}${records.orderId}",
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor2)),
                Text("${getText(name: 'textOrderStateColon')}${records.statusTxt}",
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor2)),
              ],
            )
          ],
        ),
      )
    ],
  );
}
