import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class KaifuGamePage extends Page<KaifuGameState, Map<String, dynamic>> {
  static final String pageName = "KaifuGamePage";
  KaifuGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<KaifuGameState>(
              adapter: null,
              slots: <String, Dependent<KaifuGameState>>{
                'kf_fragment': KfFragmentConnector() + KfFragment(),
              }),
          middleware: <Middleware<KaifuGameState>>[],
        );
}
