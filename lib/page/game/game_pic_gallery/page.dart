import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GalleryPage extends Page<GalleryState, Map<String, dynamic>> {
  static final String pageName = "GalleryPage";
  GalleryPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GalleryState>(
              adapter: null, slots: <String, Dependent<GalleryState>>{}),
          middleware: <Middleware<GalleryState>>[],
        );
}
