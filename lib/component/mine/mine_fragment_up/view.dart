import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/rendering.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/mine/mine_common_func/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/component.dart'
    as mine_fun_list;
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/component.dart'
    as mine_top_tab;
import 'package:flutter_huoshu_app/component/mine/mine_common_func/component.dart'
    as mine_common_func;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineFragmentState state, Dispatch dispatch, ViewService viewService) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        height: 250.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppTheme.images.bg_n_bg),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 34.0, 0.0, 0),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 44,
                            height: 40,
                            margin: EdgeInsets.only(right: 0),
                            child: IconButton(
                                icon: new ImageIcon(
                                  AssetImage("images/mine_icon_n_set.png"),
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {
                                  dispatch(MineCommonFuncActionCreator
                                      .gotoSetting());
                                }),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            //消息
                            width: 44,
                            height: 40,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                      icon: new ImageIcon(
                                        AssetImage("images/icon_n_new.png"),
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        dispatch(MineFragmentActionCreator
                                            .gotoMessage());
                                      }),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 12,
                                    width: 12,
                                    margin: EdgeInsets.only(top: 8, right: 8),
                                    child: Text(
                                      state.msgCount.toString(),
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: state.msgCount > 0
                                              ? Colors.red
                                              : Colors.transparent),
                                    ),
                                    decoration: BoxDecoration(
                                        color: state.msgCount > 0
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              )),
          GestureDetector(
            onTap: () {
              dispatch(MineFragmentActionCreator.onAction());
            },
            child: Container(
              height: 75,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 0, left: 15, right: 0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,
                    child: ClipRRect(
                      child: LoginControl.isLogin() &&
                              state.userInfo != null &&
                              state.userInfo.avatar != null
                          ? HuoNetImage(
                              imageUrl: state.userInfo.avatar,
                              height: 75,
                              width: 75,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "images/huo_app_default.png",
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                    ),
                    decoration: BoxDecoration(
                      border: new Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(43)),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          LoginControl.isLogin() &&
                                  state.userInfo != null &&
                                  state.userInfo.nickname != null
                              ? state.userInfo.nickname
                              : getText(name: 'textPleaseLogin'),
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                            LoginControl.isLogin() &&
                                    state.userInfo != null &&
                                    state.userInfo.memId != null
                                ? getText(name: 'textUserId', args: [state.userInfo.memId])
                                : getText(name: 'textIdAfterLogin'),
                            style: TextStyle(
                                fontSize: 14, color: Color(0xffFFF5F0))),
                        state.memInfoData != null && state.memInfoData.vipId > 0
                            ? Container(
                                width: 54,
                                height: 17,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                    color: AppTheme.colors.textColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9))),
                                child: Text(
                                  getText(name: 'textVipNumber'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xffFEDA9B)),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )),
                  GestureDetector(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            state.userInfo != null &&
                                    state.userInfo.hasSign == 2
                                ? getText(name: 'textHasSign')
                                : getText(name: 'textEveryToday'),
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                      width: 85,
                      height: 31,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(0)),
                          color: Color(0xffAFE1FF)),
                    ),
                    onTap: () {
                      if (state.userInfo != null &&
                          state.userInfo.hasSign != 2) {
                        dispatch(MineFragmentActionCreator.showSign());
                      }
                    },
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
          Expanded(
            child: RefreshHelper().getEasyRefresh(
                ListView(
                  children: <Widget>[
                    Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              height: 129,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x1A000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 5,
                                    )
                                  ]),
                              margin:
                                  EdgeInsets.only(left: 14, right: 14, top: 20),
                            ),
                            Container(
                              height: 139,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  left: 26.0, right: 26.0, top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            getText(name: 'textMyVip'),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .colors.textSubColor),
                                          ),
                                          margin: EdgeInsets.only(top: 30),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            getText(name: 'textVipNumber'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            dispatch(MineFragmentActionCreator
                                                .gotoMemberCenter());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              getText(name: 'textVipCenter'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffECCB83)),
                                            ),
                                            width: 70,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: AppTheme
                                                    .colors.textSubColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "${AppConfig.ptzName}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .colors.textSubColor),
                                          ),
                                          margin: EdgeInsets.only(top: 30),
                                        ),
                                        Container(
                                          child: Text(
                                            LoginControl.isLogin() &&
                                                    state.userInfo != null &&
                                                    state.userInfo.ptbCnt !=
                                                        null
                                                ? state.userInfo.ptbCnt
                                                    .toString()
                                                : "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red),
                                          ),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            dispatch(MineCommonFuncActionCreator
                                                .gotoRecharge());
                                          },
                                          child: Container(
                                            child: Text(
                                              getText(name: 'textRecharge'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                            alignment: Alignment.center,
                                            width: 70,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color:
                                                    AppTheme.colors.themeColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            getText(name: 'textCoupon'),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .colors.textSubColor),
                                          ),
                                          margin: EdgeInsets.only(top: 30),
                                        ),
                                        Container(
                                          child: Text(
                                            LoginControl.isLogin() &&
                                                    state.userInfo != null &&
                                                    state.userInfo.coupon_cnt !=
                                                        null
                                                ? state.userInfo.coupon_cnt
                                                    .toString()
                                                : "0",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red),
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            dispatch(MineCommonFuncActionCreator
                                                .gotoCoupon());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              getText(name: 'textDetail'),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme
                                                      .colors.themeColor),
                                            ),
                                            width: 70,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppTheme
                                                        .colors.themeColor,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
//                                  Expanded(
//                                    flex: 1,
//                                    child: Column(
//                                      children: <Widget>[
//                                        Container(
//                                          child: Text(
//                                            "我的积分",
//                                            style: TextStyle(
//                                                fontSize: 14,
//                                                color: AppTheme
//                                                    .colors.textSubColor),
//                                          ),
//                                          margin: EdgeInsets.only(top: 30),
//                                        ),
//                                        Container(
//                                          child: Text(
//                                            state.userInfo != null
//                                                ? state.userInfo.myIntegral.toString()
//                                                : "0",
//                                            style: TextStyle(
//                                                fontSize: 18,
//                                                color: Colors.red),
//                                          ),
//                                          margin: EdgeInsets.only(top: 10),
//                                        ),
//                                        GestureDetector(
//                                          onTap: () {
//                                            dispatch(MineCommonFuncActionCreator
//                                                .gotoIntegralShop());
//                                          },
//                                          child: Container(
//                                            alignment: Alignment.center,
//                                            child: Text(
//                                              "积分商城",
//                                              style: TextStyle(
//                                                  fontSize: 12,
//                                                  color: AppTheme
//                                                      .colors.themeColor),
//                                            ),
//                                            width: 70,
//                                            height: 27,
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    color: AppTheme
//                                                        .colors.themeColor,
//                                                    width: 1),
//                                                borderRadius: BorderRadius.all(
//                                                    Radius.circular(5))),
//                                            margin: EdgeInsets.only(top: 10),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        height: 170),
                    GestureDetector(
                      onTap: () {
                        dispatch(MineCommonFuncActionCreator.gotoInvite());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                        height: 80.0,
                        width: 330,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/pic_invited.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    viewService.buildComponent(
                        mine_common_func.MineCommonFuncComponent.componentName),
//                    SplitLine(),
//                    viewService.buildComponent(
//                        mine_fun_list.MineFunListComponent.componentName)
                  ],
                ),
                controller: RefreshHelperController()),
          )
        ],
      ),
    ],
  );
}
