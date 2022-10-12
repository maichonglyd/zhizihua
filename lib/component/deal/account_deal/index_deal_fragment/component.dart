import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class IndexDealFragment extends Component<IndexDealFragmentState> {
  static final String componentName = "IndexDealFragment";
  IndexDealFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexDealFragmentState>(
                adapter:
                    NoneConn<IndexDealFragmentState>() + IndexDealAdapter(),
                slots: <String, Dependent<IndexDealFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
