import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/component.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/record_list/component.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///我的游戏币记录
class MineCurrRecordPage
    extends Page<MineCurrRecordState, Map<String, dynamic>> {
  static final String pageName = "MineCurrRecordPage";

  MineCurrRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineCurrRecordState>(
              adapter: null,
              slots: <String, Dependent<MineCurrRecordState>>{
                "take_record":
                    TakeRecordConnector() + CurrRecordListComponent(),
                "use_record": UseRecordConnector() + CurrRecordListComponent(),
              }),
          middleware: <Middleware<MineCurrRecordState>>[],
        );
}
