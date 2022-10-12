import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealSellListState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return state.refreshHelper.getEasyRefresh(
    ListView.builder(
      itemBuilder: (context, index) {
        return buildItem(
            state, dispatch, viewService, context, listAdapter, index);
      },
      itemCount: listAdapter.itemCount,
    ),
    onRefresh: () {
      dispatch(DealSellListActionCreator.onLoadData(1));
    },
    loadMore: (page) {
      dispatch(DealSellListActionCreator.onLoadData(page));
    },
    controller: state.refreshHelperController,
  );
}

Widget buildItem(
    DealSellListState state,
    Dispatch dispatch,
    ViewService viewService,
    BuildContext context,
    ListAdapter listAdapter,
    int index) {
  Widget statusText = Text(getText(name: 'textUnderReview'));
  bool isEdit = false;
  bool isCancel = false;
  switch (state.dealGoodsList[index].status) {
    case 1: //审核中
      statusText = Text(
        getText(name: 'textUnderReview'),
        style: TextStyle(color: AppTheme.colors.checkingColor, fontSize: 13),
      );
      break;
    case 2: //已上架
      statusText = Text(
        getText(name: 'textOnShelf'),
        style: TextStyle(color: AppTheme.colors.checkOkColor, fontSize: 13),
      );
      isEdit = true;
      isCancel = true;
      break;
    case 3: //已下架
      statusText = Text(
        getText(name: 'textOffShelf'),
        style: TextStyle(color: AppTheme.colors.sellOKColor, fontSize: 13),
      );
      isEdit = true;
      break;
    case 4: //已出售
      statusText = Text(
        getText(name: 'textSold'),
        style: TextStyle(color: AppTheme.colors.sellOKColor, fontSize: 13),
      );
      break;
    case 5: //审核不通过
      statusText = Text(
        getText(name: 'textFailedToPassTheAudit'),
        style: TextStyle(color: AppTheme.colors.checkFailColor, fontSize: 13),
      );
      isEdit = true;
      isCancel = false;
      break;
    case 6: //锁定（有人正在支付中，显示已上架，但是点击修改或者下架提示）
      statusText = Text(
        getText(name: 'textOnShelf'),
        style: TextStyle(color: AppTheme.colors.checkOkColor, fontSize: 13),
      );
      isEdit = true;
      isCancel = true;
      break;
  }

  return Column(
    children: <Widget>[
      Container(
        child: listAdapter.itemBuilder(context, index),
      ),
      Container(
        color: AppTheme.colors.lineColor,
        height: 1,
      ),
      Container(
        height: 43,
        margin: EdgeInsets.only(left: 14, right: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: statusText,
            ),
            if (isEdit)
              Container(
                height: 24,
                width: 50,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    border: Border.all(color: Color(0xFF999999))),
                child: MaterialButton(
                  onPressed: () {
                    viewService.broadcast(
                        IndexDealFragmentActionCreator.onGotoSellEdit(
                            state.dealGoodsList[index].goodsId,
                            state.dealGoodsList[index].status));
                  },
                  padding: EdgeInsets.all(0),
                  child: Text(
                    getText(name: 'textModify'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor2),
                  ),
                ),
              ),
            if (isCancel)
              Container(
                height: 24,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    border: Border.all(color: Color(0xFF999999))),
                child: MaterialButton(
                  onPressed: () {
                    viewService.broadcast(
                        IndexDealFragmentActionCreator.onCancel(
                            state.dealGoodsList[index].goodsId,
                            state.dealGoodsList[index].status));
                  },
                  padding: EdgeInsets.all(0),
                  child: Text(
                    getText(name: 'textOffTheShelf'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor2),
                  ),
                ),
              )
          ],
        ),
      ),
      SplitLine(),
    ],
  );
}
