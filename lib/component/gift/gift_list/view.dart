import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GiftListFragmentState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Expanded(
          child: state.refreshHelper.getEasyRefresh(
              state.gifts != null
                  ? ListView(
                      children: state.gifts
                          .asMap()
                          .keys
                          .map((index) => buildItem(
                              state.gifts[index], index, dispatch, viewService))
                          .toList(),
                    )
                  : Container(),
              controller: state.refreshHelperController, onRefresh: () {
        dispatch(GiftListFragmentActionCreator.getData(1));
      }, loadMore: (page) {
        dispatch(GiftListFragmentActionCreator.getData(page));
      }))
    ],
  );
}

Widget buildItem(
    Gift data, int index, Dispatch dispatch, ViewService viewService) {
  String buttonText = getText(name: 'textReceive');
  Color buttonColor = AppTheme.colors.themeColor;
  String typeText = getText(name: 'textNormalGift');

  switch (data.giftType) {
    case 1:
      typeText = getText(name: 'textNormalGift');
      break;
    case 2:
      typeText =
          getText(name: 'textPointsExchangeGift', args: [data.condition]);
      buttonText = getText(name: 'textExchange');
      break;
    case 3:
      typeText = getText(name: 'textGroupGift');
      break;
    case 4:
      typeText = getText(name: 'textRechargeGift', args: [data.condition]);
      buttonText = getText(name: 'textExchange');
      break;
  }

  if (data.remainCnt == 0) {
    buttonText = getText(name: 'textHasReceived');
    buttonColor = Color(0xffFFEDAB);
  }
  bool copy = data.giftCode.isNotEmpty;
  if (copy) {
    buttonText = getText(name: 'textCopy');
    buttonColor = AppTheme.colors.themeColor;
  }
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      dispatch(GiftListFragmentActionCreator.gotoGiftDetails(data));
    },
    child: Container(
      color: Colors.white,
      height: 85,
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                height: 60,
                width: 60,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: data.gameIcon,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 1),
                      child: Text(
                        data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.colors.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, bottom: 1),
                      child: Text(typeText,
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFFF9666))),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text(
                            data.giftCode.isNotEmpty
                                ? getText(name: 'textGiftCode', args: [data.giftCode])
                                : getText(name: 'textFinishDate', args: [AppUtil.formatDate1(data.endTime)]),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 11,
                                color: data.giftCode.isNotEmpty
                                    ? AppTheme.colors.themeColor
                                    : AppTheme.colors.textSubColor2)))
                  ],
                ),
              ),
              Container(
                height: 27,
                width: 55,
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    dispatch(GiftListFragmentActionCreator.addGift(data));
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 12, color: buttonColor),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    border: Border.all(color: buttonColor)),
              )
            ],
          )),
          Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          )
        ],
      ),
    ),
  );
}
