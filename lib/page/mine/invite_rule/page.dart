import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class InviteRulePage extends Page<InviteRuleState, String> {
  static final String pageName = "InviteRulePage";
  InviteRulePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<InviteRuleState>(
              adapter: null, slots: <String, Dependent<InviteRuleState>>{}),
          middleware: <Middleware<InviteRuleState>>[],
        );
}
