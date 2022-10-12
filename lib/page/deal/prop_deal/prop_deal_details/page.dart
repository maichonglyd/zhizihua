import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealDetailsPage extends Page<PropDealDetailsState, int> {
  static final String pageName = "PropDealDetailsPage";
  PropDealDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealDetailsState>(
              adapter: null,
              slots: <String, Dependent<PropDealDetailsState>>{}),
          middleware: <Middleware<PropDealDetailsState>>[],
          viewMiddleware: <ViewMiddleware<PropDealDetailsState>>[
            loadingRefreshViewMiddleware<PropDealDetailsState>(
                PropDealDetailsActionCreator.init()),
          ],
        );
}
