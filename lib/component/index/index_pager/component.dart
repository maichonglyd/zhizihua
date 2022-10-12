import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexViewPagerComponent extends Component<IndexViewPagerState> {
  IndexViewPagerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexViewPagerState>(
              adapter: null, slots: <String, Dependent<IndexViewPagerState>>{}),
        );
}
