import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GmFragmentState state, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
    length: 2,
    child: NestedScrollView(
        headerSliverBuilder: (context, innerScrolled) => <Widget>[
              SliverToBoxAdapter(
                  child: Container(
                child: viewService
                    .buildComponent(IndexBannerComponent.componentName),
              )),
              SliverPersistentHeader(
                  pinned: true, //是否固定在顶部
                  delegate: _SliverAppBarDelegate(
                    minHeight: 44, //收起的高度
                    maxHeight: 44, //展开的最大高度
                    child: Container(
                      height: 45,
                      color: Colors.white,
                      child: new TabBar(
                        controller: state.tabController,
                        isScrollable: true,
                        labelStyle: TextStyle(
                            fontSize: HuoTextSizes.title,
                            fontWeight: FontWeight.w600),
                        unselectedLabelStyle: TextStyle(
                          fontSize: HuoTextSizes.second_title,
                        ),
                        indicator: CommonUnderlineTabIndicator(
                            height: 0,
                            insets: EdgeInsets.only(left: 40, right: 40),
                            borderSide: BorderSide(
                                width: 4.0, color: AppTheme.colors.themeColor)),
                        labelPadding: EdgeInsets.all(0),
                        indicatorColor: AppTheme.colors.themeColor,
                        labelColor: AppTheme.colors.textColor,
                        unselectedLabelColor: AppTheme.colors.textSubColor,
                        tabs: <Widget>[
                          EachTab(
                            text: getText(name: 'textGmGame'),
                          ),
                          EachTab(
                            text: getText(name: 'textGmAssistant'),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
        body: Container(
          height: 720,
          child: contentView(state, dispatch, viewService),
        )),
  );
}

Widget contentView(
    GmFragmentState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: TabBarView(
          controller: state.tabController,
          children: <Widget>[
            viewService.buildComponent("gmgame_fragment"),
            viewService.buildComponent("gmhelp_fragment"),
          ],
        ),
      )
    ],
  );
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
