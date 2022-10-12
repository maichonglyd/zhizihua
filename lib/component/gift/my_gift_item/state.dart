import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

class MyGiftItemState implements Cloneable<MyGiftItemState> {
  Gift gift;
  String typeText = getText(name: 'textVirtualGoods');
  @override
  MyGiftItemState clone() {
    return MyGiftItemState()..gift = gift;
  }
}

MyGiftItemState initState(Gift gift) {
  String typeText = getText(name: 'textVirtualGoods');

  switch (gift.giftType) {
    case 1:
      typeText = getText(name: 'textNormalGift');
      break;
    case 2:
      typeText = getText(name: 'textPointsExchangeGift', args: [gift.condition]);
      break;
    case 3:
      typeText = getText(name: 'textGroupGift');
      break;
    case 4:
      typeText = getText(name: 'textRechargeGift', args: [gift.condition]);
      break;
  }
  return MyGiftItemState()
    ..gift = gift
    ..typeText = typeText;
}
