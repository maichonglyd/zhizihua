import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';



class IndexTopTabComponent extends Component<IndexTopTabComponentState> {
  static final String componentName = "IndexTopTabComponent";
  IndexTopTabComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexTopTabComponentState>(
                adapter: null,
                slots: <String, Dependent<IndexTopTabComponentState>>{
                }),);

}
