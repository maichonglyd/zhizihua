import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GiftItemState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      dispatch(GiftItemActionCreator.gotoGiftDetails());
    },
    child: Container(
      height: 73,
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.gift.title,
                      style: TextStyle(
                          fontSize: 14, color: AppTheme.colors.textColor),
                    ),
                    Text(state.typeText,
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFFFF9666))),
                    Text(
                        state.gift.giftCode.isNotEmpty
                            ? getText(name: 'textGiftCode')
                            : state.gift.content,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11,
                            color: state.gift.giftCode.isNotEmpty
                                ? AppTheme.colors.themeColor
                                : AppTheme.colors.textSubColor2))
                  ],
                ),
              ),
              Container(
                height: HuoDimens.buttonheight1,
                width: HuoDimens.buttonWidth1,
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    dispatch(GiftItemActionCreator.addGift());
                  },
                  child: Text(
                    state.buttonText,
                    style: TextStyle(fontSize: 12, color: state.buttonColor),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(HuoDimens.buttonRadius)),
                    border: Border.all(color: state.buttonColor)),
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
