import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexEmptyBottomComponent extends Component<IndexEmptyBottomState> {
  static final String componentName = "IndexEmptyBottomComponent";

  IndexEmptyBottomComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexEmptyBottomState>(
                adapter: null,
                slots: <String, Dependent<IndexEmptyBottomState>>{
                }),);

}
