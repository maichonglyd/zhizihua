import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class GameReserveSuccessDialog extends StatefulWidget {
  GameReserveSuccessDialog();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<GameReserveSuccessDialog> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //保证控件居中效果
            children: <Widget>[
              new Container(
                width: 271.0,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/uni_pic_success.png",
                      width: 60,
                      height: 60,
                    ),
                    new Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0, bottom: 5),
                        child: Text(
                          getText(name: 'textYouAppointmentSuccessful'),
                          style: TextStyle(
                              color: AppTheme.colors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                          textAlign: TextAlign.center,
                        )),
                    new Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 2.0, bottom: 15),
                        child: Text(
                          getText(name: 'textWillNoticeAfterGame'),
                          style: TextStyle(
                              color: AppTheme.colors.textColor, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      color: AppTheme.colors.lineColor,
                      height: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 8.0, bottom: 0),
                          child: Text(
                            getText(name: 'textIKnowIt'),
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 16),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
