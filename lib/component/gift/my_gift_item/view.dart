import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyGiftItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 84,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      children: <Widget>[
        Expanded(
            child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(MyGiftItemActionCreator.gotoGiftDetails());
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    child: new HuoNetImage(
                      imageUrl: state.gift.gameIcon,
                      fit: BoxFit.cover,
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
                        "${state.gift.gameName}-${state.gift.title}",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.colors.textColor),
                      ),
                      Text(state.typeText,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFFF9666))),
                      Text(getText(name: 'textGiftCode2', args: [state.gift.giftCode]),
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.colors.textSubColor2))
                    ],
                  ),
                ),
                Container(
                  height: HuoDimens.buttonheight1,
                  width: HuoDimens.buttonWidth1,
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      dispatch(MyGiftItemActionCreator.copy());
                    },
                    child: Text(
                      getText(name: 'textCopy'),
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.themeColor),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(HuoDimens.buttonRadius)),
                      border: Border.all(color: AppTheme.colors.themeColor)),
                )
              ],
            ),
          ),
        )),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        )
      ],
    ),
  );
}
