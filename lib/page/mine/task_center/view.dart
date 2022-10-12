import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TaskCenterState state, Dispatch dispatch, ViewService viewService) {
  //vip功能栏
  List<Widget> widgets = List();
  widgets.clear();
  Widget widget = buildWidget(state.tabs, dispatch, viewService, 1);
  widgets.add(widget);

  return Scaffold(
    body: Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: Image.asset(
//              "images/icon_n_toolbar_return_tint.png",
              "images/icon_toolbar_return_icon_dark.png",
              width: 40,
              height: 44,
            ),
            onPressed: () {
              Navigator.pop(viewService.context);
            },
          ),
          title: Text(
            getText(name: 'textTaskCenter'),
            style: TextStyle(
                fontSize: HuoTextSizes.title18,
                color: AppTheme.colors.textColor),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        Container(
          color: Colors.white,
          height: 300,
          child: Stack(
            children: <Widget>[
              Image.asset(
                "images/task_pic_bg.png",
                height: 134,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: <Widget>[
                    Container(
                        height: 152,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                offset: Offset(0, 1),
                                blurRadius: 5,
                              )
                            ]),
                        margin: EdgeInsets.only(left: 14, right: 14, top: 40),
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
//                    dispatch(MineFragmentActionCreator.onAction());
                              },
                              child: Container(
                                height: 60,
                                alignment: Alignment.topCenter,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      width: 60,
                                      child: ClipRRect(
                                        child: HuoNetImage(
                                          imageUrl: LoginControl.isLogin() &&
                                                  LoginControl.getUserInfo() !=
                                                      null &&
                                                  LoginControl.getUserInfo()
                                                          .data
                                                          .avatar !=
                                                      null
                                              ? LoginControl.getUserInfo()
                                                  .data
                                                  .avatar
                                              : "",
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                getText(name: 'textMyIntegral'),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: AppTheme
                                                        .colors.textSubColor),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                state.userInfo != null
                                                    ? state.userInfo.data
                                                        .myIntegral
                                                        .toString()
                                                    : "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme
                                                        .colors.textSubColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        dispatch(TaskCenterActionCreator
                                            .gotoIntegralShop());
                                      },
                                      child: Container(
                                        height: 33,
                                        width: 55,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: new Border.all(
                                                color: Color(0xffF35A58),
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Text(
                                          getText(name: 'textExchange'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xffF35A58)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                "images/ic_shopping.png",
                                                height: 36,
                                                width: 36,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 4, 0, 0),
                                                  child: Text(
                                                    getText(name: 'textShop'),
                                                    style: TextStyle(
                                                      fontSize: HuoTextSizes
                                                          .mine_tab_small,
                                                      color: AppTheme
                                                          .colors.textSubColor,
                                                    ),
                                                  )),
                                            ]),
                                      ),
                                      onTap: () {
                                        dispatch(TaskCenterActionCreator
                                            .gotoIntegralShop());
                                      },
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                "images/icon_invited.png",
                                                height: 36,
                                                width: 36,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 4, 0, 0),
                                                  child: Text(
                                                    getText(name: 'textInviteMoney'),
                                                    style: TextStyle(
                                                      fontSize: HuoTextSizes
                                                          .mine_tab_small,
                                                      color: AppTheme
                                                          .colors.textSubColor,
                                                    ),
                                                  )),
                                            ]),
                                      ),
                                      onTap: () {
                                        dispatch(TaskCenterActionCreator
                                            .gotoInvite());
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: GestureDetector(
                                      child: Visibility(
                                        visible: false,
                                        child: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  "images/ic_luckdraw.png",
                                                  height: 36,
                                                  width: 36,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      getText(name: 'textLottery'),
                                                      style: TextStyle(
                                                        fontSize: HuoTextSizes
                                                            .mine_tab_small,
                                                        color: AppTheme.colors
                                                            .textSubColor,
                                                      ),
                                                    )),
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
                                        dispatch(TaskCenterActionCreator
                                            .gotoLottery());
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
//                            Container(
//                              child: ListView(
//                                shrinkWrap: true,
//                                physics: const NeverScrollableScrollPhysics(),
//                                children: widgets,
//                              ),
//                              alignment: Alignment.topCenter,
//                            )
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        dispatch(TaskCenterActionCreator.gotoInvite());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 5),
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
                    SplitLine(),
                  ],
                ),
              ),
