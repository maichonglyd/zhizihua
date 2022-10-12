import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';

class BuyAgreementDialog extends StatefulWidget {
  TextEditingController textEditingController = new TextEditingController();
  Function() ok;

  BuyAgreementDialog(this.ok);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(ok);
  }
}

class DialogContentState extends State<BuyAgreementDialog> {
  Function() ok;

  DialogContentState(this.ok);

  bool selectAgreement = false;
  DateTime lastPopTime;

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
          height: 340,
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
                  margin: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                    getText(name: 'textBuyerNotice'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
              Text(
                getText(name: 'textBuyAgreementTips'),
                style: TextStyle(
                    fontSize: 13, color: AppTheme.colors.textSubColor),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: AppTheme.colors.themeColor,
                      value: selectAgreement,
                      onChanged: (v) {
                        print(v);
                        setState(() {
                          selectAgreement = !selectAgreement;
                        });
                      },
                    ),
                    Text(
                      getText(name: 'textReadBuyerNotice'),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor2, fontSize: 12),
                    )
                  ],
                ),
              ),
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
                        if (selectAgreement) {
                          if (lastPopTime == null ||
                              DateTime.now().difference(lastPopTime) >
                                  Duration(seconds: 2)) {
                            lastPopTime = DateTime.now();
                            ok();
                          } else {
                            lastPopTime = DateTime.now();
                            showToast(getText(name: 'toastClickRepeat'));
                          }
//                          ok();
                        } else {
                          showToast(getText(name: 'toastBuyerKnowAndSelect'));
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
}
