import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/page.dart';
import 'package:flutter_huoshu_app/widget/tab/self_define_tab.dart';
import 'package:flutter_huoshu_app/widget/top_search_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';

import '../../../common/util/login_util.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexBtFragmentState state, Dispatch dispatch, ViewService viewService) {
  var listAdapter = viewService.buildAdapter();
  return Stack(
    children: <Widget>[
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(96),
            child: SafeArea(
                child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 0, right: 0),
                    child: TabContainer(
                      child: ZTabBar(
                        labelStyle: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        indicator: CommonUnderlineTabIndicator(
                            height: 4,
                            width: 30,
                            topPadding: 0,
                            borderSide: BorderSide(
                                width: 4.0, color: AppTheme.colors.themeColor)),
//                    labelPadding: EdgeInsets.only(left: 0,right: 15),
                        labelPadding: state.tabs.length >= 5
                            ? EdgeInsets.only(left: 10, right: 10)
                            : EdgeInsets.all(0),
                        controller: state.tabController,
                        isAdjustWeight: false,
                        isScrollable: state.tabs.length >= 5 ? true : false,
//                    isScrollable:false,
                        indicatorColor: Colors.transparent,
                        labelColor: AppTheme.colors.textColor,
                        unselectedLabelColor: AppTheme.colors.textColor,
                        tabs: state.tabs
                            .asMap()
                            .keys
                            .map((index) => EachTab(
                                  padding: EdgeInsets.all(0),
                                  text: state.tabs[index].name,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: topSearchView(viewService.context,
                        typeList: NewGameFragmentComponent.typeName ==
                                LoginControl.getTabType()
                            ? [TOP_SEARCH_TYPE_NOTICE]
                            : [
                                TOP_SEARCH_TYPE_DOWNLOAD,
                                TOP_SEARCH_TYPE_MESSAGE,
                              ]),
                  )
                ],
              ),
            )),
          ),
          body: TabBarView(
            controller: state.tabController,
            children: state.tabs
                .asMap()
                .keys
                .map((index) =>
                    listAdapter.itemBuilder(viewService.context, index))
                .toList(),
          )),
      Positioned(
        left: state.offset.dx,
        top: state.offset.dy,
        child: GestureDetector(
          onTap: () {
            AppUtil.gotoPageByName(
                viewService.context, CouponCenterPage.pageName);
          },
          //更新child的位置
          onPanUpdate: (details) {
            Size size = MediaQuery.of(viewService.context).size;
            dispatch(IndexBtFragmentActionCreator.upDateOffset(
                size, details.globalPosition));
          },
          child: Image.asset(
            "images/vip_fudian.gif",
            width: ScreenService.floatPointWidth,
            height: ScreenService.floatPointHeight,
          ),
        ),
      )
    ],
  );
}
