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

class SelectPayTypeDialog extends StatefulWidget {
//  String code;
  Function(PayWayMod payWayMod) pay;

//  Function(int index) switchPayIndex;
  List<PayWayMod> payWayMods;
  String price;

  SelectPayTypeDialog(this.payWayMods, this.price, this.pay);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(payWayMods, price, pay);
  }
}

class DialogContentState extends State<SelectPayTypeDialog> {
//  String code;
  List<PayWayMod> payWayMods;
  Function(PayWayMod payWay) pay;
  int selectIndex = 0;
  String price;

//  Function(int index) switchPayIndex;

  DialogContentState(this.payWayMods, this.price, this.pay);

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
                    height: 305,
                    padding: EdgeInsets.only(top: 17, bottom: 17),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              getText(name: 'textPayPriceColon'),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.colors.textSubColor),
                            ),
                            Text(
                              price != null && price != ""
                                  ? double.parse(price) == 0.01
                                      ? "${price}${getText(name: 'textPriceSymbol')}"
                                      : "${double.parse(price).toStringAsFixed(0)}${getText(name: 'textPriceSymbol')}"
                                  : "0",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFFF35A58)),
                            ),
                          ],
                        ),
                        Container(
                          color: AppTheme.colors.lineColor,
                          height: 1,
                        ),
//                        Container(
//                          margin: EdgeInsets.only(left: 16, right: 16),
//                          child: Row(
//                            children: <Widget>[
//                              Expanded(
//                                child: Text(
//                                  "平台币余额元",
////                                  "平台币余额：${state.recycleProOrder.data.ptbRemain}元",
//                                  style: TextStyle(
//                                      color: AppTheme.colors.textSubColor3,
//                                      fontSize: 13),
//                                ),
//                              ),
//                              Icon(
//                                Icons.arrow_forward_ios,
//                                size: 12,
//                              )
//                            ],
//                          ),
//                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            getText(name: 'textSelectPayWay'),
                            style: TextStyle(
                                color: AppTheme.colors.textColor, fontSize: 15),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: payWayMods.asMap().keys.map((index) {
                            var payWay = payWayMods[index];
                            return buildPayItem(
                                index, payWay.icon, payWay.name, true);
                          }).toList(),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 17, right: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
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
                                    getText(name: 'textCancel'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.colors.textSubColor),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  pay(payWayMods[selectIndex]);
                                  Navigator.pop(context);
//                                  dispatch(AccountRecyclePaybackActionCreator.pay());
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
                                    getText(name: 'textConfirm'),
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

  Widget buildPayItem(int index, String image, String payType, bool isSelect) {
    return GestureDetector(
      onTap: () {
//      switchPay(index);
//      dispatch(AccountRecyclePaybackActionCreator.switchPay(index));
        setState(() {
          selectIndex = index;
        });
      },
      child: Container(
        height: 95,
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: HuoNetImage(
                imageUrl: image,
              ),
            ),
            Text(
              payType,
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(
              color: selectIndex == index
                  ? AppTheme.colors.themeColor
                  : Color(0xFFDDDDDD),
            )),
      ),
    );
  }
}
