import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DownloadGameItemComponent extends Component<DownloadGameItemState> {
  static final String componentName = "BTGameItemComponent";
  DownloadGameItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DownloadGameItemState>(
              adapter: null, slots: <String, Dependent<DownloadGameItemState>>{}),
        );
}
