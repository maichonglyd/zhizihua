import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UpdateMobilePage extends Page<UpdateMobileState, String> {
  static final String pageName = "UpdateMobilePage";
  UpdateMobilePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<UpdateMobileState>(
              adapter: null, slots: <String, Dependent<UpdateMobileState>>{}),
          middleware: <Middleware<UpdateMobileState>>[],
        );
}
