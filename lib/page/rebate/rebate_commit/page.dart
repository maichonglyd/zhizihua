import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///提交申请页面
class RebateCommitPage extends Page<RebateCommitState, RebateGame> {
  static final String pageName = "RebateCommitPage";
  RebateCommitPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RebateCommitState>(
              adapter: null, slots: <String, Dependent<RebateCommitState>>{}),
          middleware: <Middleware<RebateCommitState>>[],
        );
}
