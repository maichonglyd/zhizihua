import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewGameFragmentComponent extends Component<NewGameFragmentState> {
  static final String componentName = "new_game_fragment";
  static const String typeName = "new";
  NewGameFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NewGameFragmentState>(
                adapter: NoneConn<NewGameFragmentState>() + NewGameAdapter(),
                slots: <String, Dependent<NewGameFragmentState>>{
                }),);

}
