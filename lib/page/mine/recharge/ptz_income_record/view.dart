import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/ptb_recharge_record.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PtzIncomeState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> views = List();

  for (Recharge recharge in state.records) {
    views.add(buildItem(recharge,viewService));
    views.add(SplitLine());
  }
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      title: huoTitle(getText(name: 'textGetHistory')),
      centerTitle: true,
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: views,
        ),
        controller: state.refreshHelperController, onRefresh: () {
      dispatch(PtzIncomeActionCreator.getData(1));
    }, loadMore: (page) {
      dispatch(PtzIncomeActionCreator.getData(page));
    }),
  );
}

Widget buildItem(Recharge recharge, ViewService viewService) {
  String status = getText(name: 'textFail');
  switch (recharge.status) {
    case 2:
      status = getText(name: 'textSuccess');
      break;
    case 1:
      status = getText(name: 'textWaitForPay');
      break;
    case 3:
      status = getText(name: 'textFail');
      break;
  }
  return Container(
    height: 200,
    padding: EdgeInsets.all(14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${getText(name: 'textOrderIdColon')}${recharge.orderId}",
          style: TextStyle(fontSize: 14, color: AppTheme.colors.textColor),
        ),
        Container(
          color: AppTheme.colors.lineColor,
          height: 1,
        ),
        buildSubItem(getText(name: 'textTimeColon'), "${AppUtil.formatDate2(recharge.createTime)}"),
        buildSubItem(getText(name: 'textConsumePriceColon'), recharge.realAmount.toString()),
        buildSubItem("${getText(name: 'textObtain')}${AppConfig.ptzName}：", recharge.ptbCnt.toString()),
        buildSubItem(
            getText(name: 'textPayWayColon'),
            recharge.payway == "wxpay"
                ? getText(name: 'textWx')
                : recharge.payway == "alipay" ? getText(name: 'textAliPay') : recharge.payway),
        buildSubItem(getText(name: 'textState'), status),
      ],
    ),
  );
}

Widget buildSubItem(String title, String subTitle) {
  return Row(
    children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
      ),
      Expanded(child: Container()),
      Text(
        subTitle,
        style: TextStyle(fontSize: 13, color: AppTheme.colors.textColor),
      )
    ],
  );
}
