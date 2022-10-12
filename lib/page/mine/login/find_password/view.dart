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
    FindPasswordState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Color(0xFFF8F8F8),
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textFindPassword')),
    ),
    body: Column(
      children: <Widget>[
        state.step == 0
            ? Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: TextField(
                  controller: state.userNameController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                    LengthLimitingTextInputFormatter(20)
                  ],
                  decoration: InputDecoration(
                    hintText: getText(name: 'toastInputUsernameAndPhone'),
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
              )
            : Container(),
        state.step == 1
            ? Container(
                margin:
                    EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 5),
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
                      style: TextStyle(
                          fontSize: 15, color: AppTheme.colors.themeColor),
                    )
                  ],
                ),
              )
            : Container(),
        state.step == 1
            ? Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 14, right: 14),
                child: Text(
                  getText(name: 'textFindPasswordAfterBindPhone'),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor2),
                ),
              )
            : Container(),
        state.step == 1
            ? Container(
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
                          dispatch(FindPasswordActionCreator.sendSms());
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
                ))
            : Container(),
        state.step == 2
            ? Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: TextField(
                  obscureText: true,
                  controller: state.newPwController,
//                  inputFormatters: [
//                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                    LengthLimitingTextInputFormatter(20)
//                  ],
                  maxLength: 16,
                  decoration: InputDecoration(
                    hintText: getText(name: 'toastInputNewPassword'),
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
              )
            : Container(),
        state.step == 2
            ? Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextField(
                  obscureText: true,
                  controller: state.newPw2Controller,
//                  inputFormatters: [
//                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                    LengthLimitingTextInputFormatter(20)
//                  ],
                  maxLength: 16,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textInputPasswordAgain'),
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
              )
            : Container(),
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
                      dispatch(FindPasswordActionCreator.commitData());
                    },
                  ),
                ),
              ],
            )),
        state.step == 0
            ? Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                        getText(name: 'textSupportAfterBindPhone'),
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor2, fontSize: 12),
                      ),
                      Text(
                        getText(name: 'textPleaseFindAfter'),
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor2, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          dispatch(FindPasswordActionCreator.gotoServer());
                        },
                        child: Container(
                          height: 26,
                          width: 74,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  color: Color(0xFF979797), width: 1),
                              color: Colors.white),
                          child: Text(
                            getText(name: 'textContactService'),
                            style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.colors.textSubColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}
