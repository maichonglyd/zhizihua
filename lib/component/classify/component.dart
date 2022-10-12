import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ClassifyComponent extends Component<ClassifyState> {
  static final String componentName = "ClassifyComponent";

  ClassifyComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ClassifyState>(
                adapter: null, slots: <String, Dependent<ClassifyState>>{}),
            wrapper: keepAliveWrapper);
}
