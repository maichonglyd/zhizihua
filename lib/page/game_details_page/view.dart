import 'dart:io';
import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/game_details_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/game/game_community/component.dart';
import 'package:flutter_huoshu_app/component/game/game_detail_coupon/component.dart';
import 'package:flutter_huoshu_app/component/game/game_details_fragment/component.dart';
import 'package:flutter_huoshu_app/component/game/game_details_rebate/component.dart';
import 'package:flutter_huoshu_app/component/gift/game_details_gift/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/action.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart' hide Image;
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/game/game_coupon/page.dart';
import 'package:flutter_huoshu_app/page/game/game_rebate/page.dart';
import 'package:flutter_huoshu_app/page/gift/game_gift/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/Star_widget.dart';
import 'package:flutter_huoshu_app/widget/bt_tag_view.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';
import 'package:flutter_huoshu_app/widget/split_line2.dart';
import 'package:flutter_huoshu_app/widget/stack_head_widget.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';
import 'package:video_player/video_player.dart';

import '../../component/game/game_reserve/page.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    GameDetailsState state, Dispatch dispatch, ViewService viewService) {
  bool showCoupon = null != state.gameDetailCouponState.couponGameList &&
      null != state.gameDetailCouponState.couponGameList.data &&
      state.gameDetailCouponState.couponGameList.data.list.length > 0;
  return state.gameDetail != null
      ? Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 60),
                child: DefaultTabController(
                    length: state.gameDetail.isBt == 2 || showCoupon ? 4 : 3,
                    child: NestedScrollView(
                        controller: state.scrollController,
                        headerSliverBuilder: (context, innerScrolled) =>
                            <Widget>[
                              SliverAppBar(
                                pinned: true,
                                title: Text(state.gameDetail.gameName),
                                centerTitle: true,
                                floating: true,
                                leading: new IconButton(
                                  icon: Image.asset(
                                    "images/icon_toolbar_return_icon_dark.png",
                                    width: 40,
                                    height: 44,
                                  ),
                                  onPressed: () {
                                    dispatch(GameDetailsActionCreator.onBack());
                                  },
                                ),
                                actions: <Widget>[
                                  if (Platform.isAndroid)
                                    Container(
                                      //下载
                                      height: 44,
                                      width: 44,
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.all(0),
                                      child: IconButton(
                                          icon: new ImageIcon(
                                            AssetImage(
                                                "images/icon_n_download.png"),
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            dispatch(GameDetailsActionCreator
                                                .gotoDownload());
                                          }),
                                    ),
                                  Container(
                                      //分享
                                      width: 44,
                                      height: 44,
                                      child: IconButton(
                                          icon: new ImageIcon(
                                            AssetImage("images/icon_n_share.png"),
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            if (!LoginControl.isLogin()) {
                                              //跳转登录
                                              AppUtil.gotoPageByName(
                                                  viewService.context,
                                                  LoginPage.pageName);
                                            } else {
                                              dispatch(GameDetailsActionCreator
                                                  .showShare());
                                            }
                                          })),
                                ],
                                forceElevated: false,
                              ),
                              _buildBanner(state, viewService, dispatch),
                              _buildStickyBar(state, viewService, showCoupon),
                            ],
                        body: Container(
                          height: 720,
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: viewService.buildComponent(
                                    GameDetailsComponent.componentName),
                              ),
                              Container(
                                color: Colors.white,
                                child: viewService.buildComponent(
                                    GameCommunityComponent.componentName),
                              ),
                              if (state.gameDetail.isBt == 2)
                                Container(
                                  color: Colors.white,
                                  child: viewService.buildComponent(
                                      GameDetailsRebateComponent.componentName),
                                ),
                              if (state.gameDetail.isBt != 2 && showCoupon)
                                Container(
                                  color: Colors.white,
                                  child: viewService.buildComponent(
                                      GameDetailCouponComponent.componentName),
                                ),
                              Container(
                                color: Colors.white,
                                child: viewService.buildComponent(
                                    GameDetailsDealFragment.componentName),
                              ),
                            ],
                          ),
                        ))),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: state.gameDetail != null && state.gameDetail.status != 2
                    ? Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, right: 20, left: 20),
                        color: Colors.white,
                        height: 60,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            if (LoginControl.isLogin()) {
                              dispatch(GameDetailsActionCreator.subscribe());
                            } else {
                              AppUtil.gotoPageByName(
                                  viewService.context, LoginPage.pageName);
                            }
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: state.channelGames[0].isSubscribe == 1
                                    ? AppTheme.colors.themeColor
                                    : AppTheme.colors.lineColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  state.channelGames[0].isSubscribe == 1 ? getText(name: 'textOrder') : getText(name: 'textCancelReminder'),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          state.channelGames[0].isSubscribe == 1
                                              ? Colors.white
                                              : AppTheme.colors.textSubColor2),
                                ),
                                Text(
                                  "(${AppUtil.formatDate14(state.channelGames[0].runTime)} ${getText(name: 'textService')})",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          state.channelGames[0].isSubscribe == 1
                                              ? Colors.white
                                              : AppTheme.colors.textSubColor2),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x2A000000),
                              offset: Offset(0, 1), //阴影xy轴偏移量
                              blurRadius: 3.0, //阴影模糊程度
                            )
                          ],
                        ),
                        child: _ChinnelDownload(state, dispatch, viewService),
                      ),
              )
            ],
          ),
        )
      : Container();
}

