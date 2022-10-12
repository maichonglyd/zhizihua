import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeFailDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeSuccessDialog.dart';
import 'package:oktoast/oktoast.dart';

class ExchangeRealGoodsDialog extends StatefulWidget {
  int goodsId;

  ExchangeRealGoodsDialog(this.goodsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(goodsId);
  }
}

class DialogContentState extends State<ExchangeRealGoodsDialog> {
  int goodsId;
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  DialogContentState(this.goodsId);

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
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                    getText(name: 'textInputAddress'),
                    style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  )),
              Container(
                width: 243,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textInputBuyerName'),
                    hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor, fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 15),
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              ),
              Container(
                width: 243,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: TextField(
                  controller: phoneEditingController,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textInputPhoneNumber'),
                    hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor, fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 15),
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              ),
              Container(
                width: 243,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: TextField(
                  controller: addressEditingController,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textInputMailAddress'),
                    hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor, fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 15),
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              ),
//              Container(
//                child: Row(
//                  children: <Widget>[
//                    Checkbox(
//                      activeColor: AppTheme.colors.themeColor,
//                      value: selectAgreement,
//                      onChanged: (v) {
//                        print(v);
//                        setState(() {
//                          selectAgreement = !selectAgreement;
//                        });
//                      },
//                    ),
//                    Text(
//                      "我已经阅读买家须知",
//                      style: TextStyle(
//                          color: AppTheme.colors.textSubColor2, fontSize: 12),
//                    )
//                  ],
//                ),
//              ),
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
                        if (nameEditingController.text.isEmpty) {
                          showToast(getText(name: 'toastBuyerNameNotNull'));
                          return;
                        }
                        if (phoneEditingController.text.isEmpty) {
                          showToast(getText(name: 'toastPhoneNumberNotNull'));
                          return;
                        }
                        if (addressEditingController.text.isEmpty) {
                          showToast(getText(name: 'toastMailAddressNotNull'));
                          return;
                        }

                        UserService.exchangeRealGoods(
                                goodsId,
                                phoneEditingController.text,
                                nameEditingController.text,
                                addressEditingController.text)
                            .then((data) {
                          Navigator.of(context).pop();
                          if (data['code'] == 200) {
                            showDialog<Null>(
                                context: context, //BuildContext对象
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, state) {
                                      return ExchangeSuccessDialog();
                                    },
                                  );
                                });
                          } else if (data['code'] == 44001) {
                            showDialog<Null>(
                                context: context, //BuildContext对象
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, state) {
                                      return ExchangeFailDialog();
                                    },
                                  );
                                });
                          }
                        });
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
