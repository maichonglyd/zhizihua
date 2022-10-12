import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MessageListPage extends Page<MessageListState, Map<String, dynamic>> {
  static final String pageName = "MessageListPage";
  MessageListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MessageListState>(
              adapter: null, slots: <String, Dependent<MessageListState>>{}),
          middleware: <Middleware<MessageListState>>[],
        );
}
