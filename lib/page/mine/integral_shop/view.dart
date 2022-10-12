import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IntegralShopState state, Dispatch dispatch, ViewService viewService) {
  return Stack(
    children: <Widget>[
//      Image.asset("images/bg_huosdk_picture_shangchengbg.png"),
      Image.asset("images/huosdk_picture_shangchengbg.png"),
      Container(
        height: 250,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 25),
        child: Image.asset(
          "images/bg_huosdk_picture_shangchengjifen.png",
          width: 220,
          height: 220,
        ),
      ),
      DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: new IconButton(
              icon: Image.asset(
                "images/icon_n_toolbar_return_tint.png",
                width: 40,
                height: 44,
              ),
              onPressed: () {
                Navigator.pop(viewService.context);
              },
            ),
            centerTitle: true,
            elevation: 0,
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 14),
                  child: Text(
                    getText(name: 'textExchangeHistory'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: HuoTextSizes.second_title),
                  ),
                ),
                onTap: () {
                  dispatch(IntegralShopActionCreator.gotoExchangeRecord());
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            title: Text(
              getText(name: 'textShop'),
              style:
                  TextStyle(fontSize: HuoTextSizes.title, color: Colors.white),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                  height: 180,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    state.integral.toString(),
                                    style: TextStyle(
                                        fontSize: 34, color: Color(0xffFFEE00)),
                                  ),
                                  Text(
                                    getText(name: 'textIntegral'),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 32,
                            width: 130,
                            margin: EdgeInsets.only(bottom: 14),
                            child: MaterialButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                dispatch(
                                    IntegralShopActionCreator.gotoInvite());
                                //   dispatch(IntegralShopItemActionCreator.exchangeGoods());
                              },
                              child: Text(
                                getText(name: 'textInvite'),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                border: Border.all(color: Colors.white)),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        top: 35,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  "images/huosdk_picture_jifen.png"),
                              height: 90,
                              width: 26,
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.only(top: 10, left: 3, right: 8),
                                child: Text(
                                  getText(name: 'textIntegralDetail'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              onTap: () {
                                dispatch(
                                    IntegralShopActionCreator.gotoRecord());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    TabBar(
                      controller: state.controller,
                      labelStyle: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                      indicator: CommonUnderlineTabIndicator(
                          insets: EdgeInsets.only(left: 35, right: 35),
                          borderSide: BorderSide(
                              width: 4.0, color: AppTheme.colors.themeColor)),
                      indicatorColor: AppTheme.colors.themeColor,
                      labelColor: AppTheme.colors.textColor,
                      unselectedLabelColor: AppTheme.colors.textSubColor,
                      tabs: <Widget>[
                        EachTab(
                          text: getText(name: 'textRealGoods'),
                        ),
                        EachTab(
                          text: getText(name: 'textVirtualGoods'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        //设置滑动的效果，这个禁用滑动
                        controller: state.controller,
                        children: <Widget>[
                          Container(
                            child: viewService.buildComponent("real_fragment"),
                          ),
                          Container(
                            child:
                                viewService.buildComponent("virtual_fragment"),
                          ),
//                         viewService.buildComponent("real_fragment"),
//                         viewService.buildComponent("virtual_fragment"),
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
              )),
            ],
          ),
        ),
      )
    ],
  );
}
