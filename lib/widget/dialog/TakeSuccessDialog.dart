import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/generated/theme/colors.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

///领取成功记录
class RewardSuccessDialog extends StatefulWidget {
  String content;
  String price;
  Function() ok;

  RewardSuccessDialog(this.content, this.price, this.ok);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(content, price, ok);
  }
}

class DialogContentState extends State<RewardSuccessDialog> {
  String content;
  String price;
  int selectIndex = 0;
  Function() ok;

  DialogContentState(this.content, this.price, this.ok);

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
                        height: 305,
                        width: 300,
                        color: Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 300,
                              height: 215,
                              padding: EdgeInsets.only(top: 14, bottom: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      getText(name: 'textCongratulation'),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppTheme.colors.textColor),
                                    ),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 30),
                                  ),
                                  Container(
                                    child: Image.asset(
                                      "images/sucai_jinbi.png",
                                      width: 85,
                                      height: 61,
                                      fit: BoxFit.cover,
                                    ),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 15),
                                  ),
                                  Container(
                                    child: Text(
                                      "+${price}${getText(name: 'textPlatformCurrency')}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffFF9500)),
                                    ),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 15),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 30),
                                child: Image.asset("images/ic_off.png"),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )

//                            Stack(
//                              children: <Widget>[
//                                Container(
//                                  width: 300,
//                                  height: 215,
//                                  padding: EdgeInsets.only(top: 14, bottom: 14),
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius:
//                                    BorderRadius.all(Radius.circular(15)),
//                                  ),
//                                ),
//                                Container(
//                                  width: 300,
//                                  height: 46,
//                                  alignment: Alignment.center,
//                                  decoration: BoxDecoration(
//                                      image: new DecorationImage(
//                                        image: new AssetImage(
//                                            "images/sc_zp_biaoqian.png"),
//                                      )),
//                                  child: Text(
//                                    "$context",
//                                    style: TextStyle(
//                                        fontSize: 18,
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.w600
//                                    ),
//                                  ),
//                                ),
//                                Image.asset("images/ic_off.png")
//                              ],
//                            )
                          ],
                        )

//                    child: Container(
//                      width: 300,
//                      height: 215,
//                      padding: EdgeInsets.only(top: 14, bottom: 14),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.all(Radius.circular(15)),
//                      ),
//                    ),
                        )),
              ),
            )),
      ),
    );
  }
}
