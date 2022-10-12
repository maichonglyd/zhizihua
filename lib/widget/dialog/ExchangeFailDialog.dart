import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:oktoast/oktoast.dart';

class ExchangeFailDialog extends StatefulWidget {
  ExchangeFailDialog();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<ExchangeFailDialog> {
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
          child: Stack(
        children: <Widget>[
          Center(
            child: new Container(
              alignment: Alignment.center,
              width: 271.0,
              height: 170,
              margin: EdgeInsets.only(top: 56),
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
                  new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50.0, bottom: 10),
                      child: Text(
                        getText(name: 'textYourIntegralNotEnough'),
                        style: TextStyle(
                            color: AppTheme.colors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        textAlign: TextAlign.center,
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
                            border:
                                Border.all(color: Color(0xFFD8D8D8), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(21))),
                        width: 111,
                        height: 41,
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            AppUtil.gotoPageByName(
                                context, TaskCenterPage.pageName,
                                arguments: null);
                          },
                          child: Text(
                            getText(name: 'textMakeIntegral'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: 111,
                        height: 41,
                        decoration: BoxDecoration(
                            color: AppTheme.colors.themeColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(21))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 190),
            height: 128,
            child: Image.asset(
              "images/bg_huosdk_picture_jifenbuzu.png",
              width: 128,
              height: 128,
            ),
          )
        ],
      )),
    );
  }
}
