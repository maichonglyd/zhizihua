import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCouponState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      title: huoTitle(getText(name: 'textCoupon')),
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
    body: Container(
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
          dispatch(GameCouponActionCreator.getData(1));
        },
        loadMore: (page) {
          dispatch(GameCouponActionCreator.getData(page));
        },
      ),
    ),
  );
}

Widget _buildItemView(GameCouponState state, Dispatch dispatch,
    ViewService viewService, CvCouponBean coupon) {
  return Container(
    height: 90,
    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage("images/pic_game_coupon_bg_white.png"),
      fit: BoxFit.fill,
    )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 91,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/pic_game_coupon_bg_red.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '¥',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  TextSpan(
                    text: coupon.money.toString() ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ])),
                Text(
                  coupon.conditionDes ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '${coupon.money}${getText(name: 'textPriceSymbol')}${getText(name: 'textCoupon')}',
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                child: Text(
                  '${getText(name: 'textActivityDeadlineColon')}${AppUtil.formatDate8(coupon.endTime)}',
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor2, fontSize: 10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '${getText(name: 'textApplyTo')}${state.gameName}',
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor2, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 70,
            child:
            1 == coupon.isGet
                ? Container(
              width: 60,
              height: 30,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppTheme.colors.themeColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child:  InkWell(
                  child: Text(
                          getText(name: 'textReceive'),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                  onTap: () {
                    if (!LoginControl.isLogin()) {
                      AppUtil.gotoPageByName(
                          viewService.context, LoginPage.pageName);
                      return;
                    }
                      dispatch(GameCouponActionCreator.getCoupon(
                          coupon.id));
                    }
                  )
              )
                : Container(
              width: 60,
              height: 30,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child:InkWell(
                child:  Text(
                getText(name: 'textWaitUse'),
                style: TextStyle(
                    color: AppTheme.colors.themeColor, fontSize: 14),
              ),
                  onTap: () {
                    if (!LoginControl.isLogin()) {
                      AppUtil.gotoPageByName(
                          viewService.context, LoginPage.pageName);
                      return;
                    }
                      showToast(getText(name: 'textHasGotCoupon'));
                  }
            ),
          ),
        ),
      ],
    ),
  );
}
