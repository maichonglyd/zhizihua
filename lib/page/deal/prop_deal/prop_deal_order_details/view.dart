import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_details.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PropDealOrderDetailsState state, Dispatch dispatch,
    ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textOrderDetail')),
      elevation: 0,
    ),
    body: RefreshHelper().getEasyRefresh(
        ListView(
          children: <Widget>[
            SplitLine(),
            if (state.dealPropOrderDetailsData != null)
              buildGameItem(state.dealPropOrderDetailsData, dispatch),
            SplitLine(),
            if (state.dealPropOrderDetailsData != null)
              buildDealDetailsItem(state.dealPropOrderDetailsData, viewService),
            SplitLine(),
            Container(
              margin: EdgeInsets.all(14),
              child: Text(
                getText(name: 'textGoodsDes'),
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.colors.textColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                state.dealPropOrderDetailsData.data.description,
                style: TextStyle(
                    fontSize: 12, color: AppTheme.colors.textSubColor),
              ),
              margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
            ),
            if (state.dealPropOrderDetailsData != null)
              for (int i = 0;
                  i < state.dealPropOrderDetailsData.data.image.length;
                  ++i)
                buildDealImageItem(
                    dispatch, state.dealPropOrderDetailsData.data.image[i], 1),
            buildOrderItem(state.dealPropOrderDetailsData, viewService),
            Container(
              height: 59,
            )
          ],
        ),
        controller: RefreshHelperController()),
  );
}

Widget buildGameItem(DealPropOrderDetailsData goods, Dispatch dispatch) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 83,
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new HuoNetImage(
              imageUrl: goods.data.gameIcon,
              placeholder: (context, url) => new CircularProgressIndicator(),
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    goods.data.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "¥${goods.data.price}",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFF3300)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDealDetailsItem(DealPropOrderDetailsData goods, ViewService viewService) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildTextItem(getText(name: 'textDealWayColon'), getText(name: 'textGameGive')),
        buildTextItem(getText(name: 'textBelongGame'), goods.data.gameName),
        buildTextItem(getText(name: 'textServiceColon'), goods.data.serverName),
      ],
    ),
  );
}

Widget buildTextItem(String title, String content) {
  return Row(
    children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
      ),
      Text(
        content,
        style: TextStyle(
            fontSize: 13,
            color: AppTheme.colors.textColor,
            fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget buildDealImageItem(Dispatch dispatch, String img, int index) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 189,
      margin: EdgeInsets.only(left: 14, bottom: 14, right: 14),
      child: ClipRRect(
        child: new HuoNetImage(
          imageUrl: img,
          height: 189,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
    ),
  );
}

Widget buildOrderItem(DealPropOrderDetailsData details, ViewService viewService) {
  return Container(
    height: 223,
    width: 360,
    padding: EdgeInsets.all(14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          getText(name: 'textOrderDetailed'),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.colors.textColor),
        ),
        buildOrderSubItem(getText(name: 'textOrderIdColon'), details.data.orderId),
        buildOrderSubItem(getText(name: 'textTimeColon'), details.data.buyRoleName),
        buildOrderSubItem(getText(name: 'textBelongServiceColon'), details.data.serverName),
        buildOrderSubItem(getText(name: 'textPayPriceColon'), "${getText(name: 'textCurrencySymbol')}${details.data.price}"),
        buildOrderSubItem(getText(name: 'textPayWayColon'), details.data.payway),
        buildOrderSubItem(getText(name: 'textTimeColon'), AppUtil.formatDate2(details.data.payTime)),
      ],
    ),
  );
}

Widget buildOrderSubItem(String title, String content) {
  return Row(
    children: <Widget>[
      Expanded(
          child: Text(
        title,
        style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
      )),
      Text(
        content,
        style: TextStyle(fontSize: 13, color: AppTheme.colors.textColor),
      )
    ],
  );
}
