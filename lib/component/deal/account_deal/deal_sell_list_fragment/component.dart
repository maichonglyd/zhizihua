import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class DealSellListComponent extends Component<DealSellListState> {
  static final String componentName = "DealSellListComponent";

  DealSellListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DealSellListState>(
                adapter: NoneConn<DealSellListState>() + DealSellListAdapter(),
                slots: <String, Dependent<DealSellListState>>{}),
            wrapper: keepAliveWrapper);
}
