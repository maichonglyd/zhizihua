import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class UpdateNameDialog extends Dialog {
  TextEditingController textEditingController;
  Function(String value) ok;

  UpdateNameDialog(this.textEditingController, this.ok);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: new Container(
          width: 271.0,
          height: 160,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(getText(name: 'textNameColon')),
                      Expanded(
                          child: TextField(
                        controller: textEditingController,
                        maxLength: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "",
                          contentPadding: EdgeInsets.only(left: 5),
                          counterText: "",
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ))
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
                        ok(textEditingController.text);
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
}
