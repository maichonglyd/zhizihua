import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class DownLoadGameListComponent extends Component<DownLoadGameListState>
    with PrivateReducerMixin<DownLoadGameListState> {
  static final String componentName = "DownLoadGameListComponent";

  DownLoadGameListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DownLoadGameListState>(
                adapter: NoneConn<DownLoadGameListState>() +
                    DownloadGameListAdapter(),
                slots: <String, Dependent<DownLoadGameListState>>{}),
            wrapper: keepAliveWrapper);
}
