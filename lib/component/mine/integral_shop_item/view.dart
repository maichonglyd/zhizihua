import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IntegralShopItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 135,
    margin: EdgeInsets.only(left: 6, right: 6),
    decoration: BoxDecoration(
        color: Colors.white,
        border: new Border.all(width: 0.5, color: Color(0xffEEEEEE)),
        borderRadius: BorderRadius.all(Radius.circular(9))),
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        dispatch(IntegralShopItemActionCreator.gotoShopDetails());
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.maxFinite,
            color: Color(0xffF8F8F8),
            child: ClipRRect(
              child: new HuoNetImage(
                  imageUrl: state.goods.originalImg, fit: BoxFit.fill),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 2, left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            state.goods.goodsName,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.colors.textColor),
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(getText(name: 'textNumberIntegral', args: [state.goods.integral]),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.colors.themeColor)),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(getText(name: 'textSurplus'),
                                      style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              AppTheme.colors.textSubColor2)),
                                  LimitedBox(
                                    maxWidth: 50,
                                    child: Text("${state.goods.remainCnt} ",
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                AppTheme.colors.textSubColor2)),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
//                    Container(
//                      height: 30,
//                      width: 52,
//                      child: MaterialButton(
//                        padding: EdgeInsets.all(0),
//                        onPressed: () {
//                          dispatch(IntegralShopItemActionCreator.exchangeGoods());
//                        },
//                        child: Text(
//                          state.buttonText,
//                          style: TextStyle(
//                              fontSize: 12, color: state.buttonColor),
//                        ),
//                      ),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(4)),
//                          border: Border.all(color: state.buttonColor)),
//                    )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
