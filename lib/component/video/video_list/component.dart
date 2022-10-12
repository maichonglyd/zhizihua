import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/component/video/video_list/effect.dart';
import 'package:flutter_huoshu_app/component/video/video_list/reducer.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/component/video/video_list/view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class VideoComponent extends Component<VideoState> {
  static final String componentName = "VideoComponent";
  VideoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VideoState>(
                adapter: null, slots: <String, Dependent<VideoState>>{}),
            wrapper: keepAliveWrapper);
}
