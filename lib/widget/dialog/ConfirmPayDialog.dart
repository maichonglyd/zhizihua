import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

class ConfirmPayDialog extends StatefulWidget {
  Function(String payWay) pay;
  Function() paySuccess;
  String payWay;

  ConfirmPayDialog(this.payWay, this.pay, this.paySuccess);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(payWay, pay, paySuccess);
  }
}

class DialogContentState extends State<ConfirmPayDialog> {
  Function(String payWay) pay;
  Function() paySuccess;
  int selectIndex = 0;
  String payWay;

  DialogContentState(this.payWay, this.pay, this.paySuccess);

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
        child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 215,
                    padding: EdgeInsets.only(top: 17, bottom: 17),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            getText(name: 'textPaySuccessfulIf'),
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 17, right: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  pay(payWay);
                                },
                                child: Container(
                                  height: 41,
                                  width: 111,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(21)),
                                    border: Border.all(
                                      color: AppTheme.colors.textSubColor3,
                                    ),
                                  ),
                                  child: Text(
                                    getText(name: 'textContinuePay'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.colors.textSubColor),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  paySuccess();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 41,
                                  width: 111,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(21)),
                                      color: AppTheme.colors.themeColor),
                                  child: Text(
                                    getText(name: 'textPayCompleted'),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
