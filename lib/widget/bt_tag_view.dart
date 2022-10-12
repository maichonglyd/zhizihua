import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

const BtTagTypeRecharge = 1;
const BtTagTypeVip = 2;
const BtTagTypeRebate = 3;

bool shouldShowBtTag(List<BtTag> list, int isBt) {
  return null != list && list.length > 0 && 2 == isBt;
}

Widget buildBtTagView(List<BtTag> list) {
  Widget widget = Container();
  var imageWith = 13.0;
  if (null != list && list.length > 0) {
    List<Widget> widgetList = [];
    for (BtTag btTag in list) {
      Widget tagWidget;
      switch (btTag.id) {
        case BtTagTypeRecharge:
          tagWidget = Container(
            padding: EdgeInsets.only(right: 4),
            child: Row(
              children: [
                Image.asset(
                  "images/icon_circular_rechange.png",
                  width: imageWith,
                  height: imageWith,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    btTag.tag ?? '',
                    style: TextStyle(color: Color(0xFF45A9F0), fontSize: 11),
                  ),
                )
              ],
            ),
          );
          break;
        case BtTagTypeVip:
          tagWidget = Container(
            margin: EdgeInsets.only(right: 4),
            child: Row(
              children: [
                Image.asset(
                  "images/icon_circular_reward.png",
                  width: imageWith,
                  height: imageWith,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    btTag.tag ?? '',
                    style: TextStyle(color: Color(0xFFFEA000), fontSize: 11),
                  ),
                )
              ],
            ),
          );
          break;
        case BtTagTypeRebate:
          tagWidget = Container(
            margin: EdgeInsets.only(right: 4),
            child: Row(
              children: [
                Image.asset(
                  "images/icon_circular_discount.png",
                  width: imageWith,
                  height: imageWith,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    btTag.tag ?? '',
                    style: TextStyle(color: Color(0xFFFF4646), fontSize: 11),
                  ),
                )
              ],
            ),
          );
          break;
      }
      widgetList.add(tagWidget);
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgetList,
      ),
    );
  }
  return widget;
}