Widget _buildStickyBar(GameDetailsState state, ViewService viewService, bool showCoupon) {
  return SliverPersistentHeader(
    pinned: true, //是否固定在顶部
//    floating: true,
    delegate: _SliverAppBarDelegate(
        minHeight: 44, //收起的高度
        maxHeight: 44, //展开的最大高度
        child: TabContainer(
          color: Colors.white,
          height: 44,
          child: new TabBar(
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 16.0,
            ),
            indicator: CommonUnderlineTabIndicator(
                insets: EdgeInsets.only(left: 35, right: 35),
                borderSide:
                    BorderSide(width: 4.0, color: AppTheme.colors.themeColor)),
            labelPadding: EdgeInsets.all(0),
            indicatorColor: AppTheme.colors.themeColor,
            labelColor: AppTheme.colors.textColor,
            unselectedLabelColor: AppTheme.colors.textSubColor,
            tabs: <Widget>[
              EachTab(
                text: getText(name: 'textDetail'),
              ),
              EachTab(
                text: getText(name: 'textCommunity'),
              ),
              if (state.gameDetail.isBt == 2)
                EachTab(
                  text: getText(name: 'textRebateBenefits'),
                ),
              if (state.gameDetail.isBt != 2 && showCoupon)
                EachTab(
                  text: getText(name: 'textRebateBenefits'),
                ),
              EachTab(
                text: getText(name: 'textDeal'),
              ),
            ],
          ),
          margin: EdgeInsets.all(0),
        )),
  );
}

