import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/classify/component.dart';
import 'package:flutter_huoshu_app/component/classify_fragment/component.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/video_list/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/home_page/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';
import 'package:flutter_huoshu_app/widget/second_back_exit.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  var paddings = MediaQuery.of(viewService.context).padding;
  HuoLog.d("home page current=${state.loadStatus}");
  int showIndexPage = 1;
  if (state.splashTime <= 0 && LoadStatus.success == state.loadStatus) {
    showIndexPage = 0;
  }
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: 2 != state.index ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: Material(
        child: IndexedStack(
          index: showIndexPage,
          children: <Widget>[
            buildLoadingRefreshWidget(state.loadStatus,
                (state, dispatch, viewService) {
              return Scaffold(
                backgroundColor: Colors.white,
                //不随键盘弹出界面往上顶,解决视频界面往上顶的问题
                resizeToAvoidBottomInset: false,
                body: MediaQuery.removeViewPadding(
                    context: viewService.context,
                    removeLeft: true,
                    removeTop: false,
                    removeRight: true,
                    removeBottom: true,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, paddings.bottom),
                        color: state.controller.index == 2
                            ? Colors.black
                            : Colors.white,
                        child: secondBackExitWrapper(
                          viewService.context,
                          Stack(
                            children: <Widget>[
                              Column(children: <Widget>[
                                Expanded(
                                    child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  //设置滑动的效果，这个禁用滑动
                                  controller: state.controller,
                                  children: <Widget>[
                                    viewService.buildComponent("bt_fragment"),
                                    viewService
                                        .buildComponent(ClassifyFragmentComponent.componentName),
                                    viewService.buildComponent(
                                        VideoComponent.componentName),
//                                viewService.buildComponent("chat_fragment"),
                                    viewService.buildComponent("deal_fragment"),
                                    viewService
                                        .buildComponent(MineFragment.pageName),
                                  ],
                                )),
                                Container(
                                  height: 50,
                                ),
                              ]),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: SafeArea(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: state.controller.index == 2
                                          ? Colors.black
                                          : Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: const Color(0xf000000),
                                          blurRadius: 4.0,
                                          spreadRadius: 4.0,
                                          offset: Offset(0, -7.0),
                                        ),
                                      ],
                                    ),
                                    child: new TabBar(
                                      isScrollable: false,
                                      controller: state.controller,
                                      indicatorColor: Colors.transparent,
                                      labelColor: AppTheme.colors.themeColor,
                                      labelPadding: EdgeInsets.all(0),
                                      unselectedLabelColor: Colors.black,
                                      tabs: state.homeTabs
                                          .asMap()
                                          .keys
                                          .map<Widget>((index) => EachTab(
                                                height: 50,
                                                padding: EdgeInsets.all(0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Stack(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Image.asset(
                                                            state.index == index
                                                                ? state
                                                                    .homeTabs[
                                                                        index]
                                                                    .selectedIcon
                                                                : state
                                                                    .homeTabs[
                                                                        index]
                                                                    .unselectedIcon,
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                        ),
//                                                    index == 3 &&
//                                                            state.unReadNum > 0
//                                                        ? Align(
//                                                            alignment: Alignment
//                                                                .topCenter,
//                                                            child: Container(
//                                                              margin: EdgeInsets
//                                                                  .only(
//                                                                      left: 20,
//                                                                      bottom:
//                                                                          5),
//                                                              child: ClipOval(
//                                                                child:
//                                                                    Container(
//                                                                  width: 16,
//                                                                  height: 16,
//                                                                  alignment:
//                                                                      Alignment
//                                                                          .center,
//                                                                  color: Colors
//                                                                      .red,
//                                                                  child: Text(
//                                                                    state.unReadNum >
//                                                                            99
//                                                                        ? "99+"
//                                                                        : "${state.unReadNum}",
//                                                                    textAlign:
//                                                                        TextAlign
//                                                                            .center,
//                                                                    style: TextStyle(
//                                                                        fontSize:
//                                                                            8,
//                                                                        color: Colors
//                                                                            .white),
//                                                                  ),
//                                                                ),
//                                                              ),
//                                                            ))
//                                                        : Container()
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        state.homeTabs[index]
                                                            .title,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: state
                                                                        .index ==
                                                                    index
                                                                ? AppTheme
                                                                    .colors
                                                                    .themeColor
                                                                : AppTheme
                                                                    .colors
                                                                    .textSubColor),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              state.showTab
                                  ? Container(
//                        color: Colors.white,
                                      width: double.maxFinite,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
//                              flex: 13,
                                            child: GestureDetector(
                                              onTap: () {
                                                dispatch(HomeActionCreator
                                                    .showTab());
                                              },
                                              child: Container(
                                                color: Color(0x72000000),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Color(0x72000000),
                                            height: 20,
                                            child: Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                            ),
                                          ),
                                          Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  left: 0, top: 30),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: _createItem(
                                                        dispatch,
                                                        "images/ic_hs_ks_money.png",
                                                        getText(name: 'textInviteMoney'),
                                                        0),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: _createItem(
                                                        dispatch,
                                                        "images/ic_hs_ks_renwu.png",
                                                        getText(name: 'textTaskCenter'),
                                                        1),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: _createItem(
                                                        dispatch,
                                                        "images/ic_hs_ks_renwu.png",
                                                        getText(name: 'textAllGame'),
                                                        6),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: _createItem(
                                                        dispatch,
                                                        "images/ic_hs_ks_recycling.png",
                                                        getText(name: 'textRecycle'),
                                                        2),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            color: Colors.white,
                                            height: 30,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.only(
                                                left: 25, right: 25),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: _createItem(
                                                      dispatch,
                                                      "images/ic_hs_ks_kaifu.png",
                                                      getText(name: 'textService'),
                                                      3),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: _createItem(
                                                      dispatch,
                                                      "images/ic_hs_ks_market.png",
                                                      getText(name: 'textShop'),
                                                      5),
                                                ),
                                                AppConfig.hasTurntable
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: _createItem(
                                                            dispatch,
                                                            "images/ic_hs_ks_choujiang.png",
                                                            getText(name: 'textLottery'),
                                                            4),
                                                      )
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Container(),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.maxFinite,
                                            color: Colors.white,
                                            height: 30,
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              width: double.maxFinite,
                                              color: Colors.white,
                                              height: 30,
                                              margin: EdgeInsets.only(
                                                  bottom: 45, top: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ))),
              );
            }, state, dispatch, viewService, HomeActionCreator.onInitCheck()),
            GestureDetector(
              child: Container(
                  child: Stack(
                children: <Widget>[
                  Container(
                      child: state.splash != null
                          ? GestureDetector(
                              child: HuoNetImage(
                                imageUrl: state.splash.img,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Image.asset(
                                  "images/sp.png",
                                  fit: BoxFit.fill,
                                ),
                                errorWidget: (context, url, error) =>
                                    ConstrainedBox(
                                  child: Image.asset(
                                    "images/sp.png",
                                    fit: BoxFit.fill,
                                  ),
                                  constraints: new BoxConstraints.expand(),
                                ),
                              ),
                              onTap: () {
                                if (null != state.splash.gameId && 0 != state.splash.gameId) {
                                  dispatch(HomeActionCreator.updateDownCount(
                                      HomePage.splash_goto_game_detail));
                                  AppUtil.gotoPageByName(
                                      viewService.context, GameDetailsPage.pageName,
                                      arguments: {"gameId":state.splash.gameId});
                                } else {
                                  HuoLog.e("闪屏页的游戏id不正确");
                                  dispatch(HomeActionCreator.updateDownCount(0));
                                }
                              },
                            )
                          : Image.asset(
                              "images/sp.png",
                              fit: BoxFit.fill,
                            ),
                      width: double.infinity,
                      height: double.infinity
//                    height: 720,
                      ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        dispatch(HomeActionCreator.updateDownCount(0));
                      },
                      child: Container(
                        height: 24,
                        width: 72,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 32, right: 32),
                        child: Text(
                          null != state.splashTime
                              ? getText(name: 'textJumpAfterSecond', args: [state.splashTime])
                              : getText(name: 'textJump'),
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0x88000000),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ],
              )),
              onTap: () {
                dispatch(HomeActionCreator.updateDownCount(0));
              },
            )
          ],
        ),
      ));
}

Widget _createItem(Dispatch dispatch, String icon, String title, int id) {
  return GestureDetector(
    child: Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            icon,
            width: 47,
            height: 47,
          ),
          Container(
            child: Text(
              title,
              style:
                  TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor),
            ),
            margin: EdgeInsets.only(top: 3, bottom: 3),
          )
        ],
      ),
    ),
    onTap: () {
      switch (id) {
        case 0:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoInvite());
          break;
        case 1:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoTaskCenter());
          break;
        case 2:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoRecycle());
          break;
        case 3:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoKaifu());
          break;
        case 4:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoLottery());
          break;
        case 5:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoShop());
          break;
        case 6:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoGameClass());
          break;
        default:
          break;
      }
    },
  );
}
