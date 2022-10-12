import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_record_bean.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/record_list/action.dart';

import 'state.dart';

Widget buildView(
    CurrRecordListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      color: AppTheme.colors.bgColor,
      child: state.refreshHelper.getEasyRefresh(
        state.recordList != null && state.recordList.length > 0
            ? ListView(
                children: state.recordList
                    .asMap()
                    .keys
                    .map((index) => buildCouponItem(dispatch, viewService,
                        index, state.status, state.recordList[index]))
                    .toList(),
              )
            : Container(),
        onRefresh: () {
          dispatch(CouponListActionCreator.getCouponList(1));
        },
        loadMore: (page) {
          dispatch(CouponListActionCreator.getCouponList(page));
        },
        controller: state.refreshHelperController,
      ));
}

Widget buildCouponItem(Dispatch dispatch, ViewService viewService, int index,
    int status, GameRechargeBean bean) {
//  2为成功，1为待支付，3失败
  String rechargeStatus;
  switch (bean.status) {
    case 1:
      rechargeStatus = getText(name: 'textWaitForPay');
      break;
    case 2:
      rechargeStatus = getText(name: 'textRechargeSuccessful');
      break;
    case 3:
      rechargeStatus = getText(name: 'textRechargeFailed');
      break;
  }
  return new Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      padding: EdgeInsets.only(top: 15, bottom: 5),
      height: status == 1 ? 180 : 152,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: <Widget>[
                Text(
                  status == 1
                      ? "+${bean.gmCnt.toString()}"
                      : "-${bean.gmCnt.toString()}",
                  style: TextStyle(fontSize: 20, color: Color(0xffFF3C3C)),
                ),
                Spacer(),
                Text(
                  status == 1 ? "${bean.payWay}" : "${getText(name: 'textOrderPriceColon')} ${bean.orderAmount}",
                  style:
                      TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
          buildTextItemView(dispatch, viewService, getText(name: 'textGameNameColon'), "${bean.gameName}"),
          status == 1
              ? buildTextItemView(
                  dispatch, viewService, getText(name: 'textExactlyPriceColon'), "${bean.realAmount}元")
              : Container(),
          buildTextItemView(dispatch, viewService, getText(name: 'textOrderNumberColon'), "${bean.orderId}"),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
          buildTextItemView(dispatch, viewService,
              "${AppUtil.formatDate9(bean.createTime)}", "$rechargeStatus",
              topMargin: 2),
        ],
      ));
}

//${AppUtil.formatDate9(1546454545)
Widget buildTextItemView(
    dispatch, ViewService viewService, String title, String content,
    {double topMargin = 7}) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: topMargin),
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              content,
              textAlign: TextAlign.end,
              style:
                  TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
            ),
          ),
        )
      ],
    ),
  );
}
