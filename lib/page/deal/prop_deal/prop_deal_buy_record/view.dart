import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealBuyRecordState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> items = List();
  state.orders.forEach((order) {
    items.add(SplitLine());
    items.add(buildItem(order, dispatch, viewService));
  });
  items.add(SplitLine());
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textHasBought')),
      elevation: 0,
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: items,
        ), onRefresh: () {
      dispatch(PropDealBuyRecordActionCreator.getOrders(1));
    }, loadMore: (page) {
      dispatch(PropDealBuyRecordActionCreator.getOrders(page));
    }, controller: state.refreshHelperController),
  );
}

Widget buildItem(Order order, Dispatch dispatch, ViewService viewService) {
  String statusText = "";
  bool isPay = false;
  bool isShowDetails = false;
  Color statusColor = Color(0xFFF6B345);
  switch (order.status) {
    case 1:
      statusText = getText(name: 'textWaitForPay');
      isPay = true;
      break;
    case 2:
      statusText = getText(name: 'textHasPayed');
      isShowDetails = true;
      statusColor = Color(0xFF008FFF);
      break;
    case 4:
      statusText = getText(name: 'textOrderComplete');
      isShowDetails = true;
      statusColor = Color(0xFF008FFF);
      break;
    case 3:
      statusText = getText(name: 'textHasClosed');
      break;
  }

  return Container(
    height: 121,
    padding: EdgeInsets.only(left: 14, right: 14),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                order.gameName,
                style: TextStyle(
                    color: AppTheme.colors.textSubColor, fontSize: 12),
              ),
            ),
            if (isPay)
              GestureDetector(
                onTap: () {
                  dispatch(PropDealBuyRecordActionCreator.buy(order));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 71,
                  margin: EdgeInsets.only(left: 9),
                  child: Text(
                    getText(name: 'textPayImmediately'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: AppTheme.colors.themeColor),
                ),
              ),
            if (isShowDetails)
              GestureDetector(
                onTap: () {
                  dispatch(PropDealBuyRecordActionCreator.gotoDetails(
                      order.orderId));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 71,
                  margin: EdgeInsets.only(left: 9),
                  child: Text(
                    getText(name: 'textOrderDetail'),
                    style: TextStyle(
                      color: AppTheme.colors.textSubColor2,
                      fontSize: 12,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppTheme.colors.textSubColor3, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                ),
              ),
          ],
        ),
        Container(
          color: AppTheme.colors.lineColor,
          height: 1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(right: 8),
              child: ClipRRect(
                child: HuoNetImage(
                  imageUrl: order.gameIcon,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.title,
                  style: TextStyle(
                      color: AppTheme.colors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "${getText(name: 'textCurrencySymbol')}${order.price}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFFF3300),
                  ),
                )
              ],
            )),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                    ),
                  ),
                  if (isPay)
                    Text(
                      getText(name: 'textWillClose', args: [order.expired_time]),
                      style: TextStyle(
                          fontSize: 11, color: AppTheme.colors.textSubColor),
                    )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
