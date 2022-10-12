import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: GestureDetector(
        onTap: () {
          dispatch(SettingActionCreator.changeUrl());
        },
        child: huoTitle(getText(name: 'textSetting')),
      ),
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
    body: RefreshHelper().getEasyRefresh(
        ListView(
          children: <Widget>[
            if (Platform.isAndroid)
              buildItem(0, dispatch, viewService,
                  getText(name: 'textDeletePackage'),
                  isSwitch: true, switchValue: state.isDeleteApk),
            if (Platform.isAndroid)
              buildItem(1, dispatch, viewService,
                  getText(name: 'textWifiDownload'),
                  isSwitch: true, switchValue: state.is4gDown),
//            buildItem(2, dispatch, viewService,
//                S.of(viewService.context).textAcceptPush,
//                isSwitch: true, switchValue: state.accpetPush),
            buildItem(6, dispatch, viewService,
                getText(name: 'textVideoVolumeSetting'),
                isSwitch: true, switchValue: state.videoVolumeOpen),
            buildItem(3, dispatch, viewService,
                getText(name: 'textClearCache'),
                hasRText: true, rightString: state.cacheSize),
            buildItem(4, dispatch, viewService,
                getText(name: 'textAccountManager'),
                isNext: true),
            buildItem(5, dispatch, viewService,
                getText(name: 'textFeedbackAdvise'),
                isNext: true),
//        buildItem(dispatch,"检查更新",hasRText: true,rightString: "v1.2.3"),

            Container(
              height: 40,
              margin: EdgeInsets.only(top: 30, right: 30, left: 30),
              decoration: BoxDecoration(
                  color: AppTheme.colors.themeColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: MaterialButton(
                onPressed: () {
                  dispatch(SettingActionCreator.logout());
                },
                child: Text(
                  getText(name: 'textBack'),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        controller: RefreshHelperController()),
  );
}

Widget buildItem(
  int index,
  Dispatch dispatch,
  ViewService viewService,
  String leftString, {
  bool hasHead: false, //头像
  bool hasRText: false, //is右文字
  bool isReal: false, //实名
  String rightString: "", //右文字
  bool isNext: false, //右箭头
  bool isSwitch: false, //开关
  bool switchValue: false, //开关值
}) {
  Widget rightView = Container();
  if (hasHead)
    rightView = ClipOval(
      child: HuoNetImage(
        imageUrl:
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
        height: 38,
        width: 38,
        fit: BoxFit.cover,
      ),
    );
  if (hasRText)
    rightView = Text(rightString,
        style: TextStyle(fontSize: 15, color: AppTheme.colors.textSubColor2));
  if (isReal)
    rightView = Text(getText(name: 'textGotoAuth'),
        style: TextStyle(fontSize: 15, color: AppTheme.colors.themeColor));

  if (isNext)
    rightView = Icon(
      Icons.arrow_forward_ios,
      size: 12,
    );

  if (isSwitch)
    rightView = Container(
      child: Switch(
        value: switchValue,
        activeColor: AppTheme.colors.themeColor,
        onChanged: (value) {
          switch (index) {
            case 0:
              {
                dispatch(SettingActionCreator.switchDeleteApk());
                break;
              }
            case 1:
              {
                dispatch(SettingActionCreator.switchWifi());
                break;
              }
            case 2:
              {
                dispatch(SettingActionCreator.switchPushMsg());
                break;
              }
            case 6:
              {
                dispatch(SettingActionCreator.switchVideoVolume());
                break;
              }
          }
        },
      ),
    );

  return Container(
    child: Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Row(
              children: <Widget>[
                Text(
                  leftString,
                  style:
                      TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
                ),
                Expanded(child: Container()),
                Container(
                  child: rightView,
                )
              ],
            ),
          ),
          onTap: () {
            switch (index) {
              case 3:
                {
                  dispatch(SettingActionCreator.clearCache());
                  break;
                }
              case 4:
                {
                  dispatch(SettingActionCreator.gotoAccountManage());
                  break;
                }
              case 5:
                {
                  dispatch(SettingActionCreator.gotoFeedback());
                  break;
                }
            }
          },
        ),
        Container(
          color: AppTheme.colors.lineColor,
          height: 1,
        ),
      ],
    ),
  );
}
