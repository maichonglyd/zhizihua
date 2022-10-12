import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class LotterySuccessDialog extends StatefulWidget {
  LotterySuccessDialog();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<LotterySuccessDialog> {
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
          height: 280,
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
                "images/bg_pic_n_sucess.png",
                width: 182,
                height: 124,
              ),
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
              new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 2.0, bottom: 15),
                  child: Text(
                    getText(name: 'textSeeDetailInMine'),
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
                        AppUtil.gotoPageByName(
                            context, ExchangeRecordPage.pageName,
                            arguments: null);
                      },
                      child: Text(
                        getText(name: 'textSeeDetail'),
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
