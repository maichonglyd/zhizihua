import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSpecialHeadState state, Dispatch dispatch, ViewService viewService) {
  return Container(
//    height: 208,
//    height: 189,
    height: 189,
    margin: EdgeInsets.only(top: 12),
    padding: EdgeInsets.only(
      left: 14,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(state, index, dispatch);
            },
            itemCount: state.gameSpecial.gameList.length,
          ),
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}

Widget buildItem(GameSpecialHeadState state, int index, Dispatch dispatch) {
  return GestureDetector(
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
//              height: 100,
//              height: 81,
              height: 108,
//              width: 145,
              width: 155,
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: ClipRRect(
                  child: HuoNetImage(
                    imageUrl:
//                    state.gameSpecial.gameList[index].appHotImage,
                        state.gameSpecial.gameList[index].pcHomeImgStyle2,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5), bottom: Radius.circular(0))),
            ),
            Container(
              height: 70,
//              width: 145,
              width: 155,

              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(5), top: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        offset: Offset(2.0, 1), //阴影xy轴偏移量
                        blurRadius: 10.0, //阴影模糊程度
                        spreadRadius: 0.0 //阴影扩散程度
                        )
                  ]),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 18, left: 4, right: 4),
                    child: Text(state.gameSpecial.gameList[index].gameName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: commonTextStyle(
                            AppTheme.colors.textColor, 15, FontWeight.w600)),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 4, left: 4, right: 4),
                      child: Text(state.gameSpecial.gameList[index].desc,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: commonTextStyle(AppTheme.colors.textSubColor,
                              11, FontWeight.normal))),
                ],
              ),
            ),
          ],
        ),
        Positioned(
//          top: 79,
          top: 87,
          left: 10,
          child: Container(
              height: 35,
              width: 35,
              child: ClipRRect(
                child: HuoNetImage(
                  imageUrl: state.gameSpecial.gameList[index].icon,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              )),
        )
      ],
    ),
    onTap: () {
      dispatch(MustPlayDailyActionCreator.gotoDetails(
          state.gameSpecial.gameList[index]));
    },
  );
}
