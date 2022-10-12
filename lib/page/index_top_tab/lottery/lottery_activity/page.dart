import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LotteryActivityPage extends Page<LotteryActivityState, Map<String, dynamic>> {
  static final String pageName = "LotteryActivityPage";
  LotteryActivityPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LotteryActivityState>(
                adapter: null,
                slots: <String, Dependent<LotteryActivityState>>{
                }),
            middleware: <Middleware<LotteryActivityState>>[
            ],);

}
