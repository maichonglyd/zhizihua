import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LotteryRewardPage extends Page<LotteryRewardState, Map<String, dynamic>> {
  static final String pageName = "LotteryRewardPage";
  LotteryRewardPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LotteryRewardState>(
                adapter: null,
                slots: <String, Dependent<LotteryRewardState>>{
                }),
            middleware: <Middleware<LotteryRewardState>>[
            ],);

}