Widget _buildBanner(
    GameDetailsState state, ViewService viewService, Dispatch dispatch) {
  var colors = [
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
    Color(0xffF35A58),
    Color(0xffF35A58),
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
  ];
  var bgcolors = [
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
    Color(0xffFFF5F5),
    Color(0xffFFF5F5),
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
  ];
  return SliverToBoxAdapter(
      child: Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 14, right: 14, left: 14),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 70,
                width: 70,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: state.gameDetail.icon,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        state.gameDetail.gameName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: HuoTextSizes.title,
                            color: AppTheme.colors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          "0 B" == state.gameDetail.size ? "${state.gameDetail.downCnt}人在玩" : "${state.gameDetail.size}  ${state.gameDetail.downCnt}人在玩",
              //            "${state.gameDetail.size}  ${state.gameDetail.downCnt}人在玩",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: HuoTextSizes.game_title_sub,
                            color: AppTheme.colors.textSubColor,
                          ),
                        ),
                      ),
                      Wrap(
                          spacing: 4,
                          children: state.gameDetail.type
                              .sublist(
                                  0,
                                  state.gameDetail.type.length < 3
                                      ? state.gameDetail.type.length
                                      : 3)
                              .map((type) => Container(
                                    margin: EdgeInsets.only(top: 4),
                                    padding: EdgeInsets.only(
                                        left: 9, top: 2, right: 9, bottom: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(0xFF979797),
                                            width: 1)),
                                    child: Text(
                                      type.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: HuoTextSizes.game_title_sub,
                                        color: AppTheme.colors.textSubColor2,
                                      ),
                                    ),
                                  ))
                              .toList()),
                    ],
                  ),
                ),
              ),
              Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x1A003D6E),
                          offset: Offset(0, 0),
                          blurRadius: 4.0 /*,spreadRadius:2.0*/)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.gameDetail.commentStar.starCnt.toString(),
                        style: TextStyle(
                            fontSize: 23,
                            color: AppTheme.colors.textColor,
                            fontWeight: FontWeight.bold)),
                    //自定义一个星星
                    StarWidget(
                        (state.gameDetail.commentStar.starCnt / 2).round())
                  ],
                ),
              )
            ],
          ),
        ),
        if (shouldShowBtTag(state.gameDetail.btTags, state.gameDetail.isBt))
          Container(
            padding: EdgeInsets.only(top: 13, left: 14),
            margin: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Text(
                  getText(name: 'textGameWelfareColon'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 12),
                ),
                buildBtTagView(state.gameDetail.btTags),
              ],
            ),
          ),
        state.gameDetail.qqGroup != null && state.gameDetail.qqGroup.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                padding: EdgeInsets.only(left: 9, right: 14),
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x0F000000),
                        offset: Offset(0, 5),
                        blurRadius: 10)
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    StackHeadWidget(state.gameDetail.player),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 18,
                      width: 1,
                      color: AppTheme.colors.lineColor,
                    ),
                    Expanded(
                        child: Text(
                      getText(name: 'textWelcomeJoinGroup'),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: HuoTextSizes.index_tab,
                          color: AppTheme.colors.textSubColor),
                    )),
                    MaterialButton(
                      height: 26,
                      minWidth: 52,
                      onPressed: () {
                        dispatch(GameDetailsActionCreator.gotoAddQQGroup());
                      },
                      child: Text(
                        getText(name: 'textJoinGroup'),
                        style: TextStyle(fontSize: 12),
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      color: Color(0xFF008FFF),
                    )
                  ],
                ),
              )
            : Container(),
        // 开服信息
        _buildNewServerView(state, dispatch, viewService),
        if (state.gameDetail != null && 2 == state.gameDetail.isBt)
          _buildRechargeRebate(state, dispatch, viewService),
        _buildWelfareView(state, dispatch, viewService),
        SplitLine(
          height: 10.0,
        ),
      ],
    ),
  ));
}

Widget buildActivityItem(
    String title, List<News> news, GameDetailsState state, Dispatch dispatch) {
  return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        dispatch(GameDetailsActionCreator.gotoWeb(
            news[state.activityIndex].title,
            news[state.activityIndex].viewUrl));
      },
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: 52,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Text(
                title,
                style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FlutterMarquee(
                  children: news
                      .map((n) => Text(
                            n.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor,
                                fontSize: 14),
                          ))
                      .toList(),
                  onChange: (index) {
                    dispatch(GameDetailsActionCreator.gotoWeb(
                        news[index].title, news[index].viewUrl));
                  },
                  onRoll: (index) {
                    state.activityIndex = index;
                  },
                  animationDirection: AnimationDirection.t2b,
                  duration: 5),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ],
        ),
      ));
}

Widget buildVipItem(String title, String subTitle) {
  return Container(
    padding: EdgeInsets.only(left: 14, right: 14),
    height: 52,
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 16),
          child: Text(
            title,
            style: TextStyle(
                color: AppTheme.colors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
        ),
      ],
    ),
  );
}

Widget buildNextTitleItem(String title, ViewService viewService, {callback}) {
  return Container(
    height: 45,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Row(
      children: <Widget>[
        Container(
          height: 15,
          width: 5,
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: HuoTextSizes.second_title,
                  fontWeight: FontWeight.w600)),
        ),
        GestureDetector(
          child: Text(getText(name: 'textMore'),
              style: commonTextStyle(
                  AppTheme.colors.textSubColor, HuoTextSizes.game_title_sub)),
          onTap: () {
            if (callback != null) callback();
          },
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
        )
      ],
    ),
  );
}

Widget buildServiceList(GameDetailsState state) {
  int length = state.gameDetail.serlist.list.length;
  return Container(
    height: 84,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 2,
          color: AppTheme.colors.lineColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: state.gameDetail.serlist.list
              .sublist(0, length < 3 ? length : 3)
              .map((ser) => buildServiceItem(ser))
              .toList(),
        ),
      ],
    ),
  );
}

Widget buildServiceItem(Ser ser) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        AppUtil.formatDate1(ser.startTime),
        style: TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor),
      ),
      Container(
        margin: EdgeInsets.only(top: 8, bottom: 6),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: AppTheme.colors.themeColor,
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFFFBCFCE), width: 2),
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          ser.serverName,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: AppTheme.colors.themeColor),
        ),
      ),
    ],
  );
}

