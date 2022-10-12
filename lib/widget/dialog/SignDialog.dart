import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/user_sign_list_data.dart'
    as user_sign_list_data;

class SignDialog extends Dialog {
  TextEditingController textEditingController = new TextEditingController();
  Function() ok;
  user_sign_list_data.Data data;
  SignDialog(this.data, this.ok);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Container(
        //保证控件居中效果
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(14),
                child: Image.asset(
                  "images/huosdk_yy_close.png",
                  height: 27,
                  width: 27,
                ),
              ),
            ),
            Container(
              width: 360.0,
              height: 340,
              padding: EdgeInsets.only(left: 14, right: 14),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(17.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      margin: EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            getText(name: 'textSign'),
                            style: TextStyle(
                                color: AppTheme.colors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "",
                              contentPadding: EdgeInsets.only(left: 5),
                              counterText: "",
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          )),
                          Text(
                            getText(name: 'textCumulative', args: [data.signDays]),
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 14),
                          )
                        ],
                      )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: data.list.asMap().keys.map((index) {
                        String desc = data.list[index].desc;
                        bool isSign = data.signDays > index;
                        bool signing = data.signDays == index;
                        int integral = data.list[index].integral;
                        return buildSignItem(
                            index == 6 ? 159 : 77, desc, ok, integral, context,
                            isSign: isSign, signing: signing);
                      }).toList(),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSignItem(double w, title, ok, integral, BuildContext context,
      {bool isSign = false, bool signing = false}) {
    return Container(
      height: 95,
      width: w,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          isSign
              ? Container(
                  height: 70,
                  width: w - 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/icon_n_sucess.png",
                        height: 16,
                        width: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          getText(name: 'textHasReceived'),
                          style: TextStyle(color: Colors.white, fontSize: 9),
                        ),
                      )
                    ],
                  ),
                  color: Color(0xff4A89C0),
                )
              : GestureDetector(
                  onTap: () {
                    if (signing) {
                      //签到
                      ok();
                    }
                  },
                  child: Container(
                    height: 70,
                    width: w - 6,
                    child: Stack(
                      children: <Widget>[
                        signing
                            ? Image.asset(
                                "images/pic_n_qiandao.png",
                                fit: BoxFit.cover,
                                width: w,
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/icon_n_qiandao.png",
                            height: 34,
                            width: 34,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "${getText(name: 'textIntegral')}+$integral",
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    color: Color(0xFFFFFEF8),
                  ),
                )
        ],
      ),
      decoration: BoxDecoration(
          color: AppTheme.colors.themeColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: AppTheme.colors.themeColor, width: 3)),
    );
  }
}
