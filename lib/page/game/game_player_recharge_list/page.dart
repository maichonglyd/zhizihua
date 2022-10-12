import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GamePlayerRechargeListPage extends Page<GamePlayerRechargeListState, Map<String, dynamic>> {
  static final String pageName = "GamePlayerRechargeListPage";
  GamePlayerRechargeListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GamePlayerRechargeListState>(
                adapter: null,
                slots: <String, Dependent<GamePlayerRechargeListState>>{
                }),
            middleware: <Middleware<GamePlayerRechargeListState>>[
            ],);

}
