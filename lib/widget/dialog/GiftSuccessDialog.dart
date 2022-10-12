import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class GiftSuccessDialog extends StatefulWidget {
  String code;

  GiftSuccessDialog(this.code);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(code);
  }
}

class DialogContentState extends State<GiftSuccessDialog> {
  String code;
  DialogContentState(this.code);

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
          height: 205,
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
              new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0, bottom: 5),
                  child: Text(
                    getText(name: 'textReceivingSuccessful'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 2.0, bottom: 15),
                      child: Text(
                        getText(name: 'textExChangeCodeColon'),
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor, fontSize: 13),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      padding:
                          EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 2.0, bottom: 15),
                      child: Text(
                        code,
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor, fontSize: 13),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 2.0, bottom: 15),
                  child: Text(
                    getText(name: 'textSeeDetailInGift'),
                    style: TextStyle(
                        color: AppTheme.colors.textSubColor, fontSize: 13),
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
                        getText(name: 'textClose'),
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
                        Navigator.of(context).pop();
                        showToast(getText(name: 'textCopySuccessful'));
                        AppUtil.copyToClipboard(code);
                      },
                      child: Text(
                        getText(name: 'textCopy'),
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
