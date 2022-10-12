import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class GameDetailsGiftFragment extends Component<GameDetailsGiftFragmentState> {
  static final String componentName = "GameDetailsGiftFragment";
  GameDetailsGiftFragment()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsGiftFragmentState>(
              adapter:
                  NoneConn<GameDetailsGiftFragmentState>() + GiftListAdapter(),
              slots: <String, Dependent<GameDetailsGiftFragmentState>>{}),
        );
}
