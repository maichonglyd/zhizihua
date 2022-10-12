import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameNewNoticePage extends Page<GameNewNoticeState, Map<String, dynamic>> {
  static final String pageName = "GameNewNoticePage";

  GameNewNoticePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameNewNoticeState>(
                adapter: null,
                slots: <String, Dependent<GameNewNoticeState>>{
                }),
            middleware: <Middleware<GameNewNoticeState>>[
            ],);

}
