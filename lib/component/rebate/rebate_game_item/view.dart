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
    RebateGameItemState state, Dispatch dispatch, ViewService viewService) {
  String sizeString =
      "${state.rebateGame.gameSize} ${state.rebateGame.types.length <= 0 ? "" : "|"} ${state.rebateGame.types.length > 0 ? state.rebateGame.types[0] : ""}";

  return Container(
    height: 84,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 60,
                width: 60,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: state.rebateGame.gameIcon,
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
                      state.rebateGame.gameName,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.colors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(sizeString,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.colors.textSubColor2)),
                    Text(getText(name: 'textApplicationRebateNumber', args: [state.rebateGame.amount]),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11, color: AppTheme.colors.textSubColor2))
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 52,
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    dispatch(RebateGameItemActionCreator.gotoRebateCommit());
                  },
                  child: Text(
                    getText(name: 'textApply'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.themeColor),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: AppTheme.colors.themeColor)),
              ),
            ],
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
