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
    PropDealItemState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          dispatch(PropDealItemActionCreator.gotoDetails());
        },
        child: Container(
          height: 121,
          padding: EdgeInsets.only(left: 14, right: 14),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                state.goods.gameName,
                style: TextStyle(
                    color: AppTheme.colors.textSubColor, fontSize: 12),
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
                        imageUrl: state.goods.gameIcon,
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
                        state.goods.title,
                        style: TextStyle(
                            color: AppTheme.colors.textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "¥${state.goods.price}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFFF3300),
                        ),
                      )
                    ],
                  )),
                  GestureDetector(
                    onTap: () {
                      dispatch(PropDealItemActionCreator.gotoDetails());
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppTheme.colors.themeColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        getText(name: 'textToBought'),
                        style: TextStyle(
                          color: AppTheme.colors.themeColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      SplitLine()
    ],
  );
}
