import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexDealItemState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dispatch(IndexDealItemActionCreator.gotoDealDetails());
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 94,
                    width: 130,
                    child: ClipRRect(
                      child: new HuoNetImage(
                        imageUrl: state.dealGoods.image.length > 0
                            ? state.dealGoods.image[0]
                            : "",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),

//                  Positioned(
//                    bottom: 0,
//                    left: 0,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 10, right: 10),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.only(
//                              topRight: Radius.circular(4),
//                              bottomLeft: Radius.circular(4)),
//                          gradient: LinearGradient(colors: [
//                            Color(0xFFFF9356),
//                            Color(0xFFFF5D45),
//                          ])),
//                      child: Text(
//                        "水浒Q传",
//                        style: TextStyle(color: Colors.white, fontSize: 12),
//                      ),
//                    ),
//                  ),
                ],
              ),
              Container(
                height: 94,
                width: 192,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      state.dealGoods.title,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.colors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.dealGoods.description,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 6, right: 6),
                          decoration: BoxDecoration(
                              color: Color(0xFFE6F4FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Text(
                            state.dealGoods.gameName,
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF008FFF)),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "${getText(name: 'textCurrencySymbol')}${state.dealGoods.price}",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFFF3300)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        height: 1,
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}
