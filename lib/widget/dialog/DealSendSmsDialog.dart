import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';

class DealSendSmsDialog extends StatefulWidget {
  TextEditingController textEditingController = new TextEditingController();
  Function(String code) ok;
  Function() send;
  String mobile;
  DealSendSmsDialog(this.ok, this.send, this.mobile);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DealSendSmsState(ok, send, mobile);
  }
}

class DealSendSmsState extends State<DealSendSmsDialog> {
  Function(String code) ok;
  Function() send;
  TextEditingController codeController = TextEditingController();

  int countdownTime = 120;

  String mobile;

  DealSendSmsState(this.ok, this.send, this.mobile);

  Timer _timer;

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
          height: 198,
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getText(name: 'textSendToPhone', args: [mobile]),
                style:
                    TextStyle(fontSize: 13, color: AppTheme.colors.textColor),
              ),
              Container(
                  alignment: Alignment.center,
                  height: 46,
                  decoration: BoxDecoration(
                      color: AppTheme.colors.lineColor,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: codeController,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9]")),
                            LengthLimitingTextInputFormatter(8)
                          ],
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppTheme.colors.hintTextColor,
                            ),
                            contentPadding: EdgeInsets.only(left: 15),
                            counterText: "",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          style: TextStyle(
                            color: AppTheme.colors.textColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (countdownTime == 120) {
                            //倒计时，发生短信
                            countDown();
                            send();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            countdownTime == 120
                                ? getText(name: 'authGetCode')
                                : '$countdownTime ${getText(name: 'textSecond')}',
                            style: TextStyle(
                                color: AppTheme.colors.themeColor,
                                fontSize: HuoTextSizes.content),
                          ),
                        ),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        getText(name: 'textCancel'),
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
                        if (codeController.text.isNotEmpty) {
                          ok(codeController.text);
                        } else {
                          showToast(getText(name: 'toastInputSmsCode'));
                        }
                      },
                      child: Text(
                        getText(name: 'textConfirm'),
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

  //倒计时函数
  void countDown() {
    //对数据解析 重构才计数
    //启动定时器  计数
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (countdownTime > 1) {
        setState(() {
          countdownTime = --countdownTime;
        });
      } else {
        setState(() {
          countdownTime = 120;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}
