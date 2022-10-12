import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class GetRewardSuccessDialog extends StatefulWidget {
  String money;
  GetRewardSuccessDialog(this.money);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(this.money);
  }
}

class DialogContentState extends State<GetRewardSuccessDialog> {
  String money;
  DialogContentState(this.money);

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
            padding: EdgeInsets.all(16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/invitation_lingqu.png",
                    width: 360,
                    height: 450,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 44),
                          alignment: Alignment.center,
                          //  margin: EdgeInsets.only(top: 30.0, bottom: 10),
                          child: Text(
                            "${money}${getText(name: 'textPriceSymbol')}",
                            style: TextStyle(
                                color: Color(0xffCA2400),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          //  margin: EdgeInsets.only(top: 30.0, bottom: 10),
                          child: Text(
                            getText(name: 'textYouObtainCoupon'),
                            style: TextStyle(
                                color: Color(0xffdddddd), fontSize: 12),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
      ),
    );
  }
}
