import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

//TODO replace with your own action
enum PropDealDetailsAction {
  action,
  gotoBuy,
  getGoodsDetails,
  updateData,
  gotoEdit,
  cancelGoods,
  gotoGallery,
  init,
  err,
}

class PropDealDetailsActionCreator {
  static Action onAction() {
    return const Action(PropDealDetailsAction.action);
  }

  static Action gotoGallery(int index) {
    return Action(PropDealDetailsAction.gotoGallery, payload: index);
  }

  static Action cancelGoods() {
    return const Action(PropDealDetailsAction.cancelGoods);
  }

  static Action gotoEdit(int goodsId) {
    return Action(PropDealDetailsAction.gotoEdit, payload: goodsId);
  }

  static Action gotoBuy() {
    return const Action(PropDealDetailsAction.gotoBuy);
  }

  static Action getGoodsDetails() {
    return const Action(PropDealDetailsAction.getGoodsDetails);
  }

  static Action updateData(Goods goods) {
    return Action(PropDealDetailsAction.updateData, payload: goods);
  }

  static Action init() {
    return Action(PropDealDetailsAction.init);
  }

  static Action err() {
    return Action(PropDealDetailsAction.err);
  }
}
