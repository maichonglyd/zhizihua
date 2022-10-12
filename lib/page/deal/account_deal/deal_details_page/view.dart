import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealDetailsState state, Dispatch dispatch, ViewService viewService) {
  bool isEdit = false;
  bool isCancel = false;
  TextSpan statusText;
  if (state.dealGoods != null) {
    switch (state.dealGoods.status) {
      case 1: //审核中
        statusText = TextSpan(
          text: getText(name: 'textUnderReview'),
          style: TextStyle(color: AppTheme.colors.checkingColor, fontSize: 15),
        );
        break;
      case 2: //已上架
        statusText = TextSpan(
          text: getText(name: 'textOnShelf'),
          style: TextStyle(color: AppTheme.colors.checkOkColor, fontSize: 15),
        );
        isEdit = true;
        isCancel = true;
        break;
      case 3: //已下架
        statusText = TextSpan(
          text: getText(name: 'textOffShelf'),
          style: TextStyle(color: AppTheme.colors.sellOKColor, fontSize: 15),
        );
        isEdit = true;
        break;
      case 4: //已出售
        statusText = TextSpan(
          text: getText(name: 'textSold'),
          style: TextStyle(color: AppTheme.colors.sellOKColor, fontSize: 15),
        );
        break;
      case 5: //审核不通过
        statusText = TextSpan(
          text: getText(name: 'textFailedToPassTheAudit'),
          style: TextStyle(color: AppTheme.colors.checkFailColor, fontSize: 15),
        );
        isEdit = true;
        isCancel = false;
        break;
      case 6: //锁定（有人正在支付中，显示已上架，但是点击修改或者下架提示）
        statusText = TextSpan(
          text: getText(name: 'textOnShelf'),
          style: TextStyle(color: AppTheme.colors.checkOkColor, fontSize: 15),
        );
        isEdit = true;
        isCancel = true;
        break;
    }
  }
  return Stack(
    children: <Widget>[
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: huoTitle(getText(name: 'textRoleDetail')),
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
        body: RefreshHelper().getEasyRefresh(
            ListView(
              children: <Widget>[
                SplitLine(),
                if (state.dealGoods != null)
                  buildGameItem(state.dealGoods, dispatch, viewService),
                SplitLine(),
                if (state.dealGoods != null)
                  buildDealDetailsItem(state.dealGoods, viewService),
                SplitLine(),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text(
                    getText(name: 'textSellerDes'),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    state.dealGoods != null ? state.dealGoods.description : "",
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor),
                  ),
                  margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                ),
                if (state.dealGoods != null)
                  for (int i = 0; i < state.dealGoods.image.length; ++i)
                    buildDealImageItem(dispatch, state.dealGoods.image[i], i),
                Container(
                  height: 59,
                )
              ],
            ),
            controller: RefreshHelperController()),
      ),
      if (state.dealGoods != null && state.dealGoods.status != 4)
        Align(
          alignment: Alignment.bottomCenter,
          child: state.dealGoods.isMine == 2
              ? Container(
                  height: 59,
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  width: 360,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: getText(name: 'textState'),
                            style: TextStyle(
                                fontSize: 15,
                                color: AppTheme.colors.textSubColor),
                          ),
                          statusText,
                        ])),
                      )),
                      if (isCancel)
                        Container(
                          height: 39,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppTheme.colors.textSubColor),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: MaterialButton(
                              onPressed: () {
                                viewService.broadcast(
                                    IndexDealFragmentActionCreator.onCancel(
                                        state.goodsId, state.dealGoods.status));
                              },
                              child: Text(getText(name: 'textCancelSell')),
                              height: 39),
                        ),
                      if (isEdit)
                        MaterialButton(
                          height: 39,
                          onPressed: () {
                            viewService.broadcast(
                                IndexDealFragmentActionCreator.onGotoSellEdit(
                                    state.goodsId, state.dealGoods.status));
                          },
                          child: Text(
                            getText(name: 'textModify'),
                            style: TextStyle(color: Colors.white),
                          ),
                          color: AppTheme.colors.themeColor,
                        ),
                    ],
                  ),
                )
              : Container(
                  width: 360,
                  height: 59,
                  padding:
                      EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 10),
                  color: Colors.white,
                  child: MaterialButton(
                    onPressed: () {
                      dispatch(
                          DealDetailsActionCreator.showBuyAgreementDialog());
                    },
                    height: 39,
                    minWidth: 300,
                    color: AppTheme.colors.themeColor,
                    child: Text(
                      getText(name: 'textBuyNow'),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
        )
    ],
  );
}

Widget buildGameItem(DealGoods dealGoods, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      dispatch(DealDetailsActionCreator.gotoGame());
    },
    child: Container(
      height: 83,
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new HuoNetImage(
              imageUrl: dealGoods.gameIcon,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dealGoods.gameName,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    dealGoods.gamePublicity,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 11, color: AppTheme.colors.textSubColor),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Material(
              child: SizedBox(
                child: Center(
                  child: Text(getText(name: 'textToDownload')),
                ),
                width: 55,
                height: 30,
              ),
              textStyle:
                  TextStyle(color: AppTheme.colors.themeColor, fontSize: 13),
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                    style: BorderStyle.solid,
                    color: AppTheme.colors.themeColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDealDetailsItem(DealGoods dealGoods, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 104,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 14, bottom: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        getText(name: 'textAccountId', args: [dealGoods.mgMemId]),
                        style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.colors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        getText(name: 'textServiceId', args: [dealGoods.serverName]),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.colors.textSubColor,
                        ),
                      ),
                      Text(
                        getText(name: 'textUpdateTime', args: [AppUtil.formatDate2(dealGoods.updateTime)]),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.colors.textSubColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                  "${getText(name: 'textCurrencySymbol')}${dealGoods.price}",
                  style: TextStyle(
                      fontSize: 26, color: AppTheme.colors.themeColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        Container(
          height: 40,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
              getText(name: 'textCumulativeRecharge', args: [dealGoods.sumMoney]),
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.colors.textSubColor,
                ),
              )),
//              Container(
//                color: Color(0xFFDFFFF0),
//                padding: EdgeInsets.only(left: 6, right: 6),
//                child: Text(
//                  "审核通过",
//                  style: TextStyle(
//                    fontSize: 12,
//                    color: Color(0xFF05D84A),
//                  ),
//                ),
//              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildDealImageItem(Dispatch dispatch, String img, int index) {
  return GestureDetector(
    onTap: () {
      dispatch(DealDetailsActionCreator.gotoGallery(index));
    },
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
