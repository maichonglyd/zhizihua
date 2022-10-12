import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<CouponCenterState> buildEffect() {
  return combineEffects(<Object, Effect<CouponCenterState>>{
    Lifecycle.initState: _init,
    CouponCenterAction.getData: _getData,
    CouponCenterAction.searchCoupon: _searchCoupon,
    CouponCenterAction.obtainCoupon: _obtainCoupon,
  });
}

void _init(Action action, Context<CouponCenterState> ctx) {
  ctx.dispatch(CouponCenterActionCreator.getData(1));
}

void _getData(Action action, Context<CouponCenterState> ctx) {
  int page = action.payload;
  String gameName = '';
  if (null != ctx.state.contentController &&
      null != ctx.state.contentController.text &&
      ctx.state.contentController.text.isNotEmpty) {
    gameName = ctx.state.contentController.text;
  }
  CouponService.getCouponCenter(page: page, gameName: gameName).then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list, ctx.state.gameCouponList, page);
      ctx.dispatch(CouponCenterActionCreator.updateData(newData));
    }
  });
}

void _searchCoupon(Action action, Context<CouponCenterState> ctx) {
  String searchText = ctx.state.contentController.text;
  if (searchText.isEmpty) {
    showToast(getText(name: 'hintPleaseInputCouponGameName'));
    return;
  }

  int page = 1;
  CouponService.getCouponCenter(page: page, gameName: searchText).then((data) {
    if (200 == data.code) {
      List<CouponCenter> emptyData = [];
      var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list, emptyData, page);
      ctx.dispatch(CouponCenterActionCreator.updateData(newData));
    }
  });
}

void _obtainCoupon(Action action, Context<CouponCenterState> ctx) {
  int id = action.payload;
  if (null != id) {
    CouponService.obtainCouponCenter(id: id).then((data) {
      if (200 == data.code) {
        showToast(getText(name: 'textPleaseGoToCardToSee'));
        ctx.broadcast(CouponCenterActionCreator.getData(1));
      }
    });
  }
}

