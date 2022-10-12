import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealOrderDetailsPage
    extends Page<PropDealOrderDetailsState, Map<String, dynamic>> {
  static final String pageName = "PropDealOrderDetailsPage";
  PropDealOrderDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PropDealOrderDetailsState>(
                adapter: null,
                slots: <String, Dependent<PropDealOrderDetailsState>>{}),
            middleware: <Middleware<PropDealOrderDetailsState>>[],
            viewMiddleware: <ViewMiddleware<PropDealOrderDetailsState>>[
              loadingRefreshViewMiddleware<PropDealOrderDetailsState>(
                  PropDealOrderDetailsActionCreator.init()),
            ]);
}
