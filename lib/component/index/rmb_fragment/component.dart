import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RmbFragmentComponent extends Component<RmbFragmentState> {
  static final String componentName = "rmd_fragment";
  static const String typeName = "rmd";

  RmbFragmentComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RmbFragmentState>(
              adapter: NoneConn<RmbFragmentState>() + RmbListAdapter(),
              slots: <String, Dependent<RmbFragmentState>>{}),
        );
}
