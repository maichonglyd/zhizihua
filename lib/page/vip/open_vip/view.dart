import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OpenVipState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textOpenVip')),
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
      actions: <Widget>[
        Container(
          child: FlatButton(
            onPressed: () {
              dispatch(OpenVipActionCreator.gotoOpenRecordList());
            },
            child: Text(
              getText(name: 'textOpenHistory'),
              style: TextStyle(fontSize: 14, color: AppTheme.colors.textColor),
            ),
          ),
        )
      ],
    ),
    body: RefreshHelper().getEasyRefresh(
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Text(
                  getText(name: 'textMemberPackage'),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.colors.textColor),
                ),
              ),
            ),
            state.vipMods != null && state.vipMods.length > 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((content, index) {
                      return GestureDetector(
                        onTap: () {
                          dispatch(OpenVipActionCreator.selectVipType(index));
                        },
                        child: Container(
                          height: 80,
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: buildVipType(state.vipMods[index], viewService),
                        ),
                      );
                    }, childCount: state.vipMods.length),
                  )
                : SliverToBoxAdapter(),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      getText(name: 'textSelectPayWay'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colors.textColor,
                          fontSize: 15),
                    ),
                    margin: EdgeInsets.all(14),
                  ),
                ],
              ),
            ),
            state.payWayMods != null && state.payWayMods.length > 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((content, index) {
                      return GestureDetector(
                        onTap: () {
//                          dispatch(OpenVipActionCreator.selectVipType(index));
                        },
                        child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 5),
                            child: buildPayWayView(state, dispatch,
                                state.payWayMods[index], index)),
                      );
                    }, childCount: state.payWayMods.length),
                  )
                : SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      dispatch(OpenVipActionCreator.gotoPay());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 30, bottom: 30),
                      decoration: BoxDecoration(
                          color: AppTheme.colors.themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        getText(name: 'textOpenNow'),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),

//            SliverToBoxAdapter(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    child: Text(
//                      "选择支付方式",
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          color: AppTheme.colors.textColor,
//                          fontSize: 15),
//                    ),
//                    margin: EdgeInsets.all(14),
//                  ),
////                  buildPayWayView(state, dispatch, "支付宝（推荐）",
////                      "images/pic_n_zhifubao.png", 0),
////                  buildPayWayView(
////                      state, dispatch, "微信支付", "images/pic_n_wechat.png", 1),
//                  GestureDetector(
//                    onTap: () {
//                      dispatch(OpenVipActionCreator.gotoPaySuccess());
//                    },
//                    child: Container(
//                      width: double.infinity,
//                      height: 48,
//                      alignment: Alignment.center,
//                      margin: EdgeInsets.only(
//                          left: 15, right: 15, top: 30, bottom: 30),
//                      decoration: BoxDecoration(
//                          color: AppTheme.colors.themeColor,
//                          borderRadius: BorderRadius.all(Radius.circular(5))),
//                      child: Text(
//                        "立即开通",
//                        style: TextStyle(fontSize: 15, color: Colors.white),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            )
          ],
        ),
        controller: RefreshHelperController()),
  );
}

Widget buildPayWayView(
    OpenVipState state, Dispatch dispatch, PayWayMod payWayMod, int index) {
  return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              HuoNetImage(
                imageUrl: payWayMod.icon,
                fit: BoxFit.cover,
                height: 24,
                width: 24,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  payWayMod.name.isNotEmpty ? payWayMod.name : "",
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              )),
              GestureDetector(
                child: Image.asset(
                  payWayMod.isSelected
                      ? "images/circle_ic_selection_bule.png"
                      : "images/circle_ic_normal_stroke.png",
                  height: 22,
                  width: 22,
                ),
                onTap: () {
                  dispatch(OpenVipActionCreator.selectPayType(index));
                },
              )
            ],
          ),
          Divider()
        ],
      ));
}

//Widget buildPayWayView(
//    OpenVipState state, Dispatch dispatch, String title, String image, int i) {
//  return Container(
//    margin: EdgeInsets.only(left: 15, right: 15),
//    child: Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Image.asset(
//          image,
//          height: 24,
//          width: 24,
//        ),
//        Expanded(
//            child: Container(
//          margin: EdgeInsets.only(left: 10),
//          child: Text(
//            title,
//            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
//          ),
//        )),
//        ClipOval(
//          child: Checkbox(
//              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//              activeColor: AppTheme.colors.themeColor,
//              value: i == state.payType,
//              onChanged: (value) {
//                dispatch(OpenVipActionCreator.updatePayType(i));
//              }),
//        )
//      ],
//    ),
//  );
//}

Widget buildVipType(VIPMod vipMod, ViewService viewService) {
  return Container(
//    alignment: Alignment.center,
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  vipMod.name.isNotEmpty ? vipMod.name : "",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.colors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  vipMod.description.isNotEmpty ? vipMod.description : "",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.colors.textSubColor2,
                      fontWeight: FontWeight.w600),
                ),
                alignment: Alignment.centerLeft,
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  "${getText(name: 'textCurrencySymbol')}${vipMod.realAmount}",
                  style: TextStyle(
                      fontSize: 23,
                      color: Color(0xffFF912B),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "${getText(name: 'textCurrencySymbol')}${vipMod.amount}",
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppTheme.colors.textSubColor2,
                      color: AppTheme.colors.textSubColor2,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ))
      ],
    ),
    decoration: BoxDecoration(
        border: Border.all(
            color: vipMod.isSelected ? Color(0xffFF912B) : Color(0xffD9D9D9),
            width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6))),
  );
}
