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
    BindMobileState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textToBindPhone')),
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
            controller: state.mobileController,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r'\d+')),
              LengthLimitingTextInputFormatter(11)
            ],
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
                      dispatch(BindMobileActionCreator.sendSms());
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
                      dispatch(BindMobileActionCreator.bindMobile());
                    },
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}
