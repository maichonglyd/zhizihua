import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/lottery_draw.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryRealGoodsAddressDialog.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

class LotteryRealGoodsDialog extends StatefulWidget {
  LotteryDrawData lotteryDrawData;

  LotteryRealGoodsDialog(this.lotteryDrawData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(lotteryDrawData);
  }
}

class DialogContentState extends State<LotteryRealGoodsDialog> {
  LotteryDrawData lotteryDrawData;
  DialogContentState(this.lotteryDrawData);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    type: MaterialType.card,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: new Container(
                            alignment: Alignment.center,
                            width: 271.0,
                            height: 339,
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.only(top: 15, bottom: 15),
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
                                Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 174,
                                      width: 174,
                                      child: ClipRRect(
                                        child: new HuoNetImage(
                                          imageUrl:
                                              lotteryDrawData.data.originalImg,
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                    ),
                                    Image.asset(
                                      "images/bg_sc_zp_caidai.png",
                                      width: double.maxFinite,
                                      height: 187,
                                    ),
                                  ],
                                ),
                                new Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(top: 20.0, bottom: 10),
                                    child: Text(
                                      getText(name: 'textCongratulateToYou') + lotteryDrawData.data.awardName,
                                      style: TextStyle(
                                          color: AppTheme.colors.textSubColor,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
//                        Container(
//                          child: MaterialButton(
//                            onPressed: () {
//                              Navigator.pop(context);
//                            },
//                            child: Text(
//                              "取消",
//                            ),
//                          ),
//                          decoration: BoxDecoration(
//                              border: Border.all(color: Color(0xFFD8D8D8), width: 1),
//                              borderRadius: BorderRadius.all(Radius.circular(21))),
//                          width: 111,
//                          height: 41,
//                        ),
                                    Container(
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog<Null>(
                                              context: context, //BuildContext对象
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder: (context, state) {
                                                    return LotteryRealGoodsAddressDialog(
                                                        lotteryDrawData
                                                            .data.orderId);
                                                  },
                                                );
                                              });
                                        },
                                        child: Text(
                                          getText(name: 'textGetRewordNow'),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      width: 111,
                                      height: 41,
                                      decoration: BoxDecoration(
                                          color: AppTheme.colors.themeColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(21))),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              "images/icon_home_push_off.png",
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Stack(
                    children: <Widget>[
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/bg_sc_zp_biaoqian.png",
                          width: 198,
                          height: 46,
                        ),
                      ),
                      new Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          child: Text(
                            getText(name: 'textWinPrice'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  )),
                ],
              )
            ],
          ),
        ));
  }
}
