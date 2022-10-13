import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    //避免软键盘弹出把控件顶上去
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 56, 0, 0),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Container(
                  color: AppTheme.colors.themeColor,
                  width: 60,
                  height: 6,
                  margin: EdgeInsets.only(bottom: 4),
                ),
                Text(
                  getText(name: 'hello'),
                  style: TextStyle(
                      fontSize: HuoTextSizes.login_title,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
            child: Text(
              getText(name: 'welcomeRegister'),
              style: TextStyle(
                fontSize: HuoTextSizes.second_title,
                color: AppTheme.colors.textColor,
              ),
            ),
          ),
          state.isPhone
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 0),
                  child: TextField(
                    controller: state.mobileController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r'\d+')),
                      LengthLimitingTextInputFormatter(11)
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: getText(name: 'mobileInputHint'),
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
              : Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 0),
                  child: TextField(
                    controller: state.userNameController,

//                    inputFormatters: [
////                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
////                      LengthLimitingTextInputFormatter(12)
////                    ],
                    maxLength: 16,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: getText(name: 'textInputUsername'),
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
          state.isPhone
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 9, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: state.authcodeController,
                          maxLength: 16,
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
                            dispatch(RegisterPageActionCreator.sendSMS());
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
                      ),
                    ],
                  ))
              : Container(),
          Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffeeeeee), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              margin: EdgeInsets.fromLTRB(20, 9, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      controller: state.passwordController,
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                        LengthLimitingTextInputFormatter(8)
//                      ],
                      maxLength: 16,
                      decoration: InputDecoration(
                        hintText: getText(name: 'textPleaseInputPsd'),
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
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  dispatch(RegisterPageActionCreator.switchRegisterType());
                },
                child: Text(
                  state.isPhone
                      ? getText(name: 'textAccountRegister')
                      : getText(name: 'textPhoneRegister'),
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                ),
              )),
          Container(
              height: 40,
              margin: EdgeInsets.all(30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: new MaterialButton(
                      color: state.isAgree
                          ? AppTheme.colors.themeColor
                          : AppTheme.colors.hintTextColor,
                      textColor: state.isAgree
                          ? Colors.white
                          : AppTheme.colors.textSubColor,
                      child: new Text(getText(name: 'textRegisterNow')),
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      onPressed: state.isAgree
                          ? () {
                              state.isPhone
                                  ? dispatch(RegisterPageActionCreator
                                      .mobileRegister())
                                  : dispatch(RegisterPageActionCreator
                                      .usernameRegister());
                            }
                          : () {
                              showToast(getText(name: 'textPlaceReadAndAgree') +
                                  getText(name: 'textRegisterAgree'));
                            },
                    ),
                  ),
                ],
              )),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppTheme.colors.themeColor,
                    value: state.isAgree,
                    onChanged: (value) {
                      dispatch(
                          RegisterPageActionCreator.switchAgreement(value));
                    }),
                Text(
                  getText(name: 'textRegisterWasAgree'),
                  style: TextStyle(
                      fontSize: HuoTextSizes.third_title,
                      color: AppTheme.colors.textSubColor2),
                ),
                GestureDetector(
                  onTap: () {
                    dispatch(RegisterPageActionCreator.gotoRegisterAgreement());
                  },
                  child: Text(
                    getText(name: 'textRegisterAgree'),
                    style: TextStyle(
                        fontSize: HuoTextSizes.third_title,
                        color: AppTheme.colors.themeColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
