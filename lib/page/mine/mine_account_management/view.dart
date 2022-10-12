import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountManageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textAccountManager')),
      centerTitle: true,
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
    body: ListView(
      children: <Widget>[
        SplitLine(),
        buildItem(getText(name: 'textHeaderImg'), viewService,
            dispatch: dispatch,
            hasHead: true,
            imageUrl: state != null &&
                    state.userInfo != null &&
                    state.userInfo.avatar != null
                ? state.userInfo.avatar
                : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg"),
        GestureDetector(
          onTap: () {
            dispatch(AccountManageActionCreator.updateNickname());
          },
          child: buildItem(getText(name: 'textNicknameSimple'),viewService,
              hasRText: true,
              rightString: state != null &&
                      state.userInfo != null &&
                      state.userInfo.nickname != null
                  ? state.userInfo.nickname
                  : getText(name: 'textUsername')),
        ),
        GestureDetector(
          onTap: () {
            dispatch(AccountManageActionCreator.gotoUpdateMobile(
                state.userInfo.hasBindMobile));
          },
          child: buildItem(
              state.userInfo != null && state.userInfo.hasBindMobile == 2
                  ? getText(name: 'textModifyPhone')
                  : getText(name: 'textBindPhone'),viewService,
              hasRText: true,
              rightString: state != null &&
                      state.userInfo != null &&
                      state.userInfo.mobile != null
                  ? state.userInfo.mobile
                  : getText(name: 'toastNoBondPhone')),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(AccountManageActionCreator.gotoUpdatePw());
          },
          child: buildItem(getText(name: 'textModifyPassword'),viewService,),
        ),
        GestureDetector(
          child: buildItem(getText(name: 'textRealNameAuth'),viewService,
              isReal: state != null &&
                  state.userInfo != null &&
                  state.userInfo.hasIdentify == 2),
          onTap: () {
            if (!(state.userInfo.hasIdentify == 2)) {
              dispatch(AccountManageActionCreator.gotoIdentify());
            }
          },
        ),
        Container(
          height: 9,
          color: AppTheme.colors.lineColor,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(AccountManageActionCreator.gotoWebView(1));
          },
          child: buildItem(getText(name: 'textUserAgreement'), viewService,),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(AccountManageActionCreator.gotoWebView(2));
          },
          child: buildItem(getText(name: 'textParentalGuardianship'), viewService,),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(AccountManageActionCreator.gotoWebView(3));
          },
          child: buildItem(getText(name: 'textAntiAddictionSystem'), viewService,),
        ),
      ],
    ),
  );
}

Widget buildItem(
  String leftString, ViewService viewService, {
  bool hasHead: false,
  bool hasRText: false,
  bool isReal,
//  bool hasBindMobile,
  String rightString: "",
  String imageUrl,
  Dispatch dispatch,
}) {
  Widget rightView = Container();
  if (hasHead)
    rightView = GestureDetector(
      onTap: () {
        dispatch(AccountManageActionCreator.selectPic());
      },
      child: Container(
        height: 38,
        width: 38,
        child: ClipOval(
          child: HuoNetImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  if (hasRText)
    rightView = Text(rightString,
        style: TextStyle(fontSize: 15, color: AppTheme.colors.textSubColor2));

  if (isReal != null)
    rightView = Text(isReal ? getText(name: 'textAuthCompleted') : getText(name: 'textGotoAuth'),
        style: TextStyle(
            fontSize: 15,
            color: isReal
                ? AppTheme.colors.textColor
                : AppTheme.colors.themeColor));

  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Container(
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
                margin: EdgeInsets.only(right: 9),
                child: rightView,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
              )
            ],
          ),
        ),
        Container(
          color: AppTheme.colors.lineColor,
          height: 1,
        ),
      ],
    ),
  );
}
