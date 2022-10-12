import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/component.dart'
    as mine_fun_list;
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/component.dart'
    as mine_top_tab;
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
        width: double.infinity,
        height: 221.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppTheme.images.bg_n_bg),
            fit: BoxFit.cover,
          ),
        ),
      ),
//      Image.asset(
//        AppTheme.images.bg_n_bg,
//        height: 221.0,
//      ),
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 34.0, 0.0, 0),
              child: Stack(
                children: <Widget>[
//                  Align(
//                      alignment: Alignment.center,
//                      child: Container(
//                        margin: EdgeInsets.fromLTRB(0, 8.0, 0.0, 0),
//                        child: Text("个人中心",
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 18,
//                            )),
//                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
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
                                  dispatch(
                                      MineFragmentActionCreator.gotoMessage());
                                }),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 12,
                              width: 12,
                              alignment: Alignment.center,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
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
                                  EdgeInsets.only(left: 14, right: 14, top: 30),
                            ),
                            Container(
                                height: 139,
                                margin: EdgeInsets.only(
                                    left: 26.0, right: 26.0, top: 20.0),
//                alignment: FractionalOffset.bottomRight,
                                child: Column(children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        dispatch(MineFragmentActionCreator
                                            .onAction());
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 68,
                                            width: 68,
                                            child: ClipRRect(
                                              child: HuoNetImage(
                                                imageUrl:
                                                    LoginControl.isLogin() &&
                                                            state.userInfo !=
                                                                null &&
                                                            state.userInfo
                                                                    .avatar !=
                                                                null
                                                        ? state.userInfo.avatar
                                                        : "",
                                                height: 66,
                                                width: 66,
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(33)),
                                            ),
                                            decoration: BoxDecoration(
                                              border: new Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(34)),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  LoginControl.isLogin() &&
                                                          state.userInfo !=
                                                              null &&
                                                          state.userInfo
                                                                  .nickname !=
                                                              null
                                                      ? state.userInfo.nickname
                                                      : getText(name: 'textPleaseLogin'),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppTheme
                                                          .colors.textColor),
                                                ),
                                                Text(
                                                    LoginControl.isLogin() &&
                                                            state.userInfo !=
                                                                null &&
                                                            state.userInfo
                                                                    .memId !=
                                                                null
                                                        ? getText(name: 'textUserId', args: [state.userInfo.memId])
                                                        : getText(name: 'textIdAfterLogin'),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppTheme.colors
                                                            .textSubColor)),
                                              ],
                                            ),
                                          )),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: MaterialButton(
                                              height: 33,
                                              minWidth: 66,
                                              onPressed: () {
                                                if (state.userInfo != null &&
                                                    state.userInfo.hasSign !=
                                                        2) {
                                                  dispatch(
                                                      MineFragmentActionCreator
                                                          .showSign());
                                                }
                                              },
                                              child: Text(
                                                state.userInfo != null &&
                                                        state.userInfo
                                                                .hasSign ==
                                                            2
                                                    ? getText(name: 'textHasSign')
                                                    : getText(name: 'textSign'),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              color: state.userInfo != null &&
                                                      state.userInfo.hasSign ==
                                                          2
                                                  ? Color(0xFF999999)
                                                  : Color(0xFFFF6720),
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: AppTheme.colors.lineColor,
                                  ),
                                  Container(
                                    height: 60.0,
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                            "images/icon_n_pingtaibi.png",
                                            height: 23.0,
                                            width: 23.0),
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Text(
                                            "${getText(name: 'textPlatformCurrency')}${getText(name: 'textBalance')}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    AppTheme.colors.textColor),
                                          ),
                                        )),
                                        Text(
                                          LoginControl.isLogin() &&
                                                  state.userInfo != null &&
                                                  state.userInfo.ptbCnt != null
                                              ? state.userInfo.ptbCnt.toString()
                                              : "0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: AppTheme.colors.textColor),
                                        ),
                                      ],
                                    ),
                                  )
                                ])),
                          ],
                        ),
                        height: 170),
                    viewService.buildComponent(
                        mine_top_tab.MineTopTabComponent.componentName),
                    SplitLine(),
                    viewService.buildComponent(
                        mine_fun_list.MineFunListComponent.componentName)
                  ],
                ),
                controller: RefreshHelperController()),
          )
        ],
      ),
    ],
  );
}
