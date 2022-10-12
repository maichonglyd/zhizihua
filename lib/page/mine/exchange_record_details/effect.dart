import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<ExchangeRecordDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<ExchangeRecordDetailsState>>{
    ExchangeRecordDetailsAction.action: _onAction,
    ExchangeRecordDetailsAction.getDetailsData: _getDetailsData,
    Lifecycle.initState: _init,
    ExchangeRecordDetailsAction.copyNum: _copyNum,
  });
}

void _onAction(Action action, Context<ExchangeRecordDetailsState> ctx) {}

void _init(Action action, Context<ExchangeRecordDetailsState> ctx) {
  ctx.dispatch(ExchangeRecordDetailsActionCreator.getDetailsData());
}

void _getDetailsData(Action action, Context<ExchangeRecordDetailsState> ctx) {
  UserService.getExchangeRecordDetails(ctx.state.exchangeBean.orderId)
      .then((data) {
    if (data.code == 200) {
      ctx.dispatch(ExchangeRecordDetailsActionCreator.updateDetailData(data));
    }
  });
}

void _copyNum(Action action, Context<ExchangeRecordDetailsState> ctx) {
  showToast(getText(name: 'textCopySuccessful'));
  AppUtil.copyToClipboard(ctx.state.exchangeDetail.data.invoiceNo);
}
