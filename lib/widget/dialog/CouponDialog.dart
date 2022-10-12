import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/protocol_info_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/coupon/reward_bean_list.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/widget/ContainerTabBar.dart';
import 'package:flutter_huoshu_app/widget/stack_head_widget.dart';
import 'package:oktoast/oktoast.dart';

typedef CouponCallback<T> = void Function(T t);

class CouponDialog extends StatefulWidget {

  List<Reward> coupons;
  Function() onClickTake;
  CouponDialog(this.coupons,this.onClickTake,{Key key}):super(key:key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogCouponState(coupons, onClickTake);
  }
}

class DialogCouponState extends State<CouponDialog> {

  List<Reward> coupons;

  Function() onClickTake;

  DialogCouponState(this.coupons, this.onClickTake);

  void setRewardList(List<Reward> coupons) {
    this.coupons = coupons;
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = 0;
    double contentHeight = 0;
    if (coupons.length < 3) {
      totalHeight = 210.0 + (coupons.length * 75);
      contentHeight = 160.0 + (coupons.length * 75);
    } else {
      totalHeight = 425;
      contentHeight = 375;
    }
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
          child: Container(
            width: 317,
            height: totalHeight,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    child: Container(
                        width: 317,
                        height: contentHeight,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 64,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("images/coupon_top.png"),
                                  )),
                              child: Text(
                                getText(name: 'textCoupon'),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        margin: EdgeInsets.only(bottom: 70),
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: coupons
                                              .asMap()
                                              .keys
                                              .map(
                                                  (index) =>
                                                  buildCouponItem(
                                                      coupons[index]))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          width: double.infinity,
                                          height: 65,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    "images/coupon_down.png"),
                                              )),
                                          child: GestureDetector(
                                            onTap: () {
                                              onClickTake();
                                            },
                                            child: Container(
                                              width: 237,
                                              height: 37,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(20))),
                                              child: Text(
                                                getText(name: 'textReceivingNow'),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                    AppTheme.colors.textColor),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/ic_off.png",
                        height: 27,
                        width: 27,
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  Widget buildCouponItem(Reward reward) {
    String url;
    url = "images/tc_djquan_bg_white.png";
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 8),
      height: 75,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(url),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/tc_djquan_bq.png",
            width: 47,
            height: 47,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "¥",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
//                      double.parse(couponMod.money).toStringAsFixed(0) ?? "0",
                              "${reward.money}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${reward.title}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme.colors.textColor),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text(
                                  "${reward.condition}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.colors.textSubColor2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text(
//                    "有效期：${AppUtil.formatDate8(couponMod.endTime)}",
                                  "${reward.content}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.colors.textSubColor2),
                                ),
                              ),
                            ],
                          ),
                        ),
//                        GestureDetector(
//                          onTap: () {
////                            onClickTake();
//                          },
//                          child: Container(
//                              width: 65,
//                              height: 65,
//                              margin: EdgeInsets.only(left: 5, right: 3),
//                              alignment: Alignment.center,
//                              child: Image.asset(
//                                "images/coupon_my_pic_yiguoqi.png",
//                                width: 65,
//                                height: 65,
//                                fit: BoxFit.cover,
//                              )),
//                        )
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
