import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_game_list.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameDetailCouponState state, Dispatch dispatch, ViewService viewService) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _buildCouponList(dispatch, viewService, state.couponGameList),
      ],
    ),
  );
}

Widget _buildCouponList(Dispatch dispatch, ViewService viewService, CouponGameList couponGameList) {
  return null == couponGameList ||
      null == couponGameList.data ||
      couponGameList.data.list.length == 0
      ? SizedBox()
      : Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.only(left: 14, top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildCouponView(
              dispatch, viewService, couponGameList.data.list[index]);
        },
        itemCount: couponGameList.data.list.length,
      ));
}

Widget _buildCouponView(Dispatch dispatch, ViewService viewService, CvCoupon coupon) {
  int hasGet = 2;
  return Container(
    width: 134,
    height: 62,
    margin: EdgeInsets.only(right: 10),
    child: Row(
      children: [
        Expanded(
          flex: 86,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg_coupon_left.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "¥${coupon.money}",
                  style: TextStyle(
                      color: Color(0xFFFF3E00),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    coupon.conditionDes,
                    style: TextStyle(
                        color: AppTheme.colors.textSubColor2, fontSize: 10),
                  ),
                ),
                _buildProgressView(0.5),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 48,
          child: GestureDetector(
              onTap: () {
                if (!LoginControl.isLogin()) {
                  AppUtil.gotoPageByName(viewService.context, LoginPage.pageName);
                  return;
                }
                if (hasGet != coupon.isGet) {
                  dispatch(GameDetailCouponActionCreator.getCoupon(coupon.id));
                } else {
                  showToast("优惠券已领取");
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(hasGet == coupon.isGet
                        ? "images/bg_coupon_ylq.png"
                        : "images/bg_coupon_wlq.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  hasGet == coupon.isGet ? "已\n领\n取" : "领\n取",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )),
        )
      ],
    ),
  );
}

Widget _buildProgressView(double progress) {
  return Container(
    width: 50,
    height: 2,
    child: Stack(
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          width: 50 * progress,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Color(0xFFFF3E00),
          ),
        ),
      ],
    ),
  );
}

