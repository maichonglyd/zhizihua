import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealSellRecordState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> items = List();
  for (Goods goods in state.goodsList) {
    items.add(SplitLine());
    items.add(buildItem(goods, dispatch, viewService));
  }
  items.add(SplitLine());
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textSale')),
      elevation: 0,
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: items,
        ), onRefresh: () {
      dispatch(PropDealSellRecordActionCreator.getSellRecord(1));
    }, loadMore: (page) {
      dispatch(PropDealSellRecordActionCreator.getSellRecord(page));
    }, controller: state.refreshHelperController),
  );
}

Widget buildItem(Goods goods, Dispatch dispatch, ViewService viewService) {
  TextSpan statusText;
  bool isEdit = false;
  bool isCancel = false;
  if (goods != null) {
    switch (goods.status) {
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
                goods.gameName,
                style: TextStyle(
                    color: AppTheme.colors.textSubColor, fontSize: 12),
              ),
            ),
            if (isCancel)
              GestureDetector(
                onTap: () {
                  dispatch(PropDealSellRecordActionCreator.cancelGoods(
                      goods.goodsId));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 50,
                  margin: EdgeInsets.only(left: 9, right: 9),
                  child: Text(
                    "下架",
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
            if (isEdit)
              GestureDetector(
                onTap: () {
                  dispatch(
                      PropDealSellRecordActionCreator.gotoEdit(goods.goodsId));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 50,
                  margin: EdgeInsets.only(left: 9),
                  child: Text(
                    "修改",
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
                  imageUrl: goods.gameIcon,
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
                  goods.title,
                  style: TextStyle(
                      color: AppTheme.colors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "¥${goods.price}",
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
                  RichText(
                      text: TextSpan(children: [
                    statusText,
                  ]))
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
