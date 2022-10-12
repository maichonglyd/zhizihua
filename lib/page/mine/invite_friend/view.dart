import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/mine/friends_reward/component.dart';
import 'package:flutter_huoshu_app/component/mine/mine_reward/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    InviteState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: huoTitle(getText(name: 'textInvite')),
        centerTitle: true,
        elevation: 0,
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
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                "images/bg_n_Invitationbg.png",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: 45,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    dispatch(InviteActionCreator.gotoRule());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 6, right: 6, top: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                        color: Color(0x4F000000),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(0),
                                            topRight: Radius.circular(0))),
                                    child: Text(
                                      getText(name: 'textActivityRule'),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.colors.themeColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              dispatch(InviteActionCreator.showShare());
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 15, left: 15, right: 15),
                              child: Image.asset(
                                "images/btn_n_iInvitation.png",
                                height: 42,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 15,
                            ),
                            child: Image.asset(
                              "images/invitation_buzhou.png",
                              height: 55,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 10,
                            color: AppTheme.colors.lineColor,
                          ),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true, //是否固定在顶部
                      delegate: _SliverAppBarDelegate(
                          minHeight: 44, //收起的高度
                          maxHeight: 44, //展开的最大高度
                          child: TabContainer(
                            color: Colors.white,
                            height: 44,
                            child: new TabBar(
                              labelStyle: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                              unselectedLabelStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                              indicator: CommonUnderlineTabIndicator(
                                  insets: EdgeInsets.only(left: 35, right: 35),
                                  borderSide: BorderSide(
                                      width: 4.0,
                                      color: AppTheme.colors.themeColor)),
                              labelPadding: EdgeInsets.all(0),
                              indicatorColor: AppTheme.colors.themeColor,
                              labelColor: AppTheme.colors.textColor,
                              unselectedLabelColor:
                                  AppTheme.colors.textSubColor,
                              tabs: <Widget>[
                                EachTab(
                                  text: getText(name: 'textMyRewards'),
                                ),
                                EachTab(
                                  text: getText(name: 'textFriendRewards'),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(0),
                          )),
                    )
                  ],
              body: Container(
                height: 720,
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: viewService
                          .buildComponent(MineRewardComponent.componentName),
                    ),
                    Container(
                      color: Colors.white,
                      child: viewService
                          .buildComponent(FriendRewardComponent.componentName),
                    ),
                  ],
                ),
              ))));
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
