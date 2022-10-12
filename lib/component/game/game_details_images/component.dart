import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameDetailsImagesComponent extends Component<GameDetailsImagesState> {
  static final String componentName = "GameDetailsImagesComponent";

  GameDetailsImagesComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsImagesState>(
              adapter: null,
              slots: <String, Dependent<GameDetailsImagesState>>{}),
        );
}
