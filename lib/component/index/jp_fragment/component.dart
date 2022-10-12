import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class JpFragmentComponent extends Component<JpFragmentState> {
  static const String typeName = "jp";
  static final String componentName = "jp_fragment";

  JpFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<JpFragmentState>(
                adapter: NoneConn<JpFragmentState>() + JpAdapter(),
                slots: <String, Dependent<JpFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