//              GestureDetector(
//                child: Container(
//                  margin: EdgeInsets.only(top: 0),
//                  width: double.maxFinite,
//                  child: Image.asset(
//                    "images/bg_huosdk_picture_renwu_topbg.png",
//                    width: 235,
//                    height: 140,
//                  ),
//                ),
//                onTap: () {
//                  dispatch(TaskCenterActionCreator.showSign());
//                },
//              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
//            color: Color(0xffF8F8F8),
            color: Colors.white,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: viewService.context,
                child: ListView(
                  children: <Widget>[
                    if (state.taskHome != null &&
                        state.taskHome.data.one.list.length > 0)
                      _createItem(
                          getText(name: 'textNewbieTask'), state.taskHome.data.one.list, dispatch, viewService),
                    if (state.taskHome != null &&
                        state.taskHome.data.daily.list.length > 0)
                      _createItem(
                          getText(name: 'textDailyTask'), state.taskHome.data.daily.list, dispatch, viewService),
                  ],
                )),
          ),
        )
      ],
    ),
  );
}

Widget _createItem(
    String taskName, List<TaskBean> taskList, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 10, bottom: 7),
        padding: EdgeInsets.only(
          left: 6,
          right: 6,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 3,
              height: 15,
              color: AppTheme.colors.themeColor,
              margin: EdgeInsets.only(right: 8),
            ),
            Text(
              taskName,
              style: TextStyle(color: AppTheme.colors.textColor, fontSize: 16),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
        padding: EdgeInsets.only(bottom: 6),
        child: ListView.builder(
            itemCount: taskList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              //Widget Function(BuildContext context, int index)
              return GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10, left: 8),
                          height: 52,
                          width: 52,
                          child: ClipRRect(
                            child: new HuoNetImage(
                              imageUrl: taskList[index].icon,
                              fit: BoxFit.cover,
                              height: 52,
                              width: 52,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  taskList[index].iaName,
                                  style: TextStyle(
                                      color: AppTheme.colors.textColor,
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                margin:
                                    EdgeInsets.only(left: 10, right: 3, top: 5),
                              ),
                              Container(
                                child: Text(
                                  taskList[index].iaDesc,
                                  style: TextStyle(
                                      color: AppTheme.colors.textSubColor2,
                                      fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                margin:
                                    EdgeInsets.only(left: 10, right: 3, top: 5),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 62,
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              color: taskList[index].finishFlag == 2
                                  ? Color(0xffDDDDDD)
                                  : AppTheme.colors.themeColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text(
                            taskList[index].finishFlag == 2 ? getText(name: 'textHasCompleted') : getText(name: 'textGotoCompleted'),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                    index != taskList.length - 1
                        ? Container(
                            margin: EdgeInsets.only(top: 6),
                            color: AppTheme.colors.lineColor,
                            height: 1.2,
                          )
                        : Container()
                  ],
                ),
                onTap: () {
                  if (taskList[index].finishFlag == 1)
                    dispatch(TaskCenterActionCreator.gotoFinish(
                        taskList[index].iaId));
                },
              );
            }),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    ],
  );
}

Widget buildWidget(
    List<Item> tabs, Dispatch dispatch, ViewService viewService, int type) {
  return Container(
    alignment: Alignment.topCenter,
    child: Row(
        children: tabs
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 110,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            tabs[index].url,
                            height: 36,
                            width: 36,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Text(
                                tabs[index].name,
                                style: TextStyle(
                                  fontSize: HuoTextSizes.mine_tab_small,
                                  color: AppTheme.colors.textSubColor,
                                ),
                              )),
                        ]),
                  ),
                  onTap: () {
                    switch (tabs[index].id) {
                      case 0:
                        {
                          //积分商城
                          showToast(getText(name: 'textShop'));
                          break;
                        }
                      case 1:
                        {
                          //邀请赚钱
                          showToast(getText(name: 'textInviteMoney'));
                          break;
                        }
                      case 2:
                        {
                          //转盘抽奖
                          showToast(getText(name: 'textLottery'));
                          break;
                        }
                    }
                  },
                ))
            .toList()),
  );
}
