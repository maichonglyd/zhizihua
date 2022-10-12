import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class LotteryFailDialog extends StatefulWidget {
  LotteryFailDialog();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<LotteryFailDialog> {
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
          height: 326,
          padding: EdgeInsets.only(top: 8, bottom: 18),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/bg_sc_zp_sorry.png",
                    width: 174,
                    height: 174,
                  ),
                  Image.asset(
                    "images/bg_sc_zp_caidai.png",
                    width: double.maxFinite,
                    height: 187,
                  ),
                ],
              ),
              Text(
                getText(name: 'textSorryNoThing'),
                style: TextStyle(
                    fontSize: 13, color: AppTheme.colors.textSubColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        getText(name: 'textThanksEnjoy'),
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: AppTheme.colors.themeColor,
                        border: Border.all(
                            color: AppTheme.colors.themeColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                    width: 111,
                    height: 41,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
