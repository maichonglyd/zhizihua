import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameCoinSelectChannelState state, Dispatch dispatch,
    ViewService viewService) {
  return Material(
    color: Colors.transparent,
    child: Container(
        color: Color(0x33000000),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildChannelItem(),
              buildChannelItem(),
            ],
          ),
        )),
  );
}

Widget buildChannelItem() {
  return Container(
    height: 90,
    padding: EdgeInsets.only(left: 14.5, right: 14.5),
//    child: Row(
//      children: <Widget>[
//        Container(
//          width: 50,
//          height: 50,
//          child: HuoNetImage(
//            imageUrl: "",
//          ),
//        ),
//        Expanded(
//            child: Container(
//          margin: EdgeInsets.only(left: 16, right: 16),
//          child: Text(
//            "九游",
//            style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
//          ),
//        )),
//        Container(
//          margin: EdgeInsets.only(left: 16, right: 16),
//          child: Text(
//            "续充5.5折",
//            style:
//                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor3),
//          ),
//        ),
//        Container(
//          child: Text(
//            "首充10.0折",
//            style: TextStyle(fontSize: 12, color: Color(0xFFF35A58)),
//          ),
//        )
//      ],
//    ),
  );
}
