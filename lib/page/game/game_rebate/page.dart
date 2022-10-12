import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRebatePage extends Page<GameRebateState, Map<String, dynamic>> {
  static final String pageName = "GameRebatePage";
  GameRebatePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameRebateState>(
                adapter: null,
                slots: <String, Dependent<GameRebateState>>{
                }),
            middleware: <Middleware<GameRebateState>>[
            ],);

}
