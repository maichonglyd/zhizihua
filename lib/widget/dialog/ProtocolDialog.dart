import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/protocol_info_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sharesdk_plugin/sharesdk_interface.dart';
import 'package:url_launcher/url_launcher.dart';

class ProtocolDialog extends StatefulWidget {

  Function() clickAgree;

  ProtocolDialog({this.clickAgree});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<ProtocolDialog> {

  DialogContentState();

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
        child: new Container(
          width: 271.0,
          height: 466,
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 7.0, bottom: 5),
                  child: Text(
                    getText(name: 'textProtocolTitle'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 2.0, bottom: 15),
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: ListView(
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                          getText(name: 'textProtocolContent1'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 13.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: getText(name: 'textProtocolContent2'),
                              style: TextStyle(color: Color(0xffF35A58)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      AppConfig.baseUrl + "app/user/agreement");
                                },
                            ),
                            TextSpan(
                              text: getText(name: 'textAnd'),
                            ),
                            TextSpan(
                                text: getText(name: 'textProtocolContent3'),
                                style: TextStyle(color: Color(0xffF35A58)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    launch(AppConfig.baseUrl +
                                        "app/app/userprivacy");
                                  }),
                            TextSpan(
                              text:
                              getText(name: 'textProtocolContent4'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {});
                        exit(0);
                      },
                      child: Text(
                        getText(name: 'textNotUse'),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD8D8D8), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                    width: 111,
                    height: 41,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        ProtocolInfoUtil.saveData("2");
                          SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {});
                        if (null != widget.clickAgree) {
                          widget.clickAgree();
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        getText(name: 'textAgree'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 111,
                    height: 41,
                    decoration: BoxDecoration(
                        color: AppTheme.colors.themeColor,
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
