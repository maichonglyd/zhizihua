import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UpdatePasswordState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textModifyPassword')),
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
    body: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: TextField(
            obscureText: true,
            controller: state.oldPwdController,
            inputFormatters: [],
            decoration: InputDecoration(
              hintText: getText(name: 'textPleaseInputOriginalPassword'),
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
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextField(
            obscureText: true,
            controller: state.newPwd1Controller,
            maxLength: 16,
            inputFormatters: [],
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
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextField(
            obscureText: true,
            controller: state.newPwd2Controller,
            maxLength: 16,
            inputFormatters: [],
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
        ),
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
                      dispatch(UpdatePasswordActionCreator.updatePwd());
                    },
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}