Widget _ChinnelDownload(
    GameDetailsState state, Dispatch dispatch, ViewService viewService) {
  if (state.gameDetail != null && state.gameDetail.classify == 5) {
    //h5游戏
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              dispatch(GameDetailsActionCreator.gotoPlay());
            },
            child: Container(
              height: 39,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFFF842F),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                getText(name: 'textStartToPlay'),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  if (state.gameDetail.hasCpsGame != 2) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 15, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              dispatch(GameDetailsActionCreator.gotoGameComment());
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/icon_game_comment.png",
                    width: 22,
                    height: 22,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    getText(name: 'textEvaluate'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 284,
            decoration: BoxDecoration(
                color: AppTheme.colors.themeColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: DownView(game: state.gameDetail, type: TYPE_GAME_DETAILS),
          ),
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              dispatch(GameDetailsActionCreator.showDownDialog());
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppTheme.colors.themeColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                "下载(${state.gameDetail.size})",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              dispatch(GameDetailsActionCreator.showRechargeDialog());
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFFF842F),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                getText(name: 'textRechargeNow'),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size) {
  return TextStyle(color: color, fontSize: size);
}

Widget _buildNewServerView(
    GameDetailsState state, Dispatch dispatch, ViewService viewService) {
  return state.gameDetail != null &&
          state.gameDetail.serlist != null &&
          state.gameDetail.serlist.list != null &&
          state.gameDetail.serlist.list.length > 0
      ? Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(
            children: [
              Image.asset(
                "images/icon_horn_gold.png",
                width: 14,
                height: 14,
                fit: BoxFit.fill,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  getText(name: 'textServiceOpeningTime'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                      '${state.gameDetail.serlist.list[0].serverName} ${AppUtil.formatDate17(state.gameDetail.serlist.list[0].startTime)}',
                      style: TextStyle(color: Color(0xFFCD8812), fontSize: 14)),
                ),
              ),
              // Image.asset(
              //   "images/icon_turn.png",
              //   width: 12,
              //   height: 12,
              //   fit: BoxFit.fill,
              // ),
            ],
          ),
        )
      : SizedBox();
}

Widget _buildRechargeRebate(
    GameDetailsState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoPageByName(viewService.context, GameRebatePage.pageName, arguments: {'gameId': state.gameId});
    },
    child: Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "images/pic_game_detail_recharge_rebate.png",
            width: 89,
            height: 40,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 7, right: 8),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFF66A58),
                      Color(0xFFFF9566),
                    ]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      getText(name: 'textRechargeMaxWelfare'),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Container(
                    width: 46,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      "${getText(name: 'textMore')}>",
                      style: TextStyle(color: Color(0xFFF35A58), fontSize: 11),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildWelfareView(
    GameDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildWelfareItemView(state, dispatch, viewService, 0,
            "images/icon_coupon_gold.png", getText(name: 'textCoupon'), getText(name: 'textWelfareWasWaitForYou'), 0),
        _buildWelfareItemView(state, dispatch, viewService, 1,
            "images/icon_gift_gold.png", getText(name: 'textGift'), getText(name: 'textGiftWasWaitForYou'), 0),
      ],
    ),
  );
}

Widget _buildWelfareItemView(
  GameDetailsState state,
  Dispatch dispatch,
  ViewService viewService,
  int type,
  String iconUrl,
  String title,
  String content,
  int num,
) {
  return GestureDetector(
    onTap: () {
      switch (type) {
        case 0:
          AppUtil.gotoPageByName(viewService.context, GameCouponPage.pageName,
              arguments: {'gameName': state.gameDetail.gameName});
          break;
        case 1:
          AppUtil.gotoPageByName(viewService.context, GameGiftPage.pageName,
              arguments: {
                'gameId': state.gameDetail.gameId,
                'gameName': state.gameDetail.gameName,
              });
          break;
      }
    },
    child: Container(
      width: 160,
      height: 57,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      iconUrl,
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: AppTheme.colors.textColor, fontSize: 16),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Text(
                    content,
                    style: TextStyle(
                        color: AppTheme.colors.textSubColor2, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          if (0 < num)
            Positioned(
              top: 4,
              right: 6,
              child: Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppTheme.colors.themeColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  '$num',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    ),
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
