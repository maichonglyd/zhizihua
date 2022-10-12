import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/vip/vip_privilege/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemberCenterState state, Dispatch dispatch, ViewService viewService) {
  //vip功能栏
  List<Widget> vipWidgets = List();
  vipWidgets.clear();
  Widget widget = buildWidget(state.tabs, dispatch, viewService, 1);
  vipWidgets.add(widget);

  return Scaffold(
      backgroundColor: AppTheme.colors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        title: Text(
          getText(name: 'textNumberCenter'),
          style: TextStyle(fontSize: 18, color: AppTheme.colors.textColor),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 150,
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "images/vip_bg.png",
                      height: 150,
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
//                    dispatch(MineFragmentActionCreator.onAction());
                        },
                        child: Container(
                          height: 53,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 20, left: 15, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 53,
                                width: 53,
                                child: ClipRRect(
                                  child: HuoNetImage(
                                    imageUrl: LoginControl.isLogin() &&
                                            LoginControl.getUserInfo() !=
                                                null &&
                                            LoginControl.getUserInfo()
                                                    .data
                                                    .avatar !=
                                                null
                                        ? LoginControl.getUserInfo().data.avatar
                                        : "",
                                    height: 53,
                                    width: 53,
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                decoration: BoxDecoration(
                                  border: new Border.all(
                                      color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                              Container(
                                height: 53,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        LoginControl.getUserInfo() != null &&
                                                LoginControl.getUserInfo()
                                                        .data
                                                        .nickname !=
                                                    null
                                            ? LoginControl.getUserInfo()
                                                .data
                                                .nickname
                                            : "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppTheme.colors.vipTextColor),
                                      ),
                                    ),
                                    state.memInfoData != null &&
                                            state.memInfoData.vipId > 0
                                        ? Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "${getText(name: 'textDeadlineToColon')} ${AppUtil.formatDate6(state.memInfoData.endTime)}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppTheme
                                                      .colors.vipTextColor),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              getText(name: 'textNotVip'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppTheme
                                                      .colors.vipTextColor),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 134,
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, 1),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: getText(name: 'textVip'),
                              style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.colors.textColor,
                              )),
                          TextSpan(
                              text: getText(name: 'textPrivilege'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              )),
                        ])),
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 0, bottom: 20),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: vipWidgets,
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            top: 17, left: 15, right: 15, bottom: 25),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(getText(name: 'textTask'),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppTheme.colors.textColor,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: getText(name: 'textVipHas'),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  AppTheme.colors.textSubColor,
                                            )),
                                        TextSpan(
                                            text: state.memInfoData != null
                                                ? "${state.memInfoData.maxBonus}%"
                                                : "0%",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.red,
                                            )),
                                        TextSpan(
                                            text: getText(name: 'textMarkUp'),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  AppTheme.colors.textSubColor,
                                            ))
                                      ]),
                                    ),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                dispatch(
                                    MemberCenterActionCreator.gotoTaskCenter());
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Text("${getText(name: 'textTaskHome')} >",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.colors.textColor,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          if (state.taskHome != null &&
                              state.taskHome.data.one != null &&
                              state.taskHome.data.one.list.length > 0)
                            _createItem(
                                getText(name: 'textNewbieTask'), state.taskHome.data.one.list, dispatch, viewService),
                          if (state.taskHome != null &&
                              state.taskHome.data.daily != null &&
                              state.taskHome.data.daily.list.length > 0)
                            _createItem(getText(name: 'textDailyTask'), state.taskHome.data.daily.list,
                                dispatch, viewService),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                height: 64,
                color: Colors.white,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    dispatch(MemberCenterActionCreator.gotoOpenVip());
                  },
                  child: Container(
                    height: 48,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      state.memInfoData != null && state.memInfoData.vipId > 0
                          ? getText(name: 'textRenewNow')
                          : getText(name: 'textOpenNow'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppTheme.colors.vipTextColor),
                    ),
                    decoration: BoxDecoration(
                        color: AppTheme.colors.textColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                )),
          )
        ],
      )));
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
                              Row(
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
                                    margin: EdgeInsets.only(
                                        left: 10, right: 3, top: 5),
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      taskList[index].iaDesc,
                                      style: TextStyle(
                                          color: AppTheme.colors.textSubColor2,
                                          fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 3, top: 5),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      getText(name: 'textVipMarkUp'),
                                      style: TextStyle(
                                          color: AppTheme.colors.textSubColor,
                                          fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 3, top: 5),
                                  ),
                                  Container(
                                    child: Text(
                                      "+${taskList[index].vipBonus}${getText(name: 'textIntegral')}",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 3, top: 5),
                                  ),
                                ],
                              )
//                              Container(
//                                child: Text(
//                                  taskList[index].iaName,
//                                  style: TextStyle(
//                                      color: AppTheme.colors.textColor,
//                                      fontSize: 14),
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                ),
//                                margin:
//                                    EdgeInsets.only(left: 10, right: 3, top: 5),
//                              ),
//                              Container(
//                                child: Text(
//                                  taskList[index].iaDesc,
//                                  style: TextStyle(
//                                      color: AppTheme.colors.textSubColor2,
//                                      fontSize: 12),
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                ),
//                                margin:
//                                    EdgeInsets.only(left: 10, right: 3, top: 5),
//                              )
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
                    dispatch(MemberCenterActionCreator.gotoFinish(
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
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tabs
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 82.5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            tabs[index].url,
                            height: 28,
                            width: 28,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                      case 0: //会员标识
                      case 1: //靓号昵称
                      case 2: // 签到加成
                      case 3: //会员任务
                        dispatch(MemberCenterActionCreator.showAlertDialog(
                            tabs[index].id));
                        break;
                    }
                  },
                ))
            .toList()),
  );
}
