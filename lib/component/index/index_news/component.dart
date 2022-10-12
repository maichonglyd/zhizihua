import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexNewsComponent extends Component<IndexNewsState> {
  static final String componentName = "IndexNewsComponent";
  IndexNewsComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexNewsState>(
              adapter: null, slots: <String, Dependent<IndexNewsState>>{}),
        );
}
