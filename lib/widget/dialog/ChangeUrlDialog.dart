import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class ChangeUrlDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangeUrlState();
  }
}

class ChangeUrlState extends State<ChangeUrlDialog> {
  var baseUrlController = new TextEditingController();
  var rsaKeyController = new TextEditingController();
  var appIdController = new TextEditingController();
  var clientIdController = new TextEditingController();
  var clientKeyController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                getText(name: 'textChangeUrl'),
                style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              _buildItem(getText(name: 'textPleaseInputUrl'), baseUrlController),
              _buildItem(getText(name: 'textPleaseClientKey'), rsaKeyController),
              _buildItem("${getText(name: 'textPleaseInput')} HS_APPID", appIdController),
              _buildItem("${getText(name: 'textPleaseInput')} HS_CLIENTID", clientIdController),
              _buildItem("${getText(name: 'textPleaseInput')} HS_CLIENTKEY", clientKeyController),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      String hintString, TextEditingController textEditingController) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffeeeeee), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        margin: EdgeInsets.fromLTRB(10, 9, 10, 0),
        child: TextField(
          obscureText: false,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintString,
            hintStyle: TextStyle(
              color: AppTheme.colors.hintTextColor,
            ),
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          style: TextStyle(
            color: AppTheme.colors.textColor,
          ),
        ));
  }

  Widget _buildBottomButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding:
                  EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  border: Border.all(
//                      color: AppTheme.colors.themeColor, width: 1),
//                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                getText(name: 'textCancel'),
                style:
                    TextStyle(color: AppTheme.colors.themeColor, fontSize: 15),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              SpUtil.prefs.setString(SpUtil.NEED_CHANGE_URL, "0");
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding:
                  EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
//              decoration: BoxDecoration(
//                  color: AppTheme.colors.themeColor,
//                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                getText(name: 'textRestoreDefault'),
                style:
                    TextStyle(color: AppTheme.colors.themeColor, fontSize: 15),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _saveParams();
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding:
                  EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
//              decoration: BoxDecoration(
//                  color: AppTheme.colors.themeColor,
//                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                getText(name: 'textConfirmChange'),
                style:
                    TextStyle(color: AppTheme.colors.themeColor, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _saveParams() {
    String baseUrl = baseUrlController.text;
    String rsaKey = rsaKeyController.text;
    String appId = appIdController.text;
    String clientId = clientIdController.text;
    String clientKey = clientKeyController.text;

    if (baseUrl.isEmpty ||
        rsaKey.isEmpty ||
        appId.isEmpty ||
        clientId.isEmpty ||
        clientKey.isEmpty) {
      return;
    }

    SpUtil.prefs.setString(SpUtil.BASE_URL, baseUrl);
    SpUtil.prefs.setString(SpUtil.RSA_KEY, rsaKey);
    if (Platform.isAndroid) {
      SpUtil.prefs.setString(SpUtil.APP_ID, appId);
      SpUtil.prefs.setString(SpUtil.IOS_APP_ID, AppConfig.iosAppid);
    } else {
      SpUtil.prefs.setString(SpUtil.APP_ID, AppConfig.appid);
      SpUtil.prefs.setString(SpUtil.IOS_APP_ID, appId);
    }
    SpUtil.prefs.setString(SpUtil.CLIENT_ID, clientId);
    SpUtil.prefs.setString(SpUtil.CLIENT_KEY, clientKey);
    SpUtil.prefs.setString(SpUtil.NEED_CHANGE_URL, "1");
  }
}
