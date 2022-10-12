import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealDetailsState state, Dispatch dispatch, ViewService viewService) {
  bool isEdit = false;
  bool isCancel = false;
  TextSpan statusText;
  if (state.goods != null) {
    switch (state.goods.status) {
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
          title: huoTitle(getText(name: 'textPropsDetail')),
          elevation: 0,
        ),
        body: RefreshHelper().getEasyRefresh(
            ListView(
              children: <Widget>[
                SplitLine(),
                if (state.goods != null) buildGameItem(state.goods, dispatch, viewService),
                SplitLine(),
                if (state.goods != null) buildDealDetailsItem(state.goods, viewService),
                SplitLine(),
                Container(
                  child: Text(
                    state.goods.description,
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor),
                  ),
                  margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                ),
                if (state.goods != null)
                  for (int i = 0; i < state.goods.image.length; ++i)
                    buildDealImageItem(dispatch, state.goods.image[i], 1),
                Container(
                  height: 59,
                )
              ],
            ),
            controller: RefreshHelperController()),
      ),
//        if (state.dealGoods != null && state.dealGoods.status != 4)
      Align(
        alignment: Alignment.bottomCenter,
        child: state.goods != null && state.goods.isMine == 2
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
                              dispatch(
                                  PropDealDetailsActionCreator.cancelGoods());
                            },
                            child: Text(getText(name: 'textCancelSell')),
                            height: 39),
                      ),
                    if (isEdit)
                      MaterialButton(
                        height: 39,
                        onPressed: () {
                          dispatch(PropDealDetailsActionCreator.gotoEdit(
                              state.goodsId));
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
                      dispatch(PropDealDetailsActionCreator.gotoBuy());
                    },
                    height: 39,
                    minWidth: 300,
                    color: AppTheme.colors.themeColor,
                    child: Text(
                      getText(name: 'textBuyNow'),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
              ),
      )
    ],
  );
}

Widget buildGameItem(Goods goods, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 83,
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new HuoNetImage(
              imageUrl: goods.gameIcon,
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
                    goods.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${getText(name: 'textCurrencySymbol')}${goods.price}",
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

Widget buildDealDetailsItem(Goods goods, ViewService viewService) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildTextItem(getText(name: 'textDealWayColon'), getText(name: 'textGameGive')),
        buildTextItem(getText(name: 'textBelongGame'), goods.gameName),
        buildTextItem(getText(name: 'textServiceColon'), goods.serverName),
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
    onTap: () {
      dispatch(PropDealDetailsActionCreator.gotoGallery(index));
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
