import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RewardDetailPage extends Page<RewardDetailState, Map<String, dynamic>> {
  static final String pageName = "RewardDetailPage";
  RewardDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<RewardDetailState>(
                adapter: null,
                slots: <String, Dependent<RewardDetailState>>{
                }),
            middleware: <Middleware<RewardDetailState>>[
            ],);

}
