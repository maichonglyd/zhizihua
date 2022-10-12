import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DownLoadManagePage
    extends Page<DownLoadManageState, Map<String, dynamic>> {
  static final String pageName = "DownLoadManagePage";
  DownLoadManagePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DownLoadManageState>(
              adapter: null,
              slots: <String, Dependent<DownLoadManageState>>{
                "DownLoadComplete":
                    DownLoadCompleteConnector() + DownLoadGameListComponent(),
                "DownLoading":
                    DownLoadingConnector() + DownLoadGameListComponent(),
                "Reserved": ReservedConnector() + DownLoadGameListComponent(),
              }),
          middleware: <Middleware<DownLoadManageState>>[],
        );
}
