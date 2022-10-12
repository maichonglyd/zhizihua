import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_my_order_list_data.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyBuyListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: huoTitle(getText(name: 'textBought')),
        centerTitle: true,
      ),
      body: state.refreshHelper.getEasyRefresh(
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return state.orders[index].status == 2
                  ? buildCompleteItem(state.orders[index], index, dispatch, viewService)
                  : buildItem(state.orders[index], index, dispatch, viewService);
            },
            itemCount: state.orders.length,
          ), onRefresh: () {
        dispatch(MyBuyListActionCreator.onGetData(1));
      }, loadMore: (page) {
        dispatch(MyBuyListActionCreator.onGetData(page));
      }, controller: state.refreshHelperController));
}

Widget buildCompleteItem(Order order, int index, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        height: 240,
        padding: EdgeInsets.only(left: 14, right: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    child: new HuoNetImage(
                      imageUrl: order.gameIcon,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      height: 44,
                      width: 44,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 14),
                      child: Text(order.gameName),
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        border: Border.all(color: Color(0xFF999999))),
                    child: MaterialButton(
                      onPressed: () {
                        dispatch(MyBuyListActionCreator.onGotoDealDetails(
                            order.goodsId));
                      },
                      padding: EdgeInsets.all(0),
                      child: Text(
                        getText(name: 'textGoodsDetail'),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.textSubColor2),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: AppTheme.colors.lineColor,
              height: 1,
            ),
            Row(
              children: <Widget>[
                Text(
                  getText(name: 'textGotAccountId'),
                  style:
                      TextStyle(fontSize: 16, color: AppTheme.colors.textColor),
                ),
                Expanded(child: Container()),
                Text(
                  order.mgMemId.toString(),
                  style:
                      TextStyle(fontSize: 16, color: AppTheme.colors.textColor),
                )
              ],
            ),
            buildSubItem(getText(name: 'textPayPriceColon'), "${getText(name: 'textCurrencySymbol')}${order.realPrice}"),
            buildSubItem(getText(name: 'textPayWayColon'), order.payway),
            buildSubItem(getText(name: 'textOrderIdColon'), order.orderId),
            buildSubItem(getText(name: 'textCompleteTimeColon'), AppUtil.formatDate2(order.payTime)),
          ],
        ),
      ),
      SplitLine(),
    ],
  );
}

Widget buildItem(Order order, int index, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 94,
                    width: 130,
                    child: ClipRRect(
                      child: new HuoNetImage(
                        imageUrl: order.image.length > 0 ? order.image[0] : "",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ],
              ),
              Container(
                height: 94,
                width: 192,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      order.title,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.colors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      order.description,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 6, right: 6),
                          decoration: BoxDecoration(
                              color: Color(0xFFE6F4FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Text(
                            order.gameName,
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF008FFF)),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "${getText(name: 'textCurrencySymbol')}${order.price}",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFFF3300)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        height: 1,
        color: AppTheme.colors.lineColor,
        margin: EdgeInsets.only(left: 14, right: 14),
      ),
      Container(
        height: 43,
        margin: EdgeInsets.only(left: 14, right: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              order.status == 1 ? getText(name: 'textWaitForPay') : getText(name: 'textHasClosed'),
              style: TextStyle(color: Color(0xFFF6B345), fontSize: 13),
            ),
            Expanded(
                child: order.status == 1
                    ? Text(
                  getText(name: 'textWillClose', args: [order.expiredTime]),
                        style: TextStyle(
                            fontSize: 11, color: AppTheme.colors.textSubColor),
                      )
                    : Container()),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (order.status == 1) {
                  dispatch(MyBuyListActionCreator.pay(index));
                }
              },
              child: Container(
                height: 24,
                width: 74,
                alignment: Alignment.center,
                child: Text(
                  getText(name: 'textPayNow'),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                decoration: BoxDecoration(
                    color: order.status == 1
                        ? AppTheme.colors.themeColor
                        : Color(0xFFBEBEBE),
                    borderRadius: BorderRadius.all(Radius.circular(13))),
              ),
            )
          ],
        ),
      ),
      SplitLine(),
    ],
  );
}

Widget buildSubItem(String title, String subTitle) {
  return Container(
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
        ),
        Expanded(child: Container()),
        Text(
          subTitle,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
        )
      ],
    ),
  );
}
