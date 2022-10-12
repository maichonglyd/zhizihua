import 'package:fish_redux/fish_redux.dart';
import 'package:video_player/video_player.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VideoPlayPage extends Page<VideoPlayState, Map<String, dynamic>> {
  static final String pageName = "VideoPlayPage";
  static bool isCurrent = false;

  VideoPlayPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<VideoPlayState>(
              adapter: null, slots: <String, Dependent<VideoPlayState>>{}),
          middleware: <Middleware<VideoPlayState>>[],
        );
}
