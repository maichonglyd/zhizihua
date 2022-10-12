import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/action.dart';

import 'state.dart';

Widget buildView(
    CouponListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      child: state.refreshHelper.getEasyRefresh(
    state.coupons != null && state.coupons.length > 0
        ? ListView(
            children: state.coupons
                .asMap()
                .keys
                .map((index) => buildCouponItem(dispatch, viewService, index,
                    state.status, state.coupons[index]))
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

Widget buildCouponItem(dispatch, ViewService viewService, int index, int status,
    CouponMod couponMod) {
  String url;
  switch (status) {
    case 1: //待使用
    case 2: //已使用
      if (couponMod.appId == 0) {
        //使用于所有游戏
        url = "images/pic_Voucherbg2.png";
      } else {
        url = "images/pic_Voucherbg1.png";
      }
      break;
    case 3: //已过期
      url = "images/pic_Voucherbg3.png";
      break;
  }
  return new Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
    height: 80,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(url),
        fit: BoxFit.fill,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 90,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                child: Row(
                  children: <Widget>[
                    Text(
                      double.parse(couponMod.money).toStringAsFixed(0) ?? "",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      getText(name: 'textPriceSymbol'),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    getText(name: 'textCoupon'),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    couponMod.title ?? "",
                    style: TextStyle(
                        fontSize: 15, color: AppTheme.colors.textColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "${couponMod.content}",
                    style: TextStyle(
                        fontSize: 11, color: AppTheme.colors.textSubColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "${getText(name: 'textDeadlineColon')}${AppUtil.formatDate8(couponMod.endTime)}",
                    style: TextStyle(
                        fontSize: 11, color: AppTheme.colors.textSubColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        status == 2
            ? Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Image.asset(
                  "images/my_pic_yishiyong.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              )
            : Container()
      ],
    ),
  );
}
