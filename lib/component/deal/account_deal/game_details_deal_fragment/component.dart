import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class GameDetailsDealFragment extends Component<GameDetailsDealFragmentState> {
  static final String componentName = "GameDetailsDealFragmentComponent";
  GameDetailsDealFragment()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsDealFragmentState>(
              adapter:
                  NoneConn<GameDetailsDealFragmentState>() + DealListAdapter(),
              slots: <String, Dependent<GameDetailsDealFragmentState>>{
                IndexRowGameComponent.componentName:
                    RowGameConnector() + IndexRowGameComponent()
              }),
        );
}
