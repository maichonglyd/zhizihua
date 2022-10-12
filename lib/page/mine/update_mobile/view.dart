import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UpdateMobileState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textChangePhone')),
    ),
    body: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 5),
          child: Row(
            children: <Widget>[
              Text(
                getText(name: 'textBindAccountColon'),
                style: TextStyle(
                    fontSize: 15, color: AppTheme.colors.textSubColor),
              ),
              Text(
                state != null && state.bindMobile != null
                    ? state.bindMobile
                    : "",
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.themeColor),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 14, right: 14),
          child: Text(
            getText(name: 'textChangePhoneTip'),
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
          ),
        ),
        Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: state.codeController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                      LengthLimitingTextInputFormatter(8)
                    ],
                    decoration: InputDecoration(
                      hintText: getText(name: 'authInputHint'),
                      hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor,
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      counterText: "",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: AppTheme.colors.textColor,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 25,
                  color: AppTheme.colors.themeColor,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                GestureDetector(
                  onTap: () {
                    if (state.countdownTime == 120)
                      dispatch(UpdateMobileActionCreator.sendSms());
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      state.countdownTime == 120
                          ? getText(name: 'authGetCode')
                          : '${state.countdownTime} ${getText(name: 'textSecond')}',
                      style: TextStyle(
                          color: AppTheme.colors.themeColor,
                          fontSize: HuoTextSizes.content),
                    ),
                  ),
                )
              ],
            )),
        Container(
            height: 40,
            margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new MaterialButton(
                    color: AppTheme.colors.themeColor,
                    textColor: Colors.white,
                    child: new Text(getText(name: 'textConfirm')),
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    onPressed: () {
                      dispatch(UpdateMobileActionCreator.checkMobile());
                    },
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}
