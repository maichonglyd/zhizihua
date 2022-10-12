import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

class DealPayDialog extends StatefulWidget {
  DealGoods dealGoods;

  Function(String payWay) select;

  DealPayDialog(this.dealGoods, this.select);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DealPayState(dealGoods, select);
  }
}

class DealPayState extends State<DealPayDialog> {
  DealGoods dealGoods;

  Function(String payWay) select;

  int index = 0;

  DealPayState(this.dealGoods, this.select);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  getText(name: 'textConfirmInfo'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colors.textColor,
                    fontSize: 15,
                  ),
                ),
              ),
              buildInfoView(getText(name: 'textGameColon'), dealGoods.gameName),
              buildInfoView(getText(name: 'textAccountIdColon'), dealGoods.mgMemId.toString()),
              buildInfoView(getText(name: 'textServiceColon'), dealGoods.serverName),
              if (dealGoods.createTime != null && dealGoods.createTime > 0)
                buildInfoView(
                    getText(name: 'textOnShelfTimeColon'), AppUtil.formatDate2(dealGoods.createTime)),
              Container(
                height: 1,
                color: AppTheme.colors.lineColor,
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                margin: EdgeInsets.only(top: 13, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      getText(name: 'textNeedPayPriceColon'),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 13),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${getText(name: 'textCurrencySymbol')}${dealGoods.price}',
                      style: TextStyle(
                          color: Color(0xFFFF3300),
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 31, bottom: 10),
                child: Text(
                  getText(name: 'textSelectPayWay'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.textColor,
                      fontSize: 15),
                ),
              ),
              buildPayWayView(getText(name: 'textAliPayRe'), "images/pic_n_zhifubao.png", 0),
              Container(
                height: 1,
                color: AppTheme.colors.lineColor,
                margin: EdgeInsets.only(top: 15, bottom: 15),
              ),
              buildPayWayView(getText(name: 'textWxPay'), "images/pic_n_wechat.png", 1),
              Container(
                height: 1,
                color: AppTheme.colors.lineColor,
                margin: EdgeInsets.only(top: 15, bottom: 10),
              ),
              Container(
                width: 360,
                margin: EdgeInsets.only(left: 30, bottom: 10, right: 30),
                color: Colors.white,
                child: MaterialButton(
                  onPressed: () {
                    //回调
                    switch (index) {
                      case 0:
                        select("alipay");
                        Navigator.of(context).pop();
                        break;
                      case 1:
                        select("wxpay");
                        Navigator.of(context).pop();
                        break;
                    }
                  },
                  minWidth: 300,
                  height: 39,
                  color: AppTheme.colors.themeColor,
                  child: Text(
                    getText(name: 'textPayNow'),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildInfoView(String title, String value) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 0),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
          ),
          Expanded(child: Container()),
          Text(
            value,
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget buildPayWayView(String title, String image, int i) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: AppTheme.colors.themeColor,
              value: i == index,
              onChanged: (value) {
                setState(() {
                  index = i;
                });
              }),
          Image.asset(
            image,
            height: 24,
            width: 24,
          ),
          Text(
            title,
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
