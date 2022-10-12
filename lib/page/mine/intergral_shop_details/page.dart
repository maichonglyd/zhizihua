import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntegralShopDetailsPage
    extends Page<IntegralShopDetailsState, Map<String, dynamic>> {
  static final String namePage = "IntegralShopDetailsPage";

  IntegralShopDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralShopDetailsState>(
              adapter: null,
              slots: <String, Dependent<IntegralShopDetailsState>>{}),
          middleware: <Middleware<IntegralShopDetailsState>>[],
          viewMiddleware: <ViewMiddleware<IntegralShopDetailsState>>[
            loadingRefreshViewMiddleware<IntegralShopDetailsState>(
                IntegralShopDetailsActionCreator.init()),
          ],
        );
}
