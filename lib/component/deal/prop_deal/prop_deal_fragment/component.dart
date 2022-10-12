import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class PropDealFragment extends Component<PropDealFragmentState> {
  static final String componentName = "PropDealFragmentComponent";

  PropDealFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PropDealFragmentState>(
                adapter:
                    NoneConn<PropDealFragmentState>() + PropDealListAdapter(),
                slots: <String, Dependent<PropDealFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
