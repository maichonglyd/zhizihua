import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/effect.dart';
import 'view.dart';
import 'state.dart';

class IndexBannerComponent extends Component<IndexBannerState> {
  static final String componentName = "IndexBannerComponent";

  IndexBannerComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
        );
}
