import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/page.dart';
import 'package:flutter_huoshu_app/widget/down/down_view2.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget buildView(
    GameCurrItemState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        height: 75,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
//      child: new HuoNetImage(
//        imageUrl: "",
//        height: 50,
//        width: 50,
//        fit: BoxFit.cover,
//      ),
              child: Image.network(
                state.game.icon ?? "",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        state.game.gameName ?? "",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.colors.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        state.game.classifyLabel ?? "",
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.textSubColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      "${state.game.remain}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF3C3C)),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 23,
                      width: 58,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: AppTheme.colors.lineColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Text(
                        getText(name: 'textLookHistory'),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.textSubColor),
                      ),
                    ),
                    onTap: () {
                      AppUtil.gotoPageByName(
                          viewService.context, MineCurrRecordPage.pageName,
                          arguments: {"gameId": state.game.gameId});
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        height: 1,
        color: AppTheme.colors.lineColor,
        width: double.infinity,
      )
    ],
  );
}
