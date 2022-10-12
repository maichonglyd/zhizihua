import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

export 'state.dart';

class SearchBarComponent extends Component<SearchBarState> {
  SearchBarComponent()
      : super(
          view: buildView,
        );
}
