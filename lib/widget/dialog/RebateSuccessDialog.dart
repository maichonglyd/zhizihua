import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class RebateSuccessDialog extends Dialog {
  Function() ok;
  Function() cancel;

  RebateSuccessDialog(this.ok, this.cancel);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 271.0,
              height: 280,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 17),
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
                  Container(
                    child: Image.asset(
                      "images/pic_rebate_n_sucess.png",
                      height: 80,
                      width: 80,
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  Container(
                    child: Text(
                      getText(name: 'textApplySubmitSuccessful'),
                      style: TextStyle(
                        fontSize: 17,
                        color: AppTheme.colors.textColor,
                      ),
                    ),
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      getText(name: 'textSeeDetailInRebateHistory'),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 13),
                    ),
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ok();
                      },
                      child: Text(
                        getText(name: 'textApplyHistory'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 149,
                    height: 41,
                    decoration: BoxDecoration(
                        color: AppTheme.colors.themeColor,
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                cancel();
              },
              child: Image.asset(
                "images/huosdk_yy_close.png",
                height: 27,
                width: 27,
              ),
            )
          ],
        ),
      ),
    );
  }
}
