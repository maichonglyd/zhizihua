import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealNoticeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textTradingInstructions')),
    ),
    body: ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 14, right: 14, top: 15, bottom: 15),
          child: Text(
              getText(name: 'textDealNoticeTips')),
        ),
        SplitLine(),
        Container(
          margin: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getText(name: 'textBuyAccount'),
                style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.textColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset("images/pic_n_maijia.png"),
              ),
              buidStep("1", getText(name: 'textDealNoticeTipItem1')),
              buidStep("2", getText(name: 'textDealNoticeTipItem2')),
              buidStep("3", getText(name: 'textDealNoticeTipItem3')),
              buidStep("4", getText(name: 'textDealNoticeTipItem4')),
            ],
          ),
        ),
        SplitLine(),
        Container(
          margin: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getText(name: 'textSellAccount'),
                style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.textColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset("images/pic_n_2.png"),
              ),
              buidStep("1", getText(name: 'textDealNoticeTipItem5')),
              buidStep("2", getText(name: 'textDealNoticeTipItem6')),
              buidStep("3", getText(name: 'textDealNoticeTipItem7', args: [AppConfig.ptzName])),
              buidStep("4", getText(name: 'textDealNoticeTipItem8')),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buidStep(String step, String data) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 18,
          width: 18,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              color: Color(0xFFFFA10A),
              borderRadius: BorderRadius.all(Radius.circular(9))),
          child: Text(
            step,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
            child: Text(
          data,
          softWrap: true,
          maxLines: 4,
          style: TextStyle(fontSize: 12, color: AppTheme.colors.textColor),
        ))
      ],
    ),
  );
}
