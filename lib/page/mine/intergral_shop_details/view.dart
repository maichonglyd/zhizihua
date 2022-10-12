import 'package:cached_network_image/cached_network_image.dart';
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

Widget buildView(IntegralShopDetailsState state, Dispatch dispatch,
    ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: huoTitle(getText(name: 'textGoodsDetail')),
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
                                  imageUrl: state.goods.originalImg,
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 10, right: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                children: <Widget>[
                                  Text(
                                    state.goods.goodsName,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.colors.textColor),
                                  ),
                                  Expanded(child: Container()),
                                  Text(getText(name: 'textSurplus') + state.goods.remainCnt.toString(),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.colors.textSubColor2))
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SplitLine(),
                    buildDetailsItem(
                        getText(name: 'textGoodsIntroduction'),
                        state.goodsDetails != null
                            ? "${state.goodsDetails.goodsIntro}"
                            : ""),
                    buildDetailsItem(
                        getText(name: 'textExchangeNotice'),
                        state.goodsDetails != null
                            ? "${state.goodsDetails.goodsContent}"
                            : ""),
//            buildDetailsItem(
//                "礼包内容",
//                (state.goodsDetails != null && state.goodsDetails.gift != null)
//                    ? state.goodsDetails.gift.content
//                    : ""),
//            buildDetailsItem(
//                "使用方法",
//                (state.goodsDetails != null && state.goodsDetails.gift != null)
//                    ? state.goodsDetails.gift.func
//                    : ""),
                  ],
                ),
                controller: RefreshHelperController()),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 55,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1,
                        color: AppTheme.colors.lineColor,
                      ),
                      Container(
                        height: 54,
                        margin: EdgeInsets.only(left: 14),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.goodsDetails != null
                              ? getText(name: 'textIntegral') + state.goodsDetails.integral
                              : "",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xffF35A58)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 55,
                width: 115,
                color: Color(0xffF35A58),
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    dispatch(IntegralShopDetailsActionCreator.exchangeGoods());
                  },
                  child: Text(
                    state.buttonText,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ));
}

Widget buildDetailsItem(String title, String details) {
  return Container(
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: HuoTextSizes.second_title),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 13, top: 5),
          child: HtmlTextView(
            data: details,
            maxLines: 4,
          ),
        )
      ],
    ),
  );
}
