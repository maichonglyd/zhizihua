import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ExchangeRecordState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textExchangeHistory')),
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
        children: state.list
            .asMap()
            .keys
            .map((index) => buildItem(state.list, index, dispatch, viewService))
            .toList(),
      ),
      controller: state.refreshHelperController,
      onRefresh: () {
        dispatch(ExchangeRecordActionCreator.getRecordData(1));
      },
      loadMore: (page) {
        dispatch(ExchangeRecordActionCreator.getRecordData(page));
      },
    ),
  );
}

Widget buildItem(List<ExchangeBean> list, int index, Dispatch dispatch, ViewService viewService) {
  String status = ""; //1 未发货 2 已发货 3 发货失败 4 待领取
  Color color = AppTheme.colors.textSubColor2;
  if (list[index].shippingStatus == 1) {
    status = getText(name: 'textNotDelivered');
  } else if (list[index].shippingStatus == 2) {
    status = getText(name: 'textHasDelivered');
    color = Color(0xffF6B345);
  } else if (list[index].shippingStatus == 3) {
    status = getText(name: 'textDeliveredFailed');
  } else if (list[index].shippingStatus == 4) {
    status = getText(name: 'textUnclaimed');
    color = Color(0xffF6B345);
  }
  return GestureDetector(
    child: Container(
      child: Container(
        height: 135,
        margin: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 0.5, color: Color(0xffEEEEEE)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 110,
                  height: 68,
                  color: Color(0xffF8F8F8),
                  margin: EdgeInsets.all(15),
//                padding: EdgeInsets.only(left: 14,right: 14,top: 5,bottom: 5),
                  child: ClipRRect(
                    child: new HuoNetImage(
                        imageUrl: list[index].originalImg, fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 7),
                      child: Text(
                        list[index].goodsName,
                        style: TextStyle(
                            fontSize: 16, color: AppTheme.colors.textColor),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          getText(name: 'textGong'),
                          style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.colors.textSubColor2),
                        ),
                        Text(
                          list[index].num.toString(),
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.colors.themeColor),
                        ),
                        Text(
                          getText(name: 'textNumberGoods'),
                          style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.colors.textSubColor2),
                        )
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 22,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffEEEEEE),
                      border:
                          new Border.all(width: 0.5, color: Color(0xffEEEEEE)),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Text(
                    status,
                    style: TextStyle(fontSize: 12, color: color),
                  ),
                ),
              ],
            ),
            Container(
              color: AppTheme.colors.lineColor,
              height: 0.5,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        getText(name: 'textConsume'),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.textSubColor2),
                      ),
                      Text(
                        list[index].integral.toString() + getText(name: 'textIntegral'),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.themeColor),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    AppUtil.formatDate2(list[index].createTime),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor2),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
    onTap: () {
      dispatch(ExchangeRecordActionCreator.gotoDetails(list[index]));
    },
  );
}
