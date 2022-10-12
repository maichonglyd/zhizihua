import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HtFragmentState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();

  return state.refreshHelper.getEasyRefresh(
    ListView.builder(
        controller: state.scrollController,
        scrollDirection: Axis.vertical,
        itemCount: listAdapter.itemCount,
        itemBuilder: listAdapter.itemBuilder),
    onRefresh: () {
      dispatch(HtFragmentActionCreator.getHomeData());
    },
    controller: state.refreshHelperController,
  );
}

Widget _buildBanner(ViewService viewService) {
  return SliverToBoxAdapter(
      child: Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 12, bottom: 12),
        child: Swiper(
            itemCount: 3,
            pagination: new SwiperPagination(
                builder: LongDotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: AppTheme.colors.themeColor,
                    size: 6,
                    activeWidthSize: 13,
                    activeSize: 6)),
            controller: SwiperController(),
            viewportFraction: 0.9,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 159,
                margin: EdgeInsets.only(left: 4, right: 4),
                child: ClipRRect(
                    child: new HuoNetImage(
                      imageUrl:
                          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4115938130,1681348589&fm=26&gp=0.jpg",
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      height: 159,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              );
            }),
        height: 159,
      ),
      viewService.buildComponent("index_top_tab"),
      viewService.buildComponent("index_row_game"),
    ],
  ));
}

Widget _buildStickyBar(HtFragmentState state, ViewService viewService) {
  return SliverPersistentHeader(
    pinned: true, //是否固定在顶部
    floating: true,
    delegate: _SliverAppBarDelegate(
        minHeight: 44, //收起的高度
        maxHeight: 44, //展开的最大高度
        child: TabContainer(
          color: Colors.white,
          height: 44,
          child: new TabBar(
            controller: state.tabController,
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.0,
            ),
            indicator: CommonUnderlineTabIndicator(
                height: 3,
                insets: EdgeInsets.only(left: 40, right: 40),
                borderSide:
                    BorderSide(width: 4.0, color: AppTheme.colors.themeColor)),
            labelPadding: EdgeInsets.all(0),
            indicatorColor: AppTheme.colors.themeColor,
            labelColor: AppTheme.colors.textColor,
            unselectedLabelColor: AppTheme.colors.textSubColor,
            tabs: <Widget>[
              EachTab(
                text: getText(name: 'textNewGameList'),
              ),
              EachTab(
                text: getText(name: 'textRecommendList'),
              ),
              EachTab(
                text: getText(name: 'textTopVList'),
              ),
            ],
          ),
          margin: EdgeInsets.all(0),
        )),
  );
}

Widget _buildList(HtFragmentState state, ViewService viewService) {
  return SliverToBoxAdapter(
      child: Container(
    height: 500,
    child: Column(
      children: <Widget>[
        Expanded(
            child: TabBarView(
          controller: state.tabController,
          children: <Widget>[
            ListView.builder(
                padding: new EdgeInsets.all(5.0),
                itemExtent: 50.0,
                itemBuilder: (BuildContext context, int index) {
                  return new Text("text $index");
                }),
            NestedScrollView(headerSliverBuilder: null, body: null),
            Text(getText(name: 'textBought')),
            Text(getText(name: 'textH5')),
          ],
        ))
      ],
    ),
  ));
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

Widget _buildNestedScrollDemoPage(
    ViewService viewService, HtFragmentState state) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: DefaultTabController(
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => <Widget>[
                _buildBanner(viewService),
                _buildStickyBar(state, viewService),
              ],
          body: TabBarView(
            controller: state.tabController,
            children: <Widget>[
              Container(
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listAdapter.itemCount,
                      itemBuilder: listAdapter.itemBuilder)),
              Container(
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listAdapter.itemCount,
                      itemBuilder: listAdapter.itemBuilder)),
              Container(
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listAdapter.itemCount,
                      itemBuilder: listAdapter.itemBuilder)),
            ],
          )),
//      child:SmartRefresher(
//        enablePullDown: true,
//        enablePullUp: true,
//        onLoading: (){
//          _onLoading(state);
//        },
//        onRefresh: (){
//          _onRefresh(state);
//        },
//        controller: state.refreshController,
//        header: WaterDropHeader(),
//        footer: CustomFooter(
//          builder: (BuildContext context,LoadStatus mode){
//            Widget body ;
//            if(mode==LoadStatus.idle){
//              body =  Text("pull up load");
//            }
//            else if(mode==LoadStatus.loading){
//              body =  CupertinoActivityIndicator();
//            }
//            else if(mode == LoadStatus.failed){
//              body = Text("Load Failed!Click retry!");
//            }
//            else{
//              body = Text("No more Data");
//            }
//            return Container(
//              height: 100.0,
//              child: Center(child:body),
//            );
//          },
//        ),
//        child:Container(
//          height: 670,
//          child: ,
//        ),
//      ),
    ),
  );
}
