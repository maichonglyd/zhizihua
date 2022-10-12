import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_html_text/html_text_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ExchangeRecordDetailsState state, Dispatch dispatch,
    ViewService viewService) {
  String status = ""; //1 未发货 2 已发货 3 发货失败 4 待领取
  Color color = AppTheme.colors.textSubColor2;
  if (state.exchangeBean.shippingStatus == 1) {
    status = getText(name: 'textNotDelivered');
  } else if (state.exchangeBean.shippingStatus == 2) {
    status = getText(name: 'textHasDelivered');
    color = Color(0xffF6B345);
  } else if (state.exchangeBean.shippingStatus == 3) {
    status = getText(name: 'textDeliveredFailed');
  } else if (state.exchangeBean.shippingStatus == 4) {
    status = getText(name: 'textUnclaimed');
    color = Color(0xffF6B345);
  }
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: huoTitle(getText(name: 'textOrderDetail')),
        centerTitle: true,
        elevation: 0,
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshHelper().getEasyRefresh(
                ListView(
                  children: <Widget>[
                    SplitLine(),
                    Column(
                      children: <Widget>[
                        Container(
                          color: Color(0xffF8F8F8),
                          margin: EdgeInsets.only(left: 14, right: 14, top: 13),
                          child: Container(
                            height: 200,
                            width: double.maxFinite,
                            color: Color(0xffF8F8F8),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 20),
                            child: ClipRRect(
                              child: new HuoNetImage(
                                  imageUrl: state.exchangeBean.originalImg,
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 12, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                state.exchangeBean.goodsName,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.colors.textColor),
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
                                    state.exchangeBean.num.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.colors.themeColor),
                                  ),
                                  Text(
                                    getText(name: 'textNumberGoods'),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.colors.textSubColor2),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    status,
                                    style:
                                        TextStyle(fontSize: 12, color: color),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SplitLine(),
                    if (state.exchangeDetail != null)
                      Container(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  getText(name: 'textOrderInfo'),
                                  style: TextStyle(
                                      color: AppTheme.colors.textColor,
                                      fontSize: HuoTextSizes.second_title),
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _createItem(
                                        "${getText(name: 'textOrderNumberColon')}${state.exchangeBean.orderId}"),
                                    _createItem(getText(name: 'textOrderTime') +
                                        AppUtil.formatDate2(
                                            state.exchangeBean.createTime)),
                                    if (state.exchangeDetail != null &&
                                        state.exchangeDetail.data.consignee
                                            .isNotEmpty)
                                      _createItem(getText(name: 'textConsigneeName') +
                                          state.exchangeDetail.data.consignee),
                                    if (state.exchangeDetail != null &&
                                        state.exchangeDetail.data.mobile
                                            .isNotEmpty)
                                      _createItem(getText(name: 'textMobilePhoneColon') +
                                          state.exchangeDetail.data.mobile),
                                    if (state.exchangeDetail != null &&
                                        state.exchangeDetail.data.address
                                            .isNotEmpty)
                                      _createItem(getText(name: 'textShoppingAddress') +
                                          state.exchangeDetail.data.address),
                                    state.exchangeBean.code.isNotEmpty
                                        ? Container(
                                            alignment: Alignment.center,
                                            color: Color(0xffF8F8F8),
                                            margin: EdgeInsets.only(
                                                left: 14, right: 14, top: 13),
                                            child: Container(
                                              height: 86,
                                              width: 245,
                                              color: Color(0xffF8F8F8),
                                              padding: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      getText(name: 'textExchangeCode'),
                                                      style: TextStyle(
                                                          color: AppTheme.colors
                                                              .textSubColor,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      state.exchangeBean.code,
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .colors.textColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      getText(name: 'textDeadlineTime') +
                                                          (state.exchangeDetail
                                                                  .data.endTime
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? AppUtil.formatDate2(
                                                                  int.parse(state
                                                                      .exchangeDetail
                                                                      .data
                                                                      .endTime))
                                                              : ""),
                                                      style: TextStyle(
                                                          color: AppTheme.colors
                                                              .textSubColor,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    if (state.exchangeDetail != null &&
                        state.exchangeDetail.data.invoiceNo.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  getText(name: 'textViewLogistics'),
                                  style: TextStyle(
                                      color: AppTheme.colors.textColor,
                                      fontSize: HuoTextSizes.second_title),
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _createItem(
                                        "${state.exchangeDetail.data.shippingName}"),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 2),
                                          child: Text(
                                            "${getText(name: 'textLogistics')}${state.exchangeDetail.data.invoiceNo}",
                                            style: TextStyle(
                                                color: AppTheme
                                                    .colors.textSubColor,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            dispatch(
                                                ExchangeRecordDetailsActionCreator
                                                    .copyNum());
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 2, bottom: 2),
                                            child: Text(
                                              getText(name: 'textCopy'),
                                              style: TextStyle(
                                                  color: AppTheme
                                                      .colors.themeColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                  ],
                ),
                controller: RefreshHelperController()),
          ),
        ],
      ));
}

_createItem(String s) {
  return Container(
    margin: EdgeInsets.only(top: 2, bottom: 2),
    child: Text(
      s,
      style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 12),
    ),
  );
}
