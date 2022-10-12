import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/list_Adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HbFragmentComponent extends Component<HbFragmentState> {
  static final String componentName = "hb_fragment";
  static const String typeName = "rp";

  HbFragmentComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HbFragmentState>(
              adapter: NoneConn<HbFragmentState>() + HbListAdapterAdapter(),
              slots: <String, Dependent<HbFragmentState>>{}),
        );
}
