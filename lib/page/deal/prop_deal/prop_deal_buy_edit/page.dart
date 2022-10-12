import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealBuyPage extends Page<PropDealBuyState, Goods> {
  static final String pageName = "PropDealBuyPage";
  PropDealBuyPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealBuyState>(
              adapter: null, slots: <String, Dependent<PropDealBuyState>>{}),
          middleware: <Middleware<PropDealBuyState>>[],
        );
}
